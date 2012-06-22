class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string   :source
      t.integer  :deal_id
      t.string   :name
      t.string   :description
      t.integer  :user_id
      t.datetime :date
      t.timestamps
    end
  end
end
