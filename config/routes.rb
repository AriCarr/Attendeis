Rails.application.routes.draw do
  resources :users

  root to: 'sessions#new'

  devise_for :users, :controllers => { :omniauth_callbacks => "authentications"}
  devise_scope :users do
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
