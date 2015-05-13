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

ActiveRecord::Schema.define(version: 20150513101906) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drones", force: :cascade do |t|
    t.string   "title"
    t.string   "user"
    t.integer  "tv_id"
    t.string   "tv_image",                array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "drones", ["tv_image"], name: "index_drones_on_tv_image", using: :gin

  create_table "tags_suck_tvs", force: :cascade do |t|
    t.string   "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tokens", force: :cascade do |t|
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
