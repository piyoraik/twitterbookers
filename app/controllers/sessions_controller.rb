class SessionsController < ApplicationController
    include ApplicationHelper
    def create
        #! request.env['omniauth.auth'][:uid]にデータが入っていないなら
        unless request.env['omniauth.auth'][:uid]
          flash[:danger] = '連携に失敗しました'
          redirect_to root_url
        end
        #! Jsonの代入
        user_data = request.env['omniauth.auth']
        #! Userモデルのuidにuser_data[:uid]を代入
        user = User.find_by(uid: user_data[:uid])
        #! Userに値が入っているならログイン
        if user
          log_in user
          flash[:success] = 'ログインしました'
          redirect_to root_url
        #! Userに値が入っていないなら新規登録
        else
          new_user = User.new(
            uid: user_data[:uid],
            nickname: user_data[:info][:nickname],
            name: user_data[:info][:name],
            image: user_data[:info][:image],
            description: user_data[:info][:description]
          )
          #! 保存に成功したら
          if new_user.save
            log_in new_user
            flash[:success] = 'ユーザー登録成功'
          #! 保存に失敗したら
          else
            flash[:danger] = '予期せぬエラーが発生しました'
          end
          redirect_to root_url
        end
      end
    
    
      def destroy
        log_out if logged_in?
        flash[:success] = 'ログアウトしました'
        redirect_to root_url
      end
end
