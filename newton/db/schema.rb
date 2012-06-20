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

ActiveRecord::Schema.define(:version => 20120620203812) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "deals", :force => true do |t|
    t.string   "source"
    t.datetime "date_added"
    t.datetime "end_date"
    t.integer  "price_cents"
    t.integer  "value_cents"
    t.string   "title"
    t.string   "subtitle"
    t.string   "affiliate_url"
    t.string   "original_url"
    t.string   "image_url"
    t.integer  "division_id"
    t.integer  "category_id"
    t.integer  "business_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "original_id"
  end

  create_table "original_categories", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.string   "source"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "original_divisions", :force => true do |t|
    t.string   "source"
    t.string   "name"
    t.integer  "division_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
