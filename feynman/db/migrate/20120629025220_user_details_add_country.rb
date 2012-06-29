class UserDetailsAddCountry < ActiveRecord::Migration
  def change
    add_column :user_details, :country, :string
  end
end
