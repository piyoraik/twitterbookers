class UsersController < ApplicationController
    include ApplicationHelper
    before_action :twitter
    def index
        @users = User.all
        @user = current_user
    end

    def show
        @profile = twitter.user(current_user.uid.to_i)
        @user = User.find(params[:id])
        # @tweets = twitter.user_timeline(@user.nickname)
        @test = current_user
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        user = User.find(params[:id])
        user.update(profile_params)
        redirect_to user_path(user)
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

        def profile_params
            params.require(:user).permit(:name, :description)
        end
end
