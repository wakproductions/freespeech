module FileUtilities
  def share_content_path
    Rails.root.join('data/share_content')
  end

  def zolnareport_source_path
    Rails.root.join('data', ENV.fetch('ZOLNA_VIDEOS_SOURCE_DIR'))
  end
end