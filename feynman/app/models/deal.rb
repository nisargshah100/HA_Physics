class Deal < ActiveRecord::Base
  has_many :events

  attr_accessible :original_id, :date_added, :end_date, :price_cents,
    :value_cents, :title, :subtitle, :affiliate_url, :original_url,
    :image_url, :source, :division_name, :division_latlon,
    :original_category, :category

  validates_uniqueness_of :original_id, :scope => :source

  def self.livingsocial_deals 
    where(:source => "LivingSocial")
  end

  def self.groupon_deals
    where(:source => "groupon")
  end
end
