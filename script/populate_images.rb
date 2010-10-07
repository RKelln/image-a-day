require 'logger'
$log = Logger.new('populate_images.log')

IMPORT_DIR = 'import'
DEFAULT_PASSWORD = 'changemenow'

## crawl the images directory, yield files
def dir_crawler(dir, &block)
    Dir.foreach(dir) do |entry|
        next if ['.', '..'].index(entry)

        entry_path = dir + '/' + entry
        if File.directory?(entry_path)
            # recurse directories
            dir_crawler(entry_path, &block)
        else
            yield entry_path
        end
    end
end

def import_image(image_file)
    extract_re = /(?<year>\d{4})\/(?<month>[A-Z][a-z]+)\/(?<day>\d{1,2})\/(?<nickname>[A-Za-z]+)_\d{4}_\d{1,3}\.[a-z]+$/
    
    extract_re.match(image_file) do |match_data|
        nickname = match_data[:nickname]
        user = User.where(:nickname => nickname)
        if user.many?
            puts "FAILURE: nickname '#{nickname}' is used by multiple users!"
            # FIXME: freak out!
            return
        elsif user.empty?
            # create a user
            puts "NEW USER: #{nickname}"
            # email?  password?  active?
            user = User.new(:email => "#{nickname.downcase}@invalid_email.com",
                            :nickname => nickname, :password => DEFAULT_PASSWORD)
            if not user.save!
                puts "FAILURE: could not save new user"
                return
            end
        else
            user = user.first
        end
        user_id = user.id

        date = Date.new(match_data[:year].to_i,
                        Date::MONTHNAMES.index(match_data[:month]),
                        match_data[:day].to_i)
        
        # skip images that already exist in the database
        return if Image.where(:user_id => user, :date => date).any?

        text_file = image_file.sub(/\.[a-z]+$/, '.txt')
        description = File.open(text_file).read.delete('\\') if File.exists?(text_file)

        file = File.new(image_file)
        
        image_record = Image.new()
        image_record.user_id = user_id
        image_record.date = date
        image_record.description = description
        image_record.data = file
        
        begin
            if not image_record.save!
                $log.error "#{image_file} - image_record.save! returned nil"
                return image_file # error
            end

            return nil # no errors
        rescue Exception => exception
            $log.error "#{image_file} - exception #{exception.class} in image_record.save! '#{exception.to_s}'"
            return image_file # error
        ensure
            file.close
        end
    end
end

failures = []
dir_crawler(IMPORT_DIR) do |image_file|
    # don't bother trying .txt's
    next if /\.txt$/ =~ image_file
    
    failed = import_image(image_file)
    failures.push image_file if failed
end
while not failures.empty?
    new_failures = []
    puts "Retrying #{failures.length} failed images"
    failures.each do |image_file|
        failed = import_image(image_file)
        new_failures.push(image_file) if failed
    end
    failures = new_failures
end
