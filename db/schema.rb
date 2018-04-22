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

ActiveRecord::Schema.define(version: 20180415170339) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "steemit_vote_histories", force: :cascade do |t|
    t.string "voted_as_user"
    t.string "post_author"
    t.string "steemit_permalink_id"
    t.datetime "voted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "videos", force: :cascade do |t|
    t.string "video_source_480p"
    t.text "body_text"
    t.string "steemit_permlink_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "zolna_embed_pages", force: :cascade do |t|
    t.string "permalink_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "description"
    t.string "video_snap_url"
    t.string "source_mp4_url"
    t.string "source_ogg_url"
    t.string "additional_tags"
    t.string "steemit_permalink"
    t.string "steemit_post_content"
    t.string "steemit_post_time"
    t.string "steemit_post_response"
    t.string "iframe_url"
    t.boolean "do_not_repost"
    t.boolean "in_post_queue"
    t.boolean "favorite"
    t.string "video_poster_ipfs_hash"
    t.string "video_sprites_ipfs_hash"
    t.string "video240p_ipfs_hash"
    t.string "video480p_ipfs_hash"
    t.string "video720p_ipfs_hash"
    t.string "video_poster_path"
    t.string "video_sprites_path"
    t.string "video240p_path"
    t.string "video480p_path"
    t.string "video720p_path"
    t.string "video_duration"
    t.string "video_filesize"
    t.string "dtube_permalink"
    t.index ["permalink_id"], name: "index_zolna_embed_pages_unique"
  end

end
