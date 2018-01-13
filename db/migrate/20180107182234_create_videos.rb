class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.string :video_source_480p
      t.text :body_text
      t.string :steemit_permlink_id

      t.timestamps
    end
  end
end
