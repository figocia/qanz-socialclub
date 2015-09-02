Rails.application.routes.draw do
  root to: 'pages#front'

  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'games#index'
  get '/leaderboard', to: 'teams#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'


  resources :games, only: [:index, :show ] do
    collection do
      get 'my_games'
    end
  end

  resources :teams, only: [:index, :show ]

end
