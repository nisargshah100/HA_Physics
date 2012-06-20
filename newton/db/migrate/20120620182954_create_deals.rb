class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :source
      t.datetime :date_added
      t.datetime :end_date
      t.integer :price_cents
      t.integer :value_cents
      t.string :title
      t.string :subtitle
      t.string :affiliate_url
      t.string :original_url
      t.string :image_url
      t.integer :division_id
      t.integer :category_id
      t.integer :business_id
      t.timestamps
    end
  end
end
