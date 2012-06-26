class Deal
  include Mongoid::Document
  include Mongoid::Timestamps
  paginates_per 10
  
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
  field :original_subcategory, type: String
  field :category, type: String

  validates_uniqueness_of :original_id, :scope => :source

  index(
    [[:division_latlon, Mongo::GEO2D]], background: true
  )

  def as_json(*params)
    attributes = Deal.first.attributes.map { |k,v| k }

    data = {}
    attributes.each do |attribute|
      data[attribute] = self.read_attribute(attribute.to_sym)
    end
    data['purchases'] = self.purchases.all

    data
  end

  def self.by_params(params)
    deals = Deal
    deals = by_attributes(deals, params)
    deals = by_location(deals, params)
    deals
  end

  def self.by_attributes(deals, params)
    attributes = Deal.first.attributes.map { |k,v| k }
    attributes.each do |attr|
      deals = deals.where(attr.to_sym => /#{params[attr.to_sym]}/) if params[attr.to_sym]
    end
    deals
  end

  def self.by_location(deals, params)
    if params[:near]
      near = params[:near].split(",").map { |loc| loc.to_f }
      distance = params[:distance].to_f || 30

      deals = deals.where(:division_latlon => {
        '$near' => near, 
        '$maxDistance' => distance 
      })
    end

    deals
  end
end
