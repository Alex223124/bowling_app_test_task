Rails.application.routes.draw do
  resources :games, only: [:new, :create, :index, :show]

  get '/steps/:game_id', to: 'steps#current'
  resources :steps, only: [:update]

end
