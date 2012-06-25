class Purchase
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :deal

  field :quantity

  validates_uniqueness_of :quantity, :scope => :deal_id

  def as_json(*params)
    {
      :quantity => self.quantity,
      :created_at => self.created_at
    }
  end
end