class Purchase
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :deal

  field :quantity
end