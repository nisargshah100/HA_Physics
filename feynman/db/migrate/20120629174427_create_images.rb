class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :user_id
      t.string :image_url
      t.string :width
      t.string :height
      t.timestamps
    end
  end
end
