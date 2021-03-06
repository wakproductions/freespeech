module Zolna
  class ExtractVideoMetadata
    include Verbalize::Action
    include Zolna::Common

    CURRENT_YEAR='2018'

    input :permalink_id

    def call
      video_metadata
    end

    def self.update_local_database
      # ZolnaEmbedPage.where(iframe_url: nil)
      ZolnaEmbedPage.where(title: nil)
        .map { |ep| ep.update(self.call(permalink_id: ep.permalink_id).value) }
    end

    private

    def get_tag(name)
      if n.css("html>head>meta[property='og:#{name}']").first.present?
        n.css("html>head>meta[property='og:#{name}']").first.attributes['content'].value
      end
    end

    def format_image_url(url)
      uri = URI.parse(url)
      uri.host = SERVER_ADDRESS
      uri.to_s
    end

    def iframe_html
      @iframe_html ||= Typhoeus.get(iframe_url)
    end

    def iframe_url
      @iframe_url ||= "#{BASE_URL}#{CURRENT_YEAR}/#{permalink_id}.html"
    end

    def n
      @noko ||= Nokogiri.parse(iframe_html.response_body)
    end

    def video_metadata
      @video_metadata ||= {
        description: get_tag('description'),
        iframe_url: iframe_url,
        title: get_tag('title'),
        video_snap_url: format_image_url(get_tag('image')),
      }
    end

  end
end