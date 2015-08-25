Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'games#index'
  
  resources :games, only: [:index, :show ]
end
