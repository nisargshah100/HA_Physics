class Deal < ActiveRecord::Base
  has_many :events

  attr_accessible :original_id, :date_added, :end_date, :price_cents,
    :value_cents, :title, :subtitle, :affiliate_url, :original_url,
    :image_url, :source, :division_name, :latitude, :longitude,
    :original_category, :original_subcategory, :category, :last_purchase_count,
    :sold_out

  validates_uniqueness_of :original_id, :scope => :source

  reverse_geocoded_by :latitude, :longitude do |deal, results|
    if geo = results.first
      deal.city    = geo.city
      deal.state   = geo.state
      deal.country = geo.country
    end
    puts "NIL RESULT --- #{deal.inspect}, #{deal.latitude}, #{deal.longitude}" if results.first.nil?
  end

  before_create :reverse_geocode

  def self.livingsocial_deals 
    where(:source => "LivingSocial")
  end

  def self.groupon_deals
    where(:source => "groupon")
  end

  def self.active
    where{ end_date.gt Time.now }
  end

  def self.most_popular
    order("last_purchase_count DESC")
  end

  def price
    Money.new price_cents
  end

  def price=(value)
    Money.parse(value).tap do |price|
      write_attribute :price_cents, price.cents
    end
  end
end
