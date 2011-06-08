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

ActiveRecord::Schema.define(:version => 20110608165345) do

  create_table "demands", :force => true do |t|
    t.integer  "counter"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "radius"
  end

  create_table "designs", :force => true do |t|
    t.integer  "user_id"
    t.string   "image_path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "xml_data"
    t.integer  "order_id"
  end

  create_table "orders", :force => true do |t|
    t.integer  "trashcan_id"
    t.integer  "user_id"
    t.string   "code"
    t.integer  "design_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["design_id"], :name => "index_orders_on_design_id"
  add_index "orders", ["trashcan_id"], :name => "index_orders_on_trashcan_id"
  add_index "orders", ["user_id"], :name => "index_orders_on_owner_id"

  create_table "trashcans", :force => true do |t|
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "is_free"
    t.date     "adopted_until"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "street"
    t.string   "city"
    t.string   "token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
