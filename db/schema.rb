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

ActiveRecord::Schema.define(version: 20140504141559) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cafes", force: true do |t|
    t.string   "name"
    t.string   "dmetaphone_name"
    t.decimal  "lat",             precision: 11, scale: 8
    t.decimal  "lng",             precision: 11, scale: 8
    t.integer  "rating"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "place_woeid"
  end

  add_index "cafes", ["place_woeid"], name: "index_cafes_on_place_woeid", using: :btree

  create_table "geo_planet_adjacencies", force: true do |t|
    t.integer "place_woeid",     null: false
    t.string  "place_iso"
    t.integer "neighbour_woeid", null: false
    t.string  "neighbour_iso"
  end

  add_index "geo_planet_adjacencies", ["place_woeid", "neighbour_woeid"], name: "index_geo_planet_adjacencies_on_place_woeid_and_neighbour_woeid", using: :btree

  create_table "geo_planet_aliases", force: true do |t|
    t.integer "woeid",     null: false
    t.string  "name"
    t.string  "name_type"
    t.string  "language"
  end

  add_index "geo_planet_aliases", ["woeid"], name: "index_geo_planet_aliases_on_woeid", using: :btree

  create_table "geo_planet_places", primary_key: "woeid", force: true do |t|
    t.string  "iso"
    t.string  "name"
    t.string  "language"
    t.string  "place_type"
    t.integer "parent_id",  null: false
    t.string  "ancestry"
  end

  add_index "geo_planet_places", ["ancestry"], name: "geo_planet_places_ancestry_index", using: :btree
  add_index "geo_planet_places", ["parent_id"], name: "index_geo_planet_places_on_parent_id", using: :btree
  add_index "geo_planet_places", ["place_type"], name: "index_geo_planet_places_on_place_type", using: :btree

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

  create_table "que_jobs", id: false, force: true do |t|
    t.integer  "priority",    limit: 2, default: 100,                                        null: false
    t.datetime "run_at",                default: "now()",                                    null: false
    t.integer  "job_id",      limit: 8, default: "nextval('que_jobs_job_id_seq'::regclass)", null: false
    t.text     "job_class",                                                                  null: false
    t.json     "args",                  default: [],                                         null: false
    t.integer  "error_count",           default: 0,                                          null: false
    t.text     "last_error"
    t.text     "queue",                 default: "",                                         null: false
  end

  create_table "reviews", force: true do |t|
    t.integer  "cafe_id"
    t.text     "body"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["cafe_id"], name: "index_reviews_on_cafe_id", using: :btree

  create_table "user_hates", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_waits", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
