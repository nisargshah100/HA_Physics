class UserDetailsAddStateAndCity < ActiveRecord::Migration
  def change
    add_column :user_details, :city, :string
    add_column :user_details, :state, :string
  end
end
