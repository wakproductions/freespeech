module Zolna
  module DTube
    class Post
      include Verbalize::Action

      CURRENT_YEAR='2018'

      # Things Needed:
      # * snaphash (video poster)
      # * spritehash (imagemagick)
      # * video240hash
      # * video480hash
      # * video720hash
      # * duration
      # * filesize


# =begin
#       create_table "zolna_embed_pages", force: :cascade do |t|
#         t.string "permalink_id"
#         t.datetime "created_at", null: false
#         t.datetime "updated_at", null: false
#         t.string "title"
#         t.text "description"
#         t.string "video_snap_url"
#         t.string "source_mp4_url"
#         t.string "source_ogg_url"
#         t.string "additional_tags"
#         t.string "steemit_permalink"
#         t.string "steemit_post_content"
#         t.string "steemit_post_time"
#         t.string "steemit_post_response"
#         t.string "iframe_url"
#         t.boolean "do_not_repost"
#         t.boolean "in_post_queue"
#         t.boolean "favorite"
#         t.index ["permalink_id"], name: "index_zolna_embed_pages_unique"
#       end
# =end

      def call
      end


      private

      def


    end
  end
end