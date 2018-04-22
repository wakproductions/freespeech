class AddDTubePermalinkToZolnaEmbedPages < ActiveRecord::Migration[5.1]
  def change
    add_column :zolna_embed_pages, :dtube_permalink, :string
  end
end
