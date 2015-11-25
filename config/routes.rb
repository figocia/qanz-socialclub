Rails.application.routes.draw do
  root to: 'pages#front'

  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'pages#home'
  get '/leaderboard', to: 'teams#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/my_games', to: 'games#my_games'
  get '/my_events', to: 'events#my_events'
  
  
  get '/confirm_membership', to: 'set_membership#confirm'
  get '/setting_membership_successful', to: 'set_membership#success'

  get '/confirm_email_send', to: 'forgot_password#confirm'
  get '/token_expire', to: 'pages#expire'

  resources :games, only: [:index, :show, :update, :edit ]

  resources :competitions, only: :show
  resources :teams, only: [:index, :show ]

  resources :event_participants, only: [:create, :destroy]
  resources :events, only: [:index, :show]

  resources :join_social_club, only: :create

  resources :forgot_password, only: [:create, :new]
  resources :reset_password, only: [:create, :new]
  
  namespace :admin do
    resources :batch_users_generation, only: [:create, :new]
  end
end
