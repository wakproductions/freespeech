module Zolna
  module Common
    BASE_URL='https://www.zolnareport.com/'
    STEEMIT_POSTING_KEY=ENV.fetch('STEEM_WIF_ZOLNAREPORT')

    def self.steemit_permalink_from_title(title)
      CGI.unescapeHTML(title)
        .gsub(/[^A-Z0-9\-\s]+/i, '')
        .gsub(' ', '-')
        .downcase
        .gsub(/[^A-Z0-9]*$/i, '') # strip any weird characters at the end like "sheila-jackson-lee-dumb-as-a-box-of-rocks-----------------------"
    end

    private

    def self.strip_unwanted_characters(string)
      string.gsub(/[^ULDR0-9<>]+/i, '')
    end
  end
end