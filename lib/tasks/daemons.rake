namespace :daemons do

  desc "Runs the daily market scanning background programs"
  task :run_zolna => :environment do
    # infinite loop until Ctrl+C hit
    while 1 do
      until valid_hour?
        sleep 60
      end

      until (post = ZolnaEmbedPage.in_post_queue.first).present?
        puts "Queue Count: #{ZolnaEmbedPage.in_post_queue.count} - sleep 30s (#{Time.now})"
        sleep 30
      end

      puts "Posting #{post.title} (#{post.permalink_id}) - #{Time.now}"
      outcome, value = Zolna::PostToSteemit.(permalink_id: post.permalink_id)
      post.reload
      puts post.steemit_post_response

      if outcome==:error && value['error']['message'] =~ /bandwidth limit exceeded/
        post.update(steemit_post_response: nil)
        sleep 300
      end

      # if SteemitVoteHistory.votes_today('zolnareport') < 18 && outcome==:ok
      #   sleep 5
      #   outcome, value = Steemit::UpvotePost.(
      #     voting_as_user: 'zolnareport',
      #     post_author: 'zolnareport',
      #     post_steemit_permalink_id: post.steemit_permalink
      #   )
      #   puts "Upvote Response: #{outcome}, #{value}"
      # end
      #
      # if SteemitVoteHistory.votes_today('greenspudtrades') < 18 && outcome==:ok
      #   sleep 5
      #   outcome, value = Steemit::UpvotePost.(
      #     voting_as_user: 'greenspudtrades',
      #     post_author: 'zolnareport',
      #     post_steemit_permalink_id: post.steemit_permalink
      #   )
      #   puts "Upvote Response: #{outcome}, #{value}"
      # end

      sleep 300
    end
  end

  task :run_upvoter => :environment do
    Steemit::CurationUpvoter.call
  end

  def valid_hour?
    if Date.today.on_weekday?
      Time.now.hour >=19 && Time.now.hour < 22
    else
      Time.now.hour >=11 && Time.now.hour < 21
    end
  end

end