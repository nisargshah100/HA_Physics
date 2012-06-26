class CreateZips < ActiveRecord::Migration
  def change
    create_table :zips, :id => false do |t|
      t.string :code
      t.string :city
      t.string :state
      t.decimal :lat
      t.decimal :lon

      t.timestamps
    end
    execute "ALTER TABLE zips ADD PRIMARY KEY (code)"
  end
end
