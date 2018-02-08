Rails.application.routes.draw do
  root 'recipes#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  
  

  resources :users do
    resources :recipes
  end
  resources :ingredients, :categories, :recipes, :only => [:index]

  delete 'users/:id/recipe/:id', :to => 'recipe_ingredients#destroy'

  # root
end
