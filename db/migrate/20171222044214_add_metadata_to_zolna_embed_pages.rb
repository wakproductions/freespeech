class AddMetadataToZolnaEmbedPages < ActiveRecord::Migration[5.1]
  def change
    add_column :zolna_embed_pages, :title, :string
    add_column :zolna_embed_pages, :description, :text
    add_column :zolna_embed_pages, :video_snap_url, :string
    add_column :zolna_embed_pages, :source_mp4_url, :string
    add_column :zolna_embed_pages, :source_ogg_url, :string
    add_column :zolna_embed_pages, :additional_tags, :string
    add_column :zolna_embed_pages, :steemit_permalink, :string
    add_column :zolna_embed_pages, :steemit_post_content, :string
    add_column :zolna_embed_pages, :steemit_post_time, :string
    add_column :zolna_embed_pages, :steemit_post_response, :string
  end
end
