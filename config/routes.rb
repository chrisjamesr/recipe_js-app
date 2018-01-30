Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  post '/logout' => 'session#destroy'
  
  get '/auth/:provider/callback', to: 'sessions#create'

  resources :user do
    resources :recipe 
  end

  resources :ingredient

  # root
end
