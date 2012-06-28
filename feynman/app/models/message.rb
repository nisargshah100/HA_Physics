class Message < ActiveRecord::Base
  attr_accessible :body, :recipient, :sender, :status

  belongs_to :sender, :class_name => "User"
  belongs_to :recipient, :class_name => "User"

  def mark_as_opened
    update_attribute(:status, "read")
  end

  def pretty_time
    created_at.strftime("%a, %b %e at %l:%M %p")
  end
end