class SteemitVoteHistory < ApplicationRecord
  
  def self.votes_today(voted_as_user)
    SteemitVoteHistory.where(voted_as_user: voted_as_user).where('voted_at > ?', Time.now - 1.day).count
  end
end
