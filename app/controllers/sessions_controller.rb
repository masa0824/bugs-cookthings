class SessionsController < ApplicationController
  before_action :logged_in_user, {only: [:destroy]}
  before_action :logged_in_user_deny, {only: [:new, :create]}

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        redirect_to recipes_url
      else
        flash.now[:notice] = 'アカウントが本登録されてません'
        render 'new'
      end
    else
      flash.now[:notice] = 'メールアドレスもしくはパスワードが違います'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
