class Purchase
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :deal

  field :quantity

  validates_uniqueness_of :quantity, :scope => :deal_id

  def as_json(*params)
    {
      :quantity => self.quantity,
      :created_at => self.created_at
    }
  end
end