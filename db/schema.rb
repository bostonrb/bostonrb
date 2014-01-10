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

ActiveRecord::Schema.define(:version => 20140110222655) do

  create_table "blogs", :force => true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "twitter_username"
    t.string   "url"
    t.string   "feed_url"
    t.string   "etag"
    t.string   "most_recent_post_url"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "event_types", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.integer  "location_id",   :null => false
    t.integer  "event_type_id", :null => false
    t.string   "date",          :null => false
    t.string   "start_at",      :null => false
    t.string   "end_at",        :null => false
    t.string   "rsvp_url",      :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "locations", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "street",     :null => false
    t.string   "city",       :null => false
    t.string   "state",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "presentation_presenters", :force => true do |t|
    t.integer  "presentation_id"
    t.integer  "presenter_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "presentation_presenters", ["presentation_id", "presenter_id"], :name => "index_presentation_groups_on_presentation_id_and_presenter_id", :unique => true

  create_table "presentations", :force => true do |t|
    t.date     "presented_at"
    t.string   "video_id"
    t.string   "title"
    t.string   "slides_url"
    t.string   "project_url"
    t.string   "project_type"
    t.text     "description"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "video_provider"
    t.string   "cached_slug"
    t.string   "video_offset"
  end

  create_table "presenters", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "cached_slug"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

end
