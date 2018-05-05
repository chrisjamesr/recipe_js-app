Rails.application.routes.draw do
  get 'categories/index'

  root 'welcome#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  
  

  resources :users do
    resources :recipes
  end
  get '/recipes/:id/comments' => 'comments#index'
  post '/recipes/:id/comments' => 'comments#create'
  
  # resources :users do
  #   resources :recipes do
  #     resources :comments, :only => [:index, :create]
  #   end
  # end

  

  resources :ingredients, :recipes, :only => [:index] 
  get '/categories' => 'categories#index'


  # delete '/recipes/:recipe_id/recipe_ingredients/:id', :to => 'recipe_ingredients#destroy', :as => :remove_ingredient
  delete '/recipes/:recipe_id/recipe_ingredients/:id', :to => 'recipe_ingredients#destroy'

  get '/recipes/newest' => 'recipes#newest'
  get '/recipes/oldest' => 'recipes#oldest'
  get '/recipes/longest' => 'recipes#longest'
  get '/recipes/shortest' => 'recipes#shortest'  
  get '/users/:id/recipes/:id/recipe_data', to: 'recipes#recipe_data'
  
end
