class SessionsController < ApplicationController
  before_action :logged_in_user, {only: [:destroy]}
  before_action :logged_in_user_deny, {only: [:new, :create]}

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    ret_login_check = login_check(user, params[:session][:password])
    
    if ret_login_check['login']
      log_in user
      redirect_to recipes_url
    else
      flash.now[:notice] = ret_login_check['msg']
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def rule
  end

  def news
    # ニュースチェックフラグをオフにする
    #   ※ UPDATE "public"."users" SET "check_latest_news" = 't' WHERE 1=1;
    User.find(current_user.id)
    User.update(check_latest_news: false)

    # ヘッダー非表示
    @header_show = false
  end

  private

  # ログインチェック
  def login_check(user, passwd_auth)
    ret = {}
    ret['login'] = false

    # ユーザーメールアドレスの有無チェック
    if !user
      ret['msg'] = 'メールアドレスもしくはパスワードが違います'
      return ret
    end
    
    # パスワードのチェック
    if !user.authenticate(passwd_auth)
      ret['msg'] = 'メールアドレスもしくはパスワードが違います'
      return ret
    end

    # アカウントの本登録チェック
    if !user.activated?
      ret['msg'] = 'アカウントが本登録されてません'
      return ret
    end

    # アカウントの凍結チェック
    if user.acount_lock?
      ret['msg'] = 'アカウントが凍結されています'
      return ret
    end

    ret['login'] = true
    return ret
  end
end
