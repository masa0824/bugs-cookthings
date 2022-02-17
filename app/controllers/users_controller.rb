class UsersController < ApplicationController
  before_action :logged_in_user, {only: [:edit, :update, :edit_pw]}
  before_action :logged_in_user_deny, {only: [:new, :create, :reset_password, :reset_password_sendmail, :reset_password_edit, :reset_password_update]}
  before_action :get_user,   only: [:reset_password_edit, :reset_password_update]
  before_action :valid_user, only: [:reset_password_edit, :reset_password_update]
  before_action :check_expiration, only: [:reset_password_edit, :reset_password_update]

  def new
      @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = '仮登録が完了しました。送られたメールにて本登録ください。'
      # 本登録アクティベーション案内
      activation = User.find_by(email: @user.email)
      activation.create_activation_digest
      redirect_to root_url
    else
      flash.now[:danger] = 'えらー'
      render :new
    end
  end
  
  def edit
    @menu_page_title = 'ユーザー情報'
    @user = User.find_by(id: current_user.id)
    @capacity = user_total_capacity
  end

  # ユーザーアカウント情報更新
  def update
    @user = User.find_by(id: current_user.id)
    # 更新対象
    @user.id = current_user.id
    #@user.email = user_params[:email]
    @user.last_name = user_params[:last_name]
    @user.first_name = user_params[:first_name]
    
    if @user.save(context: :change_userinfo)
      flash[:success] = '登録変更が完了しました'
      redirect_to edit_users_path
    else
      flash.now[:danger] = 'えらー'
      render edit_users_path
    end
  end
  
  def edit_pw
    @user = User.find_by(id: current_user.id)
  end

  def update_edit_pw
    @user = User.find_by(id: current_user.id)
    # 更新対象
    @user.id = current_user.id
    @user.password = user_params[:password]

    if @user.save(context: :change_password)
      flash[:success] = '変更完了しました'
      redirect_to edit_pw_path
    else
      flash.now[:danger] = 'えらー'
      render edit_pw_path
    end
  end

  # アカウント有効化
  def account_activation_edit
    #@user = User.new
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:token])
      user.update_attribute(:activated,    true)
      user.update_attribute(:activated_at, Time.zone.now)
      #log_in user
      flash[:success] = "Account activated!"
     #redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
  
  # パスワードリセット
  def reset_password
    @user = User.new
  end

  def reset_password_sendmail
    @user = User.new(user_params)
    if @user.valid?(:reset_password)
      reset_password = User.find_by(email: params[:user][:email])
      reset_password.create_reset_digest
      reset_password.reset_token
      reset_password.send_password_reset_email
    else
      render reset_password_path
    end
  end

  # パスワードリセット
  def reset_password_edit
  end

  # パスワードリセットによる更新
  def reset_password_update
    # 更新対象
    @user.password = user_params[:password]

    if @user.save(context: :change_password)
      flash[:success] = '変更完了しました'
    else
      flash[:danger] = 'えらー'
      #render reset_password_edit_path(params[:token], email: @user.email)
      redirect_to reset_password_edit_url(params[:token], email: @user.email)
    end
  end

  # アカウント削除ページ
  def account_delete
    @user = User.find_by(id: current_user.id)
  end

  # アカウント削除
  def destroy
    @user = User.find_by(id: current_user.id)
    log_out
    @user.destroy
    redirect_to root_url
  end
  
  # 開発テスト用
  def test
    p 'TESTTESTTEST'
    SystemMailer.testmail.deliver_now
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :last_name, :first_name)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  # 正しいユーザーかどうか確認する
  def valid_user
    @user.authenticated?(:reset, params[:token])
    unless (@user && @user.authenticated?(:reset, params[:token]))
      redirect_to root_url
    end
  end

  # トークンが期限切れかどうか確認する
  def check_expiration
    @user.password_reset_expired?
    if @user.password_reset_expired?
      flash[:danger] = "パスワードのリセットの有効期限が切れました。"
      redirect_to reset_password_url
    end
  end

  # ユーザーアカウントの使用容量
  def user_total_capacity
    ret_cap = ActiveRecord::Base.connection.select_one("select check_upload_capacity(#{current_user.id});")
    total_cap = ret_cap['check_upload_capacity']
    case total_cap
      when nil
        return '0バイト[未使用]'
      when 0..(1024**1-1)
        return (total_cap).to_s + 'B'
      when 1024**1..(1024**2-1)
        return (total_cap/1024**1.to_f).round(2).to_s + 'KB'
      when 1024**2..(1024**3-1)
        return (total_cap/1024**2.to_f).round(2).to_s + 'MB'
      when 1024**3..nil
        return (total_cap/1024**2.to_f).round(2).to_s + 'GB'
      else
        return '???'
    end
  end
end