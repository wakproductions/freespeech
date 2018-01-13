# this comment is a trivial change

module Steemit
  class CurationUpvoter

    FOLLOWING_AUTHORS=[
      { author: 'exyle', categories: [] },
      { author: 'sweetsssj', categories: [] },
      { author: 'sgtreport', categories: [] },
      { author: 'heimindanger', categories: [] },
      { author: 'jerrybanfield', categories: ['cryptocurrency'] },
      { author: 'joshsigurdson', categories: ['dtube'] },
      { author: 'timcliff', categories: [] },
      # { author: 'haejin', categories: ['money', 'bitcoin', 'bitshares'] },
    ]
    # * davidpakman (only in dtube category, and use only greenspudtrades) - can't do it I hate this guy

    def self.call
      self.new.call
    end

    def call
      stream = Radiator::Stream.new
      stream.operations(:comment) do |op|
        # puts "#{op.author}: #{op.title}"
        if authors.include?(op[:author]) && op[:title].present?
          if author_details(op[:author])[:categories].none? || author_details(op[:author])[:categories].include?(op[:category])
            
            Thread.new do
              puts "Waiting 30 minutes for upvote on #{op.author}: #{op.title}"
              sleep 30 * 60

              puts "Upvoting #{op[:author]}: #{op[:title]}"
              outcome, value = Steemit::UpvotePost.(
                voting_as_user: 'zolnareport',
                  post_author: op[:author],
                  post_steemit_permalink_id: op[:permlink]
              )
              puts "Upvote Response: #{outcome}, #{value}"

              if SteemitVoteHistory.votes_today('greenspudtrades') < 18 && outcome==:ok
                sleep 5
                outcome, value = Steemit::UpvotePost.(
                  voting_as_user: 'greenspudtrades',
                    post_author: op[:author],
                    post_steemit_permalink_id: op[:permlink]
                )
                puts "Upvote Response: #{outcome}, #{value}"
              end
            end
          end
        end
      end


    end

    private

    def authors
      @authors ||= FOLLOWING_AUTHORS.map { |fa| fa[:author] }
    end

    def author_details(author)
      FOLLOWING_AUTHORS.select { |fa| fa[:author] == author }.first
    end

  end
end