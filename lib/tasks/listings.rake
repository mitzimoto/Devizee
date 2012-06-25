require 'net/ftp'
require 'fileutils'
require 'timeout'

default_filenames = {
    'Agent'     => 'data/agents/agents.txt',
    'Area'      => 'data/areas/areas.txt',
    'County'    => 'data/counties/counties.txt',
    'Office'    => 'data/offices/offices.txt',
    'Town'      => 'data/towns/towns.txt',
    'Bizopp'    => 'data/biz/idx_bu.txt',
    'Condo'     => 'data/condos/idx_cc.txt',
    'Commercial'=> 'data/commercial/idx_ci.txt',
    'Land'      => 'data/land/idx_ld.txt',
    'MultiFamily'=> 'data/multifam/idx_mf.txt',
    'MobileHome'=> 'data/mobile/idx_mh.txt',
    'Rental'    => 'data/rentals/idx_rn.txt',
    'Sfprop'    => 'data/sfprops/idx.txt'
}

def die(message)
    puts message
    exit 1
end

namespace :listings do
  desc 'Build the category tree'
  task :load, [:table, :file, :truncate] => :environment do |t, args|

    table = args[:table]        || die("You must specify a table to load!")

    #make sure the table we get actually exists
    default_filenames[table]    || die("Unknown table!: #{table}")
    filename = args[:file]      || default_filenames[table]
    truncate = args[:truncate]	|| 0

    #open the file
    file = File.new(filename)   || die("Error opening #{filename}: #{$!}")

    #The first line of the .txt file is the header, split it on |
    line = file.gets
    headers = line.split('|')

    #Get rid of the weird newline in the last element
    headers.last.gsub!("\r\n", '')

    Table = table.constantize

    #Truncate the table. This is subject to change
    if truncate == "true"
    	puts "Truncating table..."
	Table.empty_all
    end

    Table.fix_headers(headers)

    ActiveRecord::Base.transaction do #This makes inserts waaaaaay faster. 

        while(line = file.gets)
            #puts line
            data = line.split('|')
            options = Hash.new
    
            data.each_with_index do |value, index|
     
                next if headers[index] == 'PROP_TYPE'

                #get rid of the newline on the last element
                value.chomp!

                #replace empty values with null
                value = nil if value == ''

                options[:"#{headers[index].downcase}"] = value

            end

	        #puts options
            Table.addnew options

        end

    end

    file.close
  end

  desc 'Purge entries that are no longer listed'
  task :remove, [:table, :file] => :environment do |t, args|

        table = args[:table]        || die("You must specify a table to load!")

        default_filenames[table]    || die("Unknown table!: #{table}")
        filename = args[:file]      || die("you must specify a file!")

        file = File.new(filename)   || die("Error opening #{filename}: #{$!}")

        Table = table.constantize

        ActiveRecord::Base.transaction do
            while(line = file.gets)
                data = line.split('|')
                id = data[1]
                record = Listing.destroy(id)
            end
        end

        file.close

  end

  desc 'Download images from the MLS via RETS'
  task :rets, [:page] => :environment do |t,args|
    client = RETS::Client.login(    :url => "http://rets.mlspin.com/login/index.asp",
                                    :username => "CT002681",
                                    :password => "kXTJVPQt" )

    client.get_object(:resource => :Property, :type => :Photo, :location => false, :id => "71298692:0") { |object|
        puts object[:content]
    }
  end

  desc 'Download images from the MLS'
  task :photo, [:page] => :environment do |t,args|
	#DEPRECIATED!
        imgdir = "app/assets/images/mls"
        listings = Listing.order("id DESC").paginate(:page => args[:page], :per_page => 100)

        ftp = Net::FTP.new('ftp.mlspin.com')
        ftp.login

        listings.each do |listing|

            filename = Listing.get_photo_url listing.list_no, 0
            puts "[page #{args[:page]}] Downloading #{filename}"

            if listing.photo_count < 1
                FileUtils.cp("app/assets/images/photo-not-available.jpeg", "#{imgdir}/#{filename}" )
                next
            end

            next if File.exists?("#{imgdir}/#{filename}") and !File.zero?("#{imgdir}/#{filename}")

            dirname = File.dirname(filename)
            basename = File.basename(filename)

            %x[ mkdir -p "#{imgdir}/#{dirname}" ]

            retries = 0

            begin
                Timeout.timeout(2) do
                    ftp.getbinaryfile("#{dirname}/#{basename}", "#{imgdir}/#{filename}")
                end
            rescue 
                puts "Failed to get #{dirname}/#{basename}"
                File.unlink("#{imgdir}/#{filename}") if File.exists?("#{imgdir}/#{filename}")
                #FileUtils.cp("app/assets/images/photo-not-available.jpeg", "#{imgdir}/#{filename}" )
                if retries < 5
                    puts "Waiting 2 seconds to retry #{retries}/5"
                    sleep 2
                    ftp.login if ftp.closed?()
                    retries += 1
                    retry
                else
                    ftp.close
                    ftp.login if ftp.closed?()
                    puts "Too many retries, reconnecting"
                    retries += 1
                    if retries < 7
                        retry
                    else
                        print "I give up"
                    end
                end
            end

            begin
                ftp.login if ftp.closed?()
            rescue
                puts "Connection closed and can't login..."
                sleep 30
                retry
            end

        end

        ftp.close
  end    


end
