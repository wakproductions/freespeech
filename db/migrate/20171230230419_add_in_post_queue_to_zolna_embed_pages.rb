class AddInPostQueueToZolnaEmbedPages < ActiveRecord::Migration[5.1]
  def change
    add_column :zolna_embed_pages, :in_post_queue, :boolean
  end
end
