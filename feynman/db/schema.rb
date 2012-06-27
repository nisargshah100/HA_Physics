# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120627164324) do

  create_table "events", :force => true do |t|
    t.string   "source"
    t.integer  "deal_id"
    t.integer  "user_id"
    t.datetime "date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "description"
  end

  create_table "user_details", :force => true do |t|
    t.integer  "user_id"
    t.date     "birthday"
    t.string   "image"
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
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "zip_id"
    t.string   "status"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "uid"
    t.string   "provider"
    t.string   "oauth_access_token"
    t.string   "authentication_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "zips", :id => false, :force => true do |t|
    t.string   "code",       :null => false
    t.string   "city"
    t.string   "state"
    t.decimal  "lat"
    t.decimal  "lon"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
