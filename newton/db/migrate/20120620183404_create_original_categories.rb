class CreateOriginalCategories < ActiveRecord::Migration
  def change
    create_table :original_categories do |t|
      t.string :name
      t.integer :category_id
      t.string :source

      t.timestamps
    end
  end
end
