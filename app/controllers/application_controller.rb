class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    if !current_user
      redirect_to root_path
    end
  end

  helper_method :current_user
end
