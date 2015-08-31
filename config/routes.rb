Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'games#index'
  get '/leaderboard', to: 'teams#index'

  resources :games, only: [:index, :show ]
  resources :teams, only: [:index, :show ]
end
