class UserDetailsChangeColumnToImageUrl < ActiveRecord::Migration
  def change
    rename_column :user_details, :image, :image_url
  end
end
