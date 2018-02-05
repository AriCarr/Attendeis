class AuthenticationsController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token

  # This method is called to enable users to log in with Shibboleth
  def saml
    hash = request.env['omniauth.auth']
    @user = User.from_saml(hash)
    session[:user_id] = @user.id
    flash[:success] = "Welcome, #{@user.name}!"
    redirect_to @user
  rescue
    flash[:warning] = 'There was an error while trying to authenticate you...'
    redirect_to root_path
  end

end
