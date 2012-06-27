class UserDetailsAddColumnStatus < ActiveRecord::Migration
  def change
    add_column :user_details, :status, :string
  end
end
