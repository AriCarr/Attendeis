Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :attendances
  get '/users/auth/:provider/callback', to: 'sessions#create'

  post '/checkin', to: 'users#checkin'

  post '/create_attendance', to: 'attendances#create'
  post '/restart_attendance', to: 'attendances#restart'
  post '/stop_attendance', to: 'attendances#stop'

  resources :courses
  # resources :users
  devise_for :users, controllers: { omniauth_callbacks: 'authentications' }

  post '/change_state', to: 'courses#change_state', as: 'change_state'

  post '/enroll', to: 'courses#enroll', as: 'enroll'
  post '/unenroll', to: 'courses#unenroll', as: 'unenroll'

  post '/admin_add', to: 'courses#admin_add', as: 'admin_add'
  post '/admin_remove', to: 'courses#admin_remove', as: 'admin_remove'

  post '/dict_add', to: 'courses#dict_add', as: 'dict_add'
  post '/dict_remove', to: 'courses#dict_remove', as: 'dict_remove'

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
    get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  get '/logout', to: 'sessions#destroy'

  get '/login/:user_id' => 'sessions#login_local' if Rails.env.development?
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'pages#index'
end
