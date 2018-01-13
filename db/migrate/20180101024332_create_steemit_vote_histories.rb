class CreateSteemitVoteHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :steemit_vote_histories do |t|
      t.string :voted_as_user
      t.string :post_author
      t.string :steemit_permalink_id
      t.datetime :voted_at

      t.timestamps
    end
  end
end
