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

ActiveRecord::Schema.define(version: 20170624111300) do

  create_table "deposits", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "creater_id"
    t.decimal  "amount",     precision: 5, scale: 2
    t.string   "comment"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer  "game_number"
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.datetime "game_date"
    t.integer  "home_goals"
    t.integer  "away_goals"
    t.integer  "season_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "state",        default: "open"
    t.boolean  "current",      default: false
    t.boolean  "evaluated",    default: false
    t.index ["season_id"], name: "index_games_on_season_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.string   "season_name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "team_logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tips", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.integer  "home_goals"
    t.integer  "away_goals"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.decimal  "price",      precision: 5, scale: 2
    t.index ["game_id", "user_id"], name: "index_tips_on_game_id_and_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.boolean  "guest",             default: false
    t.decimal  "sum_money_in"
    t.decimal  "sum_money_out"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
