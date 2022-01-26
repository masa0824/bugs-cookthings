class UsersController < ApplicationController
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
  
end

private

def user_params
  params.require(:user).permit(:email, :password, :last_name, :first_name)
end