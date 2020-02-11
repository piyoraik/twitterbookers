class HomesController < ApplicationController
    def index
        @users = User.all
    end

    def top
    end
end
