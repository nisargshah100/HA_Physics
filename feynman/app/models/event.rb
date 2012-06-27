class Event < ActiveRecord::Base
  attr_accessible :source, :deal_id, :description, :user_id, :date

  # DELETE DESCRIPTION_LONG, probably.
  validates_presence_of :user_id
  belongs_to :user
  # attr_accessible :title, :body

  def self.for_user(user_id)
    user = User.find_by_id(user_id)
    user.events if user
  end
end
