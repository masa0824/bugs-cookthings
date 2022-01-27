class ApplicationController < ActionController::Base
    # 共通Helper用
    include SessionsHelper

    private
   # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        redirect_to login_url
      end
    end

    # ログイン済みユーザーの場合、アクセス不可ページの処理
    def logged_in_user_deny
      if logged_in?
        redirect_to recipes_path
      end
    end
end
