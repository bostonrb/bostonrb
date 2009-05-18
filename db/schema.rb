# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090518042333) do

  create_table "events", :force => true do |t|
    t.datetime "date"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location"
    t.float    "lng"
    t.float    "lat"
    t.string   "title"
    t.datetime "deleted_at"
    t.integer  "place_id"
    t.text     "cached_description_html"
    t.boolean  "recurring",               :default => true, :null => false
  end

  create_table "jobs", :force => true do |t|
    t.string   "location"
    t.string   "organization"
    t.string   "title"
    t.text     "description"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.text     "cached_description_html"
  end

  create_table "presentations", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.text     "embed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "presenter"
    t.string   "source"
    t.datetime "deleted_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "homepage_url"
    t.string   "feed_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.datetime "deleted_at"
    t.string   "cached_description_html"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password", :limit => 128
    t.string   "salt",               :limit => 128
    t.string   "token",              :limit => 128
    t.datetime "token_expires_at"
    t.boolean  "email_confirmed",                   :default => false, :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["id", "token"], :name => "index_users_on_id_and_token"
  add_index "users", ["token"], :name => "index_users_on_token"

end
