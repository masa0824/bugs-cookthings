class UsersController < ApplicationController
  before_action :logged_in_user, {only: [:edit, :update]}
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
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: session[:user_id])
    # 更新対象
    @user.id = session[:user_id]
    @user.email = user_params[:email]
    @user.last_name = user_params[:last_name]
    @user.first_name = user_params[:first_name]
    
    if @user.save
      flash[:success] = '登録変更が完了しました'
      redirect_to("/users/#{@user.id}/edit")
    else
      flash.now[:danger] = 'えらー'
      render("users/edit")
    end
  end
end

private

def user_params
  params.require(:user).permit(:email, :password, :last_name, :first_name)
end