class SessionsController < ApplicationController

  def new

  end

  def create
    session[:current_user] = 'greenspudtrades'
    session[:posting_wif] = ENV.fetch('STEEM_WIF_GREENSPUDTRADES')
    binding.pry
    redirect_to(video_path(1))
  end
end
