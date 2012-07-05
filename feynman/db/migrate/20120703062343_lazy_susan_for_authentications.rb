class LazySusanForAuthentications < ActiveRecord::Migration
  def change
    add_index :authentications, :id
    add_index :authentications, :user_id
    add_index :authentications, :last_status_id
    add_index :authentications, :authentication_id
    add_index :deals, :original_id
    add_index :events, :id
    add_index :events, :deal_id
    add_index :events, :user_id
    add_index :events, [:deal_id, :user_id]
    add_index :events, [:user_id, :deal_id]
    add_index :images, :id
    add_index :images, :user_id
    add_index :messages, :id
    add_index :messages, :sender_id
    add_index :messages, :recipient_id
    add_index :messages, [:sender_id, :recipient_id]
    add_index :messages, [:recipient_id, :sender_id]
    add_index :user_details, :id
    add_index :user_details, :user_id
    add_index :users, :id
    add_index :users, :slug
    add_index :users, :display_name
    add_index :users, :email
  end
end