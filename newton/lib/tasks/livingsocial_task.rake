require 'nokogiri'

class LivingSocial
  def self.get_data
    data = File.open('db/sample_data/cities.atom.txt', 'r').read
  end

  def self.fetch
    data = Nokogiri::XML.parse(get_data)
    data.search('entry').each do |entry|
      entry = LivingSocialEntryParser.new(entry)
      save_entry(entry)
    end
  end

  def self.save_entry(entry)
    deal = Deal.where(:livingsocial_id => entry.id).first
    if not deal
      deal = Deal.new(:livingsocial_id => entry.id)
      deal.attributes = entry.as_json
      deal.save()
      puts "Deal saved! #{deal.title}"
    end
  end
end

class LivingSocialEntryParser
  def initialize(entry)
    @entry ||= entry
  end

  def id
    @entry.search('id').first.text
  end

  def title
    @entry.search('long_title').first.text
  end

  def date_added
    DateTime.parse(@entry.search('published').first.text)
  end

  def end_date
    DateTime.parse(@entry.search('offer_ends_at').first.text)
  end

  def price
    price = @entry.search('price').first.text
    Money.parse(price).cents
  end

  def value
    value = @entry.search('value').first.text
    Money.parse(value).cents
  end

  def subtitle
    @entry.search('subtitle').first.text
  end

  def original_url
    @entry.search('link').first.attr('href')
  end

  def affiliate_url
    original_url
  end

  def image_url
    @entry.search('image_url').first.text
  end

  def source
    @entry.search('author/name').first.text
  end

  def as_json(*params)
    {
      :title => title,
      :date_added => date_added,
      :end_date => end_date,
      :price_cents => price,
      :value_cents => value,
      :subtitle => subtitle,
      :original_url => original_url,
      :affiliate_url => affiliate_url,
      :image_url => image_url,
      :source => source
    }
  end
end

namespace :ls do
  task :fetch => :environment do
    LivingSocial.fetch
  end
end