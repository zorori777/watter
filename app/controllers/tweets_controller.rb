class TweetsController < ApplicationController

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

  private

  def twitter_params
    params.require(:tweet).permit(:text, :image)
  end
end
