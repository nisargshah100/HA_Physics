class UserDetailsAddLatitudeAndLongitude < ActiveRecord::Migration
  def change
    remove_column :users, :latitude
    remove_column :users, :longitude
    add_column :user_details, :latitude, :float
    add_column :user_details, :longitude, :float
  end
end
