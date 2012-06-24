class UsersAddTokenAuthenticatable < ActiveRecord::Migration
  def change
    remove_column :users, :auth_token
    add_column :users, :authentication_token, :string
    add_column :users, :display_name, :string
  end
end
