class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_default_user

  helper_method :displaying_current_user?

  protected

  def set_default_user
    @user = current_user
  end

  # See section on Strong Parameters: https://github.com/plataformatec/devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :username
  end

  private

    def displaying_current_user?
      @user.id == current_user.id
    end
end
