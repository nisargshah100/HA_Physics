class UsersAddUidAndProvider < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :name, :string
    add_column :users, :image, :string
    add_column :users, :location, :string

    remove_column :users, :authentication_token
    add_column :users, :auth_token, :string
    add_column :users, :oauth_access_token, :string
  end
end
