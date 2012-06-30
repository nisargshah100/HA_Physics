class Message < ActiveRecord::Base
  attr_accessible :body, :recipient, :sender, :status, :sender_id, :recipient_id

  belongs_to :sender, :class_name => "User"
  belongs_to :recipient, :class_name => "User"

  def mark_as_opened
    update_attribute(:status, "read")
  end

  def pretty_time
    created_at.strftime("%a, %b %e at %l:%M %p")
  end

  def self.by_attributes(deals, params)
    attributes = Deal.first.attributes.map { |k,v| k }
    attributes.each do |attr|
      deals = deals.where(attr.to_sym => /#{params[attr.to_sym]}/) if params[attr.to_sym]
    end
    deals
  end
end