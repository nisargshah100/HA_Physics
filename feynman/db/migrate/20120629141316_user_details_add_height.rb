class UserDetailsAddHeight < ActiveRecord::Migration
  def change
    add_column :user_details, :height, :string
    remove_column :user_details, :height_feet
    remove_column :user_details, :height_inches
  end
end
