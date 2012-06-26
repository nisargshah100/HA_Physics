class UserDetailsAddColumnZipId < ActiveRecord::Migration
  def change
    remove_column :user_details, :zip_id
    add_column :user_details, :zip_id, :string
  end
end
