# This controller handles the callback after authenticating with Shibboleth
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :require_login

  def saml
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => 'Saml') if is_navigational_format?
    else
      session['devise.saml_data'] = request.env['omniauth.auth']
      redirect_to @user
    end
  end

  def failure
    redirect_to root_path
  end
end
