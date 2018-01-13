class AddFavoriteToZolnaEmbedPage < ActiveRecord::Migration[5.1]
  def change
    add_column :zolna_embed_pages, :favorite, :boolean
  end
end
