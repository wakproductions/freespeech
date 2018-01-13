class AddDoNotRepostToZolnaEmbedPage < ActiveRecord::Migration[5.1]
  def change
    add_column :zolna_embed_pages, :do_not_repost, :boolean
  end
end
