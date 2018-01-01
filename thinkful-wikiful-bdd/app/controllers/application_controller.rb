class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user?, :current_user

  protected

  def params_id_valid?
    params.has_key?(:id) && params[:id].to_i > 0
  end
  
  private

  def current_user?
    current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
