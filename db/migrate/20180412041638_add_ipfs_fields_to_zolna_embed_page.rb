class AddIpfsFieldsToZolnaEmbedPage < ActiveRecord::Migration[5.1]
  def change
    add_column :zolna_embed_pages, :video_poster_ipfs_hash, :string
    add_column :zolna_embed_pages, :video_sprites_ipfs_hash, :string
    add_column :zolna_embed_pages, :video240p_ipfs_hash, :string
    add_column :zolna_embed_pages, :video480p_ipfs_hash, :string
    add_column :zolna_embed_pages, :video720p_ipfs_hash, :string
    add_column :zolna_embed_pages, :video_poster_path, :string
    add_column :zolna_embed_pages, :video_sprites_path, :string
    add_column :zolna_embed_pages, :video240p_path, :string
    add_column :zolna_embed_pages, :video480p_path, :string
    add_column :zolna_embed_pages, :video720p_path, :string
    add_column :zolna_embed_pages, :video_duration, :string
    add_column :zolna_embed_pages, :video_filesize, :string
  end
end
