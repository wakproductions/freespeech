module Steemit
  class UpvotePost
    include Verbalize::Action

    attr_reader :steemit_result

    input :voting_as_user, :post_author, :post_steemit_permalink_id

    def call
      @steemit_result = post_transaction
      if steemit_result.keys.include?('error')
        fail!(steemit_result)
      else
        record_vote
      end

      steemit_result
    end

    private

    def post_transaction
      tx = Radiator::Transaction.new(wif: wif)
      tx.operations << steemit_details
      tx.process(true)
    end

    def steemit_details
      @steemit_details ||= {
        type: :vote,
        voter: voting_as_user,
        author: post_author,
        permlink: post_steemit_permalink_id,
        weight: 10000,
      }
    end

    def record_vote
      SteemitVoteHistory.create(
        voted_as_user: voting_as_user,
        post_author: post_author,
        steemit_permalink_id: post_steemit_permalink_id,
        voted_at: Time.now,
      )
    end

    def wif
      ENV.fetch("STEEM_WIF_#{voting_as_user.upcase}")
    end

  end
end