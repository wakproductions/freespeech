class AddIFrameUrlToZolnaEmbedPages < ActiveRecord::Migration[5.1]
  def change
    add_column :zolna_embed_pages, :iframe_url, :string
  end
end
