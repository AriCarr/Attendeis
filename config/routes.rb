Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :attendances
  get '/users/auth/:provider/callback', to: 'sessions#create'

  post '/checkin', to: 'users#checkin'

  post '/create_attendance', to: 'attendances#create'
  post '/restart_attendance', to: 'attendances#restart'
  post '/stop_attendance', to: 'attendances#stop'

  post '/delete_attendance', to: 'attendances#delete'

  resources :courses do
    collection do
      post :download_csv
    end
  end
  # resources :users
  devise_for :users, controllers: { omniauth_callbacks: 'authentications' }

  post '/change', to: 'attendances#change', as: 'change'

  post '/change_state', to: 'courses#change_state', as: 'change_state'

  post '/enroll', to: 'courses#enroll', as: 'enroll'
  post '/unenroll', to: 'courses#unenroll', as: 'unenroll'

  post '/teacher_add', to: 'courses#teacher_add', as: 'teacher_add'
  post '/teacher_remove', to: 'courses#teacher_remove', as: 'teacher_remove'

  post '/dict_add', to: 'courses#dict_add', as: 'dict_add'
  post '/dict_remove', to: 'courses#dict_remove', as: 'dict_remove'

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new', as: :new_session
    get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  get '/logout', to: 'sessions#destroy'

  get '/login/:user_id' => 'sessions#login_local' if Rails.env.development?
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'pages#index'
end
