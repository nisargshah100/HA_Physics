class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :original_id
      t.datetime :date_added
      t.datetime :end_date
      t.integer :price_cents 
      t.integer :value_cents
      t.string :title
      t.string :subtitle
      t.string :affiliate_url
      t.string :original_url
      t.string :image_url
      t.string :source
      t.string :division_name
      t.float :division_latitude
      t.float :division_longitude
      t.string :original_category
      t.string :category
      t.boolean :sold_out, :default => false
      t.timestamps
    end
  end
end
