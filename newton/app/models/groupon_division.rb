class GrouponDivision
  include Mongoid::Document

  field :lat, type: Float
  field :long, type: Float
  field :country, type: String
  field :timezone, type: String
  field :name, type: String
  field :division_id, type: String
end
