class Purchase
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :deal

  field :quantity

  validates_uniqueness_of :quantity, :scope => :deal_id
end