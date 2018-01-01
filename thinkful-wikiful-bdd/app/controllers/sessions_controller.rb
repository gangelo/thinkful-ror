
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password]) # get this for free from User#has_secure_password
      session[:user_id] = user.id
      redirect_to root_url, notice: "Success! You're logged in!"
    else
      flash.now[:error] = "Aww, shucks! Email or password is invalid."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "You've been logged out! Have a nice day!"
  end
end
