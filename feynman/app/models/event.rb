class Event < ActiveRecord::Base
  attr_accessible :source, :deal_id, :description_long, :description_short, :user_id, :date

  belongs_to :user
  # attr_accessible :title, :body

  def self.for_user(user_id)
    user = User.find_by_id(user_id)
    user.events if user
  end
end
