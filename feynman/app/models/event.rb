class Event < ActiveRecord::Base
  attr_accessible :source, :deal_id, :description, :user_id, :date

  # DELETE DESCRIPTION_LONG, probably.
  validates_presence_of :user_id
  belongs_to :user
  belongs_to :deal

  def self.created_by(user_id)
    user = User.find_by_id(user_id)
    user.events if user
  end

  def self.filter_by(user, params=nil)
    nearby_users = user.nearby_compatible_users
    events = Event.where{ user_id.in( user_ids ) }
    events = Event.by_categories(params[:categories], events) if params[:categories]
    events
  end

  def self.by_categories(categories, events=Event)
    deals = Deal.where{ category.like_any my{ categories } }
    events = events.where{ deal_id.in ( deals.select{ original_id } ) }
  end
end
