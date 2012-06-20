class Groupon
  def self.fetch(url)

  end
end

namespace :groupon do
  task :fetch => :environment do
    Groupon.fetch
  end
end