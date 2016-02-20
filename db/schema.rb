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

ActiveRecord::Schema.define(version: 20160220173300) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "maps", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", id: :bigserial, force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scores", force: :cascade do |t|
    t.string   "map",                  null: false
    t.integer  "mode",                 null: false
    t.integer  "player_id",  limit: 8, null: false
    t.integer  "time",                 null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.uuid     "match_guid",           null: false
    t.integer  "api_id"
    t.integer  "map_id"
  end

  add_index "scores", ["player_id", "map", "mode"], name: "index_scores_on_player_id_and_map_and_mode", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "api_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "world_records", force: :cascade do |t|
    t.string   "map",                  null: false
    t.integer  "mode",                 null: false
    t.integer  "player_id",  limit: 8, null: false
    t.integer  "time",                 null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.uuid     "match_guid",           null: false
    t.integer  "api_id"
    t.integer  "map_id"
  end

  add_index "world_records", ["map", "mode"], name: "index_world_records_on_map_and_mode", unique: true, using: :btree
  add_index "world_records", ["player_id"], name: "index_world_records_on_player_id", using: :btree

  add_foreign_key "scores", "players", name: "scores_player_id_fk", on_delete: :cascade
  add_foreign_key "world_records", "players", name: "world_records_player_id_fk", on_delete: :cascade
end
