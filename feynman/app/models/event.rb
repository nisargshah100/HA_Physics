class Event < ActiveRecord::Base
  attr_accessible :source, :deal_id, :name, :description, :user_id, :date

  belongs_to :user
  # attr_accessible :title, :body
end
