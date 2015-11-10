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
  
  post '/join_socialclub', to: 'join_social_club#create'
  post '/set_membership', to: 'set_membership#create'
  get '/token_expire', to: 'set_membership#expire'
  get '/setting_membership_successful', to: 'set_membership#success'
  
  resources :games, only: [:index, :show, :update, :edit ]

  resources :competitions, only: :show
  resources :teams, only: [:index, :show ]

  resources :event_participants, only: [:create, :destroy]
  resources :events, only: [:index, :show]

end
