# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_26_073227) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "expansions", force: :cascade do |t|
    t.bigint "game_id"
    t.string "year_published"
    t.string "image"
    t.string "thumbnail"
    t.integer "num_owned"
    t.integer "avg_bgg_rating"
    t.integer "numplays"
    t.text "wishlist_comment"
    t.boolean "own"
    t.boolean "prevowned"
    t.boolean "fortrade"
    t.boolean "want"
    t.boolean "wanttoplay"
    t.boolean "wanttobuy"
    t.boolean "wishlist"
    t.integer "wishlist_priority"
    t.boolean "preordered"
    t.datetime "last_modified"
    t.integer "num_bgg_ratings"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_expansions_on_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "bgg_id", null: false
    t.string "name"
    t.string "year_published"
    t.string "image"
    t.string "thumbnail"
    t.integer "min_players"
    t.integer "max_players"
    t.integer "min_playtime"
    t.integer "max_playtime"
    t.integer "playingtime"
    t.integer "num_owned"
    t.integer "avg_bgg_rating"
    t.integer "numplays"
    t.text "wishlist_comment"
    t.boolean "own"
    t.boolean "prevowned"
    t.boolean "fortrade"
    t.boolean "want"
    t.boolean "wanttoplay"
    t.boolean "wanttobuy"
    t.boolean "wishlist"
    t.integer "wishlist_priority"
    t.boolean "preordered"
    t.datetime "last_modified"
    t.integer "num_bgg_ratings"
    t.integer "bgg_rank"
    t.string "bayes_avg"
    t.string "median"
    t.string "std_dev"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "plays", force: :cascade do |t|
    t.datetime "date"
    t.bigint "game_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_plays_on_game_id"
  end

end
