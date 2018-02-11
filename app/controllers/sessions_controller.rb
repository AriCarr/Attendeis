class SessionsController < ApplicationController
  skip_before_action :require_login

  def login_local
	session[:user_id] = params["user_id"]
	@user = User.find(params["user_id"])
	redirect_to root_path
  end

  def new
      redirect_to user_saml_omniauth_authorize_path
  end

  def create
    begin
      redirect_to root_path
    rescue
      flash[:warning] = 'There was an error while trying to authenticate you...'
      redirect_to root_path
    end
  end

  def destroy
    if current_user
      session.delete(:user_id)
      # flash[:success] = 'See you!'
    end
    redirect_to root_path
  end
end
