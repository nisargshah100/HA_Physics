class CreateOriginalDivisions < ActiveRecord::Migration
  def change
    create_table :original_divisions do |t|
      t.string :source
      t.string :name
      t.integer :division_id

      t.timestamps
    end
  end
end
