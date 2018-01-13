class RenamePermalinkCodeToPermalinkId < ActiveRecord::Migration[5.1]
  def change
    rename_column :zolna_embed_pages, :permalink_code, :permalink_id
  end
end
