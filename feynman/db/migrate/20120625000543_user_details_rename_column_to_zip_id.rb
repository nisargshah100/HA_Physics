class UserDetailsRenameColumnToZipId < ActiveRecord::Migration
  def change
    rename_column :user_details, :zipcode, :zip_id
  end
end
