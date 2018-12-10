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

ActiveRecord::Schema.define(version: 2018_12_09_184608) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "movie_id"
    t.text "body"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "rating"
    t.integer "runtime"
    t.date "released"
    t.string "url"
    t.integer "checked_out_to_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "override_checkout"
    t.integer "team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "invite_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "checkout_limit"
    t.string "short_name"
  end

  create_table "track_likes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "track_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["track_id"], name: "index_track_likes_on_track_id"
    t.index ["user_id"], name: "index_track_likes_on_user_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "likes"
    t.integer "comments"
    t.string "url"
    t.bigint "posted_by_id"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "embed_html"
    t.string "thumbnail"
    t.string "original_author"
    t.string "embed_type"
    t.string "length_in_seconds"
    t.integer "cached_votes_total", default: 0
    t.integer "cached_votes_score", default: 0
    t.integer "cached_votes_up", default: 0
    t.integer "cached_votes_down", default: 0
    t.integer "cached_weighted_score", default: 0
    t.integer "cached_weighted_total", default: 0
    t.float "cached_weighted_average", default: 0.0
    t.index ["posted_by_id"], name: "index_tracks_on_posted_by_id"
    t.index ["team_id"], name: "index_tracks_on_team_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.boolean "admin"
    t.integer "team_id"
    t.string "phone_number"
    t.string "avatar_url"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.string "votable_type"
    t.integer "votable_id"
    t.string "voter_type"
    t.integer "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

  add_foreign_key "track_likes", "tracks"
  add_foreign_key "track_likes", "users"
  add_foreign_key "tracks", "teams"
  add_foreign_key "tracks", "users", column: "posted_by_id"
end
