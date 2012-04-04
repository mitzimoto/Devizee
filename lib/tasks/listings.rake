require 'net/ftp'
require 'fileutils'

default_filenames = {
    'Agent'     => 'data/agents.txt',
    'Area'      => 'data/areas.txt',
    'County'    => 'data/counties.txt',
    'Office'    => 'data/offices.txt',
    'Town'      => 'data/towns.txt',
    'Bizopp'    => 'data/idx_bu.txt',
    'Condo'     => 'data/idx_cc.txt',
    'Commercial'=> 'data/idx_ci.txt',
    'Land'      => 'data/idx_ld.txt',
    'MultiFamily'=> 'data/idx_mf.txt',
    'MobileHome'=> 'data/idx_mh.txt',
    'Rental'    => 'data/idx_rn.txt',
    'Sfprop'    => 'data/idx.txt'
}

def die(message)
    puts message
    exit 1
end

namespace :listings do
  desc 'Build the category tree'
  task :load, [:table, :file] => :environment do |t, args|

    table = args[:table]        || die("You must specify a table to load!")

    #make sure the table we get actually exists
    default_filenames[table]    || die("Unknown table!: #{table}")
    filename = args[:file]      || default_filenames[table]

    #open the file
    file = File.new(filename)   || die("Error opening #{filename}: #{$!}")

    #The first line of the .txt file is the header, split it on |
    line = file.gets
    headers = line.split('|')

    #Get rid of the weird newline in the last element
    headers.last.gsub!("\r\n", '')

    Table = table.constantize

    Table.fix_headers(headers)

    Table.transaction do #This makes inserts waaaaaay faster. 

        while(line = file.gets)
            puts line
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

            Table.create(options)

        end

    end

    file.close
  end

  desc 'Download images from the MLS'
  task :photo, [:page] => :environment do |t,args|

        imgdir = "app/assets/images/mls"
        listings = Listing.paginate(:page => args[:page], :per_page => 10)

        ftp = Net::FTP.new('ftp.mlspin.com')
        ftp.login
        ftp.debug_mode = true

        listings.each do |listing|

            #If there are no photos, then there's not nee to do anything
            #next if listing.photo_count < 1

            filename = Listing.get_photo_url listing.list_no, 0
            puts filename
            next if File.exists?("#{imgdir}/#{filename}") and !File.zero?("#{imgdir}/#{filename}")

            dirname = File.dirname(filename)
            basename = File.basename(filename)

            %x[ mkdir -p "#{imgdir}/#{dirname}" ]

            begin
                ftp.chdir("/#{dirname}")
                ftp.getbinaryfile(basename, "#{imgdir}/#{filename}")
            rescue 
                puts "Failed to get #{dirname}/#{basename}"
                File.unlink("#{imgdir}/#{filename}") if File.exists?("#{imgdir}/#{filename}")
                FileUtils.cp("app/assets/images/photo-not-available.jpeg", "#{imgdir}/#{filename}" )
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