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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140504171525) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movie_links", force: true do |t|
    t.string   "link"
    t.string   "engine"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movie_links", ["movie_id"], name: "index_movie_links_on_movie_id", using: :btree

  create_table "movies", force: true do |t|
    t.string   "name"
    t.string   "international_name"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movies", ["name"], name: "index_movies_on_name", using: :btree

  create_table "user_hates", id: false, force: true do |t|
    t.integer  "user_id"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_hates", ["movie_id"], name: "index_user_hates_on_movie_id", using: :btree
  add_index "user_hates", ["user_id"], name: "index_user_hates_on_user_id", using: :btree

  create_table "user_waits", id: false, force: true do |t|
    t.integer  "user_id"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_waits", ["movie_id"], name: "index_user_waits_on_movie_id", using: :btree
  add_index "user_waits", ["user_id"], name: "index_user_waits_on_user_id", using: :btree

  create_table "user_watches", id: false, force: true do |t|
    t.integer  "user_id"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_watches", ["movie_id"], name: "index_user_watches_on_movie_id", using: :btree
  add_index "user_watches", ["user_id"], name: "index_user_watches_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
