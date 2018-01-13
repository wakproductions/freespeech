class AddUniqueIndexToZolnaEmbedPages < ActiveRecord::Migration[5.1]
  def change
    add_index :zolna_embed_pages, ["permalink_code"], name: "index_zolna_embed_pages_unique"
  end
end
