require 'open-uri'

class TweetsController < ApplicationController
  before_action :twitter_client, except: :new

  def new
    @tweet = Tweet.new
  end

  def create
    tweet = Tweet.create(twitter_params)
    redirect_to :root, notice: 'You can create!'

    if tweet.invalid?
      return render :new
    end
  end

  def post
    tweet = Tweet.order('rand()').first
    status = tweet.text
    media = open(tweet.image)
    @client.update_with_media(status, media)
    redirect_to :root
  end

  def twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end

  private

  def twitter_params
    params.require(:tweet).permit(:text, :image)
  end
end
