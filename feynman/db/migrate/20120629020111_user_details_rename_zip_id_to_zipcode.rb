class UserDetailsRenameZipIdToZipcode < ActiveRecord::Migration
  def change
    rename_column :user_details, :zip_id, :zipcode
  end
end
