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

ActiveRecord::Schema.define(version: 2019_09_15_133913) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "frames", force: :cascade do |t|
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "player_id"
    t.integer "number"
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "game_id"
  end

  create_table "points", force: :cascade do |t|
    t.string "status"
    t.string "status_reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "value"
    t.integer "frame_id"
  end

  create_table "steps", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.integer "game_id"
    t.boolean "is_completed", default: false
    t.boolean "is_skipped", default: false
    t.string "reason_why_skipped"
  end

  create_table "throws", force: :cascade do |t|
    t.integer "number_of_knocked_down_pins"
    t.boolean "is_strike"
    t.boolean "is_spare"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "frame_id"
    t.integer "step_id"
  end

end
