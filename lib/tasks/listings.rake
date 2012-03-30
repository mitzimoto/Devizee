namespace :listings do
  desc 'Build the category tree'
  task :load_sfprops => :environment do
    file = File.new("/home/eric/idx.txt")

    line = file.gets
    headers = line.split('|')

    #Get rid of the weird newline in the last element
    headers.last.gsub!("\r\n", '')

    Sfprop.transaction do #This makes inserts waaaaaay faster. 

        while(line = file.gets)
            data = line.split('|')
            options = Hash.new
    
            data.each_with_index do |value, index|
    
                #Skip the first item. We've replaced it with "subtype"
                next if index == 0
    
                #get rid of the newline on the last element
                value = '' if value == "\r\n"
    
                #replace empty values with null
                value = nil if value == ''
    
                #Fix for the stupid area column
                headers[index] = 'AREA_CODE' if headers[index] == 'AREA'
    
                options[:"#{headers[index].downcase}"] = value
            end
    
            puts Sfprop.create(options)
        end

    end

    file.close
  end

end