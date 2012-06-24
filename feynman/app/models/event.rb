class Event < ActiveRecord::Base
  attr_accessible :source, :deal_id, :name, :description_long, :description_short, :user_id, :date

  belongs_to :user
  # attr_accessible :title, :body

  def self.create_with_gem(token, params)
    client = Feynman::Client.new({:token => token})
    client.create_event(params)
  end
end
