module Zolna
  class PostToDTube
    include Verbalize::Action
    include Zolna::Common

    attr_reader :steemit_result

    input :permalink_id

    def call
      @steemit_result = post_transaction
      if steemit_result.keys.include?('error')
        local_record.update(steemit_post_response: steemit_result.to_json)
        fail!(steemit_result)
      else
        update_local_record
      end

      steemit_result
    end

    private

    def post_text
      @post_text ||= <<POST
<center><a href='https://d.tube/#!/v/zolnareport/#{dtube_permalink}'><img src='https://ipfs.io/ipfs/#{local_record.video_snap_url}'></a></center><hr>

#{local_record.description}

<a href='#{local_record.iframe_url}'>Click here to watch on ZolnaReport if video fails to load on DTube</a>

<a href="https://www.zolnareport.com/">ZolnaReport.com</a>

<hr><a href='https://d.tube/#!/v/zolnareport/#{dtube_permalink}'> ▶️ DTube</a><br /><a href='https://ipfs.io/ipfs/#{local_record.video720p_path}'> ▶️ IPFS</a>
POST
    end

    def local_record
      @local_record ||= ZolnaEmbedPage.find_by(permalink_id: permalink_id) || fail!("Couldn't find the local record of the permalink")
    end

    def json_metadata
      {
        "video":{
          "info":{
            "title": local_record.title,
            "snaphash": local_record.video_poster_ipfs_hash,
            "author": 'zolnareport',
            "permlink": dtube_permalink,
            "duration": local_record.video_duration,
            "filesize": local_record.video_filesize,
            "spritehash":""
          },
          "content":{
            "videohash": local_record.video720p_ipfs_hash,
            "description": post_text,
            "tags": local_record.additional_tags.split(',')
          }
        },
        tags: ['dtube'] + local_record.additional_tags.split(','),
        "app":"dtube/0.7"
      }
    end

    def post_transaction
      tx = Radiator::Transaction.new(wif: STEEMIT_POSTING_KEY)
      tx.operations << steemit_details
      # tx.operations << steemit_options
      tx.process(true)
    end

    def steemit_details
      @steemit_details ||= {
        type: :comment,
        author: 'zolnareport',
        body: post_text,
        category: 'politics',
        parent_permlink: local_record.additional_tags.split(',').first,
        permlink: dtube_permalink,
        tags: local_record.additional_tags.split(',') + ['dtube'],
        title: CGI.unescapeHTML(local_record.title),

        json_metadata: json_metadata.to_json,
        parent_author: ''
      }
    end

    def dtube_permalink
      "2018-dtube-#{Zolna::Common.steemit_permalink_from_title(local_record.title)}"
    end

    def steemit_tags
      @steemit_tags ||= local_record.additional_tags.split(',')
    end

    def update_local_record
      local_record.update(dtube_permalink: dtube_permalink, steemit_post_content:post_text, steemit_post_time: Time.current, steemit_post_response: steemit_result.to_json)
    end
  end
end