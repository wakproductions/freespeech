class CreateZolnaEmbedPages < ActiveRecord::Migration[5.1]
  def change
    create_table :zolna_embed_pages do |t|
      t.string :permalink_code

      t.timestamps
    end
  end
end
