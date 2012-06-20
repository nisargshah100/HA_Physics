class CreateGrouponDivisions < ActiveRecord::Migration
  def change
    create_table :groupon_divisions do |t|
      t.float :lat
      t.float :long
      t.string :country
      t.string :timezone
      t.string :name
      t.string :division_id
      t.timestamps
    end
  end
end
