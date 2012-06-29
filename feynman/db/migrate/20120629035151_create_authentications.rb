class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
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
      t.timestamps
    end
  end
end
