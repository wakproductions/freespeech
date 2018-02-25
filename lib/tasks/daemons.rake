namespace :daemons do

  desc "Runs the daily market scanning background programs"
  task :run_zolna => :environment do
    # infinite loop until Ctrl+C hit
    puts "Starting Zolna Steemit Daemon - #{Time.current}"
    while 1 do
      until (post = ZolnaEmbedPage.in_post_queue.first).present? && valid_hour?
        sleep 600
        puts "Queue Count: #{ZolnaEmbedPage.in_post_queue.count} - sleep 600s (#{Time.current})"

        Zolna::ParseDirectoryListing.call
        Zolna::ExtractVideoMetadata.update_local_database
        ZolnaEmbedPage.where(additional_tags: nil).update(additional_tags: 'politics')
        ZolnaEmbedPage.postable.each { |post| post.add_to_queue }
      end

      puts "Posting #{post.title} (#{post.permalink_id}) - #{Time.current}"
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
    if Date.current.on_weekday?
      Time.current.hour >=19 && Time.current.hour < 22
    else
      Time.current.hour >=11 && Time.current.hour < 21
    end
  end

end