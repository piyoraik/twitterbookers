class UsersController < ApplicationController
    include ApplicationHelper
    before_action :twitter
    def index
        @users = User.all
        @profile = twitter.user(current_user.uid.to_i)
    end

    def show
        @profile = twitter.user(current_user.uid.to_i)
        @user = User.find(params[:id])
        @tweets = twitter.user_timeline(@user.nickname)
    end

    private
        def twitter
            client = Twitter::REST::Client.new do |config|
                config.consumer_key = ENV['TWITTER_API_KEY']
                config.consumer_secret = ENV['TWITTER_API_SECRET']
                config.access_token = ENV['TWITTER_ACCSESS_TOKEN']
                config.access_token_secret = ENV['TWITTER_ACCSESS_TOKEN_SECRET']
            end
        end
end
