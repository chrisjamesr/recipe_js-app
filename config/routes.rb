Rails.application.routes.draw do
  root 'welcome#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  
  

  resources :users do
    resources :recipes, :shallow => true 
  end

  resources :ingredients
  resources :categories

  # root
end
