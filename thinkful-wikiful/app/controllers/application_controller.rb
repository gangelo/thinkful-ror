class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user?, :current_user, :format_date, :css_style_from

  before_action :get_categories

  def authorize
    redirect_to login_url, alert: "Ouch! You're not authorized!" if current_user.nil?
  end

  def format_date(date)
    date.strftime('%b %d, %Y') if date.respond_to? :strftime
  end

  def css_style_from(object)
    style = ""
    style += "background-color:#{object.background_color} !important;" if object.respond_to? :background_color
    style += "color:#{object.color} !important;" if object.respond_to? :color
  end

  protected

  def plural_page_title(model)
    model.model_name.plural.humanize
  end

  def singular_page_title(model)
    model.model_name.singular.humanize
  end

  def params_id_valid?
    params.has_key?(:id) && params[:id].to_i > 0
  end

  private

  def get_categories
    @categories = Category.all.order(:name)
  end

  def current_user?
    current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
