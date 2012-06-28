class UsersAddDisplayName < ActiveRecord::Migration
  def change
    add_column :users, :display_name, :string
    add_column :users, :birthday, :date
    remove_column :user_details, :display_name
  end
end
