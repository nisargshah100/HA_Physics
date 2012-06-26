namespace :load do

  ZIP_CODE_DATA_URL = 'vendor/zips.txt'

  # Swiped from ActiveRecord migrations.rb
  def announce(message)
    length = [0, 75 - message.length].max
    puts "== %s %s" % [message, "=" * length]
  end

  desc "Loads zip codes from #{ZIP_CODE_DATA_URL}"
  task :zip_codes => :environment do
    begin
      time = Benchmark.measure do      
        require 'csv' 
        require 'open-uri'
        CSV.parse(open(ZIP_CODE_DATA_URL).read) do |row|
          # Connascence of Position, Jim Weirich forgive me!
          zip = Zip.create!(
            :code => row[1],
            :state => row[2],
            :city => row[3],
            :lat => row[4],
            :lon => row[5])
          puts "%20s, %2s, %5s" % [zip.city, zip.state, zip.code]
        end
      end
      announce "Loaded %5d zip codes in (%2dm %2.0fs)" % [Zip.count, *time.real.divmod(60)]
    rescue LoadError
      puts "This rake task requires fastercsv.  To install, run this command:\n\n  sudo gem install fastercsv\n\n"
    end
  end

  desc "Creates n number random users using the Random Data gem, defaults to 1000"
  task :random_users, :n, :needs => :environment do |t, args|
    begin
      n = args.n.to_i < 1 ? 1000 : args.n.to_i
      time = Benchmark.measure do      
        require 'random_data' 
        domains = %w[yahoo.com gmail.com privacy.net webmail.com msn.com hotmail.com example.com privacy.net]
        zips = Zip.all #Can we fit 29k zip codes into memory?
        n.times do |i|
          user = User.new
          user_detail = user.build_user_detail
          user_detail.display_name = "#{Random.firstname}#{Random.lastname}#{i}".downcase
          user.password = user.password_confirmation = "secret"
          user.email = "#{user.display_name}\@#{domains.rand}"
          zip = zips.rand
          user_detail.zip = zip
          user.save!
          puts "%6d: %15s, %30s, %5s" % [(i+1), user.display_name, user.email, user_detail.zip.code]
        end
      end
      announce "Loaded %6d users in (%2dm %2.0fs)" % [n, *time.real.divmod(60)]      
    rescue LoadError
      puts "This rake task requires random_data.  To install, run this command:\n\n  sudo gem install random_data\n\n"
    end      
  end
end