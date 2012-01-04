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

ActiveRecord::Schema.define(:version => 20111219131645) do

  create_table "bloggers", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "twitter_username"
    t.string   "url"
    t.string   "feed_url"
    t.string   "etag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bloggers", ["name"], :name => "index_bloggers_on_name"

  create_table "categories", :force => true do |t|
    t.string "name"
  end

  add_index "categories", ["name"], :name => "index_categories_on_name"

  create_table "categories_posts", :force => true do |t|
    t.integer "category_id"
    t.integer "post_id"
  end

  add_index "categories_posts", ["category_id"], :name => "index_categories_posts_on_category_id"
  add_index "categories_posts", ["post_id"], :name => "index_categories_posts_on_post_id"

  create_table "posts", :force => true do |t|
    t.integer  "blogger_id"
    t.string   "title"
    t.text     "summary"
    t.string   "url"
    t.string   "guid"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["published_at"], :name => "index_posts_on_published_at"

  create_table "presentation_presenters", :force => true do |t|
    t.integer  "presentation_id"
    t.integer  "presenter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video_provider"
    t.string   "cached_slug"
  end

  create_table "presenters", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
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
