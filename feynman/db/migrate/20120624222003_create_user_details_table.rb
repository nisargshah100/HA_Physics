class CreateUserDetailsTable < ActiveRecord::Migration
  def change
    remove_column :users, :name
    remove_column :users, :image
    remove_column :users, :location
    remove_column :users, :display_name

    create_table :user_details do |t|
      t.integer  "user_id"
      t.date     "birthday"
      t.string   "image"
      t.string   "zipcode"
      t.string   "display_name"
      t.string   "gender"
      t.string   "gender_preference"
      t.integer  "age_range_lower"
      t.integer  "age_range_upper"
      t.string   "employment"
      t.string   "education"
      t.string   "faith"
      t.string   "faith_level"
      t.string   "political_affiliation"
      t.string   "political_affiliation_level"
      t.string   "race"
      t.string   "children_preference"
      t.string   "height_feet"
      t.string   "height_inches"
      t.integer  "exercise_level"
      t.integer  "drinking_level"
      t.integer  "smoking_level"
      t.timestamps
    end
  end
end
