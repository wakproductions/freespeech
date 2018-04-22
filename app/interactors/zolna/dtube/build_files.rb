module Zolna
  module DTube
    class BuildFiles
      include FileUtilities
      include Verbalize::Action

      SHARE_CONTENT_DIR='/app/data/share_content'

      input :zolna_permalink_id

      def call
        build_video480p
        build_video240p

        binding.pry
        {
          video_poster_ipfs_hash: add_to_ipfs(video_poster_path).hashcode,
          video_sprites_ipfs_hash: nil,
          video240p_ipfs_hash: add_to_ipfs(video240p_path).hashcode,
          video480p_ipfs_hash: add_to_ipfs(video480p_path).hashcode,
          video720p_ipfs_hash: add_to_ipfs(video720p_path).hashcode,
          video_poster_path: video_poster_path,
          video_sprites_path: nil,
          video240p_path: video240p_path,
          video480p_path: video480p_path,
          video720p_path: video720p_path,
          video_duration: duration,
          video_filesize: size,
        }
      end

      private

      def add_to_ipfs(pathname)
        client = IPFS::Client.new(host: 'http://ipfs', port: 5001)
        IPFS::Commands::Add.call(client, File.open(pathname))
      end

      def build_video240p
        movie.transcode(video240p_path, %w(-s 426x240 -c:v libx264 -crf 23 -c:a aac -strict -2)) unless File.exists?(video240p_path)
      end

      def build_video480p
        # `ffmpeg -i #{video720p_path} -s hd480 -c:v libx264 -crf 23 -c:a aac -strict -2 #{video480p_path}`
        movie.transcode(video480p_path, %w(-s hd480 -c:v libx264 -crf 23 -c:a aac -strict -2)) unless File.exists?(video480p_path)
      end      

      def duration
        @duration = movie.duration
      end

      def movie
        @movie ||= FFMPEG::Movie.new(video720p_path)
      end

      def original_video_path
        video720p_path
      end

      def build_video_sprites

      end

      def size
        @size ||= movie.size
      end

      def video_sprites_path
        # This will be done using Imagemagick/ffpmeg - but skipping for now
        @video_sprites_path ||= build_video_sprites
      end

      def video_poster_path
        @video_poster_path ||= File.join(zolnareport_source_path, "#{zolna_permalink_id}.jpg")
      end

      def video240p_path
        @video240p_path ||= File.join(SHARE_CONTENT_DIR, 'zolnareport', "#{zolna_permalink_id}_240p.mp4")
      end

      def video480p_path
        @video480p_path ||= File.join(SHARE_CONTENT_DIR, 'zolnareport', "#{zolna_permalink_id}_480p.mp4")
      end

      def video720p_path
        @video720p_path ||= File.join(zolnareport_source_path, "#{zolna_permalink_id}.mp4")
      end


      end
    end
  end