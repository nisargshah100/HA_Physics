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

ActiveRecord::Schema.define(:version => 20120701162701) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "token"
    t.string   "secret"
    t.string   "uid"
    t.string   "nickname"
    t.string   "image"
    t.string   "last_status_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "authentication_id"
  end

  create_table "deals", :force => true do |t|
    t.string   "original_id"
    t.datetime "date_added"
    t.datetime "end_date"
    t.integer  "price_cents"
    t.integer  "value_cents"
    t.string   "title"
    t.string   "subtitle"
    t.string   "affiliate_url"
    t.string   "original_url"
    t.string   "image_url"
    t.string   "source"
    t.string   "division_name"
    t.string   "original_category"
    t.string   "category"
    t.boolean  "sold_out",             :default => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "original_subcategory"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.integer  "last_purchase_count"
  end

  create_table "events", :force => true do |t|
    t.string   "source"
    t.integer  "deal_id"
    t.integer  "user_id"
    t.datetime "date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "description"
  end

  create_table "images", :force => true do |t|
    t.integer  "user_id"
    t.string   "image_url"
    t.string   "width"
    t.string   "height"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "body"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "status",       :default => "unread"
  end

  create_table "user_details", :force => true do |t|
    t.integer  "user_id"
    t.string   "image_url"
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
    t.integer  "exercise_level"
    t.integer  "drinking_level"
    t.integer  "smoking_level"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "zipcode"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "height"
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
    t.string   "display_name"
    t.date     "birthday"
    t.string   "slug"
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
