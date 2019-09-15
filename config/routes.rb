Rails.application.routes.draw do
  resources :games, only: [:new, :create]

  get '/steps/:game_id', to: 'steps#current'
  resources :steps, only: [:update]

end
