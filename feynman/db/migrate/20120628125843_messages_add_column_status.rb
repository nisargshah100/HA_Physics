class MessagesAddColumnStatus < ActiveRecord::Migration
  def change
    add_column :messages, :status, :string, :default => "unread"
  end
end
