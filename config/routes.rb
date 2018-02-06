Rails.application.routes.draw do
  get '/users/auth/:provider/callback', to: 'sessions#create'

  resources :courses
  resources :users
  devise_for :users, :controllers => { :omniauth_callbacks => "authentications"}

  post '/change_state', to: 'courses#change_state', as: 'change_state'

  get '/attendance', to: 'courses#attendance'

  post '/enroll', to: 'courses#enroll', as: 'enroll'
  post '/unenroll', to: 'courses#unenroll', as: 'unenroll'

  devise_scope :user do
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  get '/login/:user_id' => 'sessions#login_local' if Rails.env.development?
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'pages#index'

end
