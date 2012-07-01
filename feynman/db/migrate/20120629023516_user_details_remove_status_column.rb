class UserDetailsRemoveStatusColumn < ActiveRecord::Migration
  def change
    remove_column :user_details, :status
  end
end
