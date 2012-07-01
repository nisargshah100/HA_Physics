class Deal
  include Mongoid::Document
  include Mongoid::Timestamps
  
  embeds_many :purchases

  field :original_id, type: String
  field :date_added, type: DateTime
  field :end_date, type: DateTime
  field :price_cents, type: Integer
  field :value_cents, type: Integer
  field :title, type: String
  field :subtitle, type: String
  field :affiliate_url, type: String
  field :original_url, type: String
  field :image_url, type: String
  field :source, type: String
  field :division_name, type: String
  field :division_latlon, type: Array
  field :original_category, type: String
  field :category, type: String
  field :original_subcategory, type: String
  field :sold_out, type: Boolean, :default => false

  validates_uniqueness_of :original_id, :scope => :source

  index(
    [[:division_latlon, Mongo::GEO2D]], background: true
  )

  def self.livingsocial_deals 
    where(:source => "LivingSocial")
  end

  def self.groupon_deals
    where(:source => "groupon")
  end

end