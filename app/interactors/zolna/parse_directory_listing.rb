module Zolna
  class ParseDirectoryListing
    include Verbalize::Action

    INDEX_URL="https://zolnareport.com/#{ENV.parse('CURRENT_YEAR')}/"

    def call
      fail! 'failed to download the video index' unless index_html.code==200

      #tr1: [ [td icon (discard), tdlink url, td last_edited_timestamp], td size, td description (discard)
      #tr2:   [td, td, td...]
      #tr3:   [td, td, td...] ]
      link_urls = noko_tr.map do |tr|
        _link_url = tr.children[1].children[0].text if tr.children[1].try(:children).try(:first)
      end

      permalinks = link_urls
        .compact
        .map { |url| url.scan(/(x\w+)\.html/).first.try(:first) }
        .compact

      permalinks.each do |permalink|
        ZolnaEmbedPage.create(permalink_id: permalink) unless ZolnaEmbedPage.find_by(permalink_id: permalink)
      end

      permalinks
    end

    private

    def body
      @body ||= index_html.response_body
    end

    def noko
      @noko ||= Nokogiri.parse(body)
    end

    def noko_tr
      @noko_tr ||= noko.css('tr')
    end

    def index_html
      @index_html ||= Typhoeus.get(INDEX_URL)
    end
  end
end