require 'date'

namespace :cron do
  task :run do
    while(true)
      puts "Running cron at #{DateTime.now}"
      `rake ls:fetch_deals > log/livingsocial_log.txt`
      `rake groupon:fetch_divisions > log/groupon_log.txt`
      `rake groupon:fetch_deals > log/groupon_log.txt`
      sleep(1800)
    end
  end
end