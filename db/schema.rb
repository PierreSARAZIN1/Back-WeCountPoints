# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_02_14_085946) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.boolean "is_finished", default: false
    t.boolean "is_decisive", default: false
    t.integer "winner_id"
    t.integer "player_one"
    t.integer "player_two"
    t.integer "player_one_score", default: 0
    t.integer "player_two_score", default: 0
    t.bigint "tennis_set_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tennis_set_id"], name: "index_games_on_tennis_set_id"
  end

  create_table "matches", force: :cascade do |t|
    t.boolean "is_finished", default: false
    t.integer "winner_id", default: 0
    t.integer "player_one"
    t.integer "player_two"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "level"
    t.integer "number_of_sets_won", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "match_id"
    t.index ["match_id"], name: "index_players_on_match_id"
  end

  create_table "points", force: :cascade do |t|
    t.boolean "is_analyzed", default: false
    t.bigint "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "match_id"
    t.index ["match_id"], name: "index_points_on_match_id"
    t.index ["player_id"], name: "index_points_on_player_id"
  end

  create_table "tennis_sets", force: :cascade do |t|
    t.boolean "is_finished", default: false
    t.integer "winner_id"
    t.integer "player_one"
    t.integer "player_two"
    t.integer "player_one_score", default: 0
    t.integer "player_two_score", default: 0
    t.bigint "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_tennis_sets_on_match_id"
  end

  add_foreign_key "games", "tennis_sets"
  add_foreign_key "points", "players"
  add_foreign_key "tennis_sets", "matches"
end
