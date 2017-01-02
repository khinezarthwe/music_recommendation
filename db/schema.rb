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

ActiveRecord::Schema.define(version: 20161231101222) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allsongs", force: :cascade do |t|
    t.string   "lastfm_userid"
    t.datetime "timestamp"
    t.string   "artist_id"
    t.string   "artist_name"
    t.string   "traid"
    t.string   "trackname"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "genre_based_recommendations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "song_id"
    t.decimal  "recommend_value"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

  create_table "nc_frecommendations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "song_id"
    t.decimal  "recommend_value"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "original_songs", force: :cascade do |t|
    t.string   "traid"
    t.string   "track_name"
    t.string   "artist_id"
    t.string   "artist_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "sidekiq_jobs", force: :cascade do |t|
    t.string   "jid"
    t.string   "queue"
    t.string   "class_name"
    t.text     "args"
    t.boolean  "retry"
    t.datetime "enqueued_at"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.string   "status"
    t.string   "name"
    t.text     "result"
  end

  add_index "sidekiq_jobs", ["class_name"], name: "index_sidekiq_jobs_on_class_name", using: :btree
  add_index "sidekiq_jobs", ["enqueued_at"], name: "index_sidekiq_jobs_on_enqueued_at", using: :btree
  add_index "sidekiq_jobs", ["finished_at"], name: "index_sidekiq_jobs_on_finished_at", using: :btree
  add_index "sidekiq_jobs", ["jid"], name: "index_sidekiq_jobs_on_jid", using: :btree
  add_index "sidekiq_jobs", ["queue"], name: "index_sidekiq_jobs_on_queue", using: :btree
  add_index "sidekiq_jobs", ["retry"], name: "index_sidekiq_jobs_on_retry", using: :btree
  add_index "sidekiq_jobs", ["started_at"], name: "index_sidekiq_jobs_on_started_at", using: :btree
  add_index "sidekiq_jobs", ["status"], name: "index_sidekiq_jobs_on_status", using: :btree

  create_table "songs", force: :cascade do |t|
    t.integer  "topic_num"
    t.text     "artist_name"
    t.text     "song_name"
    t.text     "lyric"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "traid"
    t.string   "artist_id"
    t.string   "video_link"
    t.string   "song_genre"
  end

  add_index "songs", ["user_id", "created_at"], name: "index_songs_on_user_id_and_created_at", using: :btree
  add_index "songs", ["user_id"], name: "index_songs_on_user_id", using: :btree

  create_table "survey_actions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "song_id"
    t.boolean  "agreed"
    t.boolean  "topic"
    t.boolean  "genre"
    t.boolean  "ncf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "survey_actions", ["song_id"], name: "index_survey_actions_on_song_id", using: :btree
  add_index "survey_actions", ["user_id"], name: "index_survey_actions_on_user_id", using: :btree

  create_table "temp_recommenders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "song_id"
    t.decimal  "recommend_value"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "age"
    t.string   "gender"
    t.string   "occupation"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "songs", "users"
  add_foreign_key "survey_actions", "songs"
  add_foreign_key "survey_actions", "users"
end
