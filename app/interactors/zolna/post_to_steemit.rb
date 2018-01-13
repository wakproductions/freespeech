module Zolna
  class PostToSteemit
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

      local_record.reload
    end

    private

    def post_text
      <<POST
<a href="#{local_record.iframe_url}"><img src="#{local_record.video_snap_url}" /></a>

#{local_record.description}

<a href="https://www.zolnareport.com/" target="_blank">Check out the rest of Gabe Zolna's videos at ZolnaReport.com!</a>
POST

    end

    def local_record
      @local_record ||= ZolnaEmbedPage.find_by(permalink_id: permalink_id) || fail!("Couldn't find the local record of the permalink")
    end

    def post_transaction
      tx = Radiator::Transaction.new(wif: STEEMIT_POSTING_KEY)
      tx.operations << steemit_details
      tx.operations << steemit_options
      tx.process(true)
    end

    def steemit_details
      @steemit_details ||= {
        type: :comment,
        author: 'zolnareport',
        body: post_text,
        parent_permlink: local_record.additional_tags.split(',').first,
        permlink: steemit_permalink,
        tags: local_record.additional_tags.split(','),
        title: CGI.unescapeHTML(local_record.title),

        json_metadata: {tags: local_record.additional_tags.split(',')}.to_json,
        parent_author: ''
      }
    end

    def steemit_options
      @steemit_options ||= {
        type: :comment_options,
        max_accepted_payout: '1000000.000 SBD',
        percent_steem_dollars: 10000,
        allow_replies: true,
        allow_votes: true,
        allow_curation_rewards: true,
        beneficiaries: [{"greenspudtrades":10000}],
        # beneficiaries: [],
        author: "zolnareport",
        permlink: steemit_permalink,
        extensions: Radiator::Type::Beneficiaries.new(greenspudtrades: 10000)
      }
    end

    def steemit_permalink
      "2017-#{Zolna::Common.steemit_permalink_from_title(local_record.title)}"
    end

    def steemit_tags
      @steemit_tags ||= local_record.additional_tags.split(',')
    end

    def update_local_record
      local_record.update(steemit_permalink: steemit_permalink, steemit_post_content:post_text, steemit_post_time: Time.now, steemit_post_response: steemit_result.to_json)
    end
  end
end