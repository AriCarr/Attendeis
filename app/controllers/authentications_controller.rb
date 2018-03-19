class AuthenticationsController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, :require_login

  # This method is called to enable users to log in with Shibboleth
  def saml
    hash = request.env['omniauth.auth']
    session[:user_id] = hash['extra']['raw_info'].attributes['urn:oid:0.9.2342.19200300.100.1.1'][0]
    @user = User.from_saml(hash)
    # flash[:success] = "Welcome, #{@user.name}!"
    redirect_to root_path
  rescue
    flash[:warning] = 'There was an error while trying to authenticate you...'
    redirect_to root_path
  end

end
