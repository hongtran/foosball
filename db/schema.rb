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

ActiveRecord::Schema.define(version: 20171013115853) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.integer "team1_score"
    t.integer "team2_score"
    t.bigint "team_win_id"
    t.bigint "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_games_on_match_id"
    t.index ["team_win_id"], name: "index_games_on_team_win_id"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "team_one_id"
    t.bigint "team_two_id"
    t.bigint "winner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_one_id"], name: "index_matches_on_team_one_id"
    t.index ["team_two_id"], name: "index_matches_on_team_two_id"
    t.index ["winner_id"], name: "index_matches_on_winner_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.bigint "player1_id"
    t.bigint "player2_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player1_id"], name: "index_teams_on_player1_id"
    t.index ["player2_id"], name: "index_teams_on_player2_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "games", "matches"
end
