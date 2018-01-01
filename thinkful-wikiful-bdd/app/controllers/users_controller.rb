class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if User.account_exists? @user
      flash[:error] = 'The username and/or email address is already in use.'
      render(:new) and return
    end
    if @user.save
      session[:user_id] = @user.id # Auto-login
      redirect_to root_url, notice: "Success! Thank you for signing up!"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :user_name, :password, :password_confirmation)
  end
end
