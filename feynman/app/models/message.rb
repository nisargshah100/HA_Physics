class Message < ActiveRecord::Base
  MESSAGE_ATTRS = [ :body, :recipient, :sender, :status, :sender_id, :recipient_id ]
  attr_accessible *MESSAGE_ATTRS

  belongs_to :sender, :class_name => "User"
  belongs_to :recipient, :class_name => "User"

  def mark_as_opened
    update_attribute(:status, "read") if status == "unread"
  end

  def pretty_time
    created_at.strftime("%a, %b %e at %l:%M %p")
  end

  def self.by_persons(params)
    messages = Message
    MESSAGE_ATTRS.each do |attr|
      # deals = Message.where{attr.to_s.matches "%#{params[attr]}%"} if params[attr]
      messages = messages.where(attr => "#{params[attr]}") if params[attr]
    end
    messages
  end
end