class Event < ActiveRecord::Base
  attr_accessible :source, :deal, :deal_id, :description, :user_id, :user, :date

  # DELETE DESCRIPTION_LONG, probably.
  validates_presence_of :user_id
  belongs_to :user
  belongs_to :deal

  def self.created_by(user_id)
    created_by_users([ user_id ])
  end

  def self.created_by_users(user_id_array)
    where{ user_id.in( user_id_array ) }
  end

  def self.filter_by(user, params=nil)
    nearby_users = user.nearby_compatible_users
    events = Event.created_by_users(nearby_users.pluck(:id))
    events = events.by_categories(params[:categories]) if params[:categories]
    events
  end

  def self.by_categories(categories, events=Event)
    deals = Deal.where{ category.like_any my{ categories } }
    where{ deal_id.in ( deals.select{ original_id } ) }
  end

  def self.active
    where(status: "active")
  end

  def set_to_inactive
    update_attribute(:status, "inactive")
  end
end
