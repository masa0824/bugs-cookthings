class UsersController < ApplicationController
  before_action :logged_in_user, {only: [:edit, :update, :edit_pw]}
  before_action :logged_in_user_deny, {only: [:new, :create]}

  def new
      @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = '登録が完了しました'
      redirect_to root_url
    else
      flash.now[:danger] = 'えらー'
      render :new
    end
  end
  
  def edit
    @user = User.find_by(id: session[:user_id])
  end

  def update
    @user = User.find_by(id: session[:user_id])
    # 更新対象
    @user.id = session[:user_id]
    @user.email = user_params[:email]
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
    @user = User.find_by(id: session[:user_id])
  end

  def update_edit_pw
    @user = User.find_by(id: session[:user_id])
    # 更新対象
    @user.id = session[:user_id]
    @user.password = user_params[:password]

    if @user.save(context: :change_password)
      flash[:success] = '変更完了しました'
      redirect_to edit_pw_path
    else
      flash.now[:danger] = 'えらー'
      render edit_pw_path
    end
  end

  # 開発テスト用
  def test
    p 'TESTTESTTEST'
    SystemMailer.testmail.deliver_now
  end
end

private

def user_params
  params.require(:user).permit(:email, :password, :last_name, :first_name)
end