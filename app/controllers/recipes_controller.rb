class RecipesController < ApplicationController
  before_action :set_recipe!, :only => [:show, :edit]
  before_action :set_categories_ingredients, :only => [:index, :newest, :oldest, :shortest, :longest] 
  before_action :current_user, :only => [:show, :edit]
  before_action :has_permission?, :only => [:edit, :update, :destroy]
  before_action :set_filter_params, :only => [:index]

  def new
    if !logged_in?  
      redirect_to root_path         # is this necessary?   
    elsif logged_in? && current_user == User.find(params[:user_id])
      @recipe = Recipe.new(:user => current_user)
    else
      @recipe = Recipe.new(:user => current_user)
      redirect_to new_user_recipe_path(current_user)
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to user_recipe_path(@recipe.user, @recipe), {:notice => "Success! New Recipe Added."}
    else
      flash[:alert] = @recipe.errors.full_messages
      render :new
    end

  end
  
  def index
    if params[:user_id] && params[:order].present?      
      redirect_to "/recipes/#{params[:order]}"
    elsif params[:user_id]
      @recipes = Recipe.by_user(params[:user_id]).filter_options(session[:filter_params]) 
    elsif params[:order].present?      
      redirect_to "/recipes/#{params[:order]}"
    else
      @recipes = Recipe.all & Recipe.filter_options(session[:filter_params])
    end
  end
  
  def show    
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @recipe, status: 200}
    end
  end

  def recipe_data
    set_recipe!
    render json: @recipe
  end

  def edit
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    redirect_to user_recipe_path(current_user, @recipe)
  end

  def destroy
  end
    
  def newest
    @recipes = Recipe.newest & Recipe.filter_options(session[:filter_params])
    render :index
  end

  def oldest
    @recipes = Recipe.oldest & Recipe.filter_options(session[:filter_params])
    render :index
  end

  def shortest
    @recipes = Recipe.shortest & Recipe.filter_options(session[:filter_params])
    render :index
  end

  def longest
    @recipes = Recipe.longest & Recipe.filter_options(session[:filter_params])
    render :index
  end
  
  private
    def recipe_params
      params.require(:recipe).permit(
        :user_id,
        :title, 
        :time,
        :description,
        :directions,
        :category_ids => [], 
        :categories_attributes => [:name], 
        :ingredient_ids => [], 
        :ingredients_attributes => [[:name], [:recipe_ingredients => [[:quantity],[:preparation]]]]
        )
    end

    def set_recipe!
      @recipe = Recipe.find(params[:id])
    end

    def set_categories_ingredients
      @ingredients = Ingredient.all.order(:name)
      @categories = Category.all.order(:name)
    end

    def set_filter_params
      session[:filter_params] = {
        :by_ingredient => params[:ingredient_id],
        :by_category => params[:category_id],
        :by_user => params[:user_id]
      }      
      # raise session[:filter_params].inspect
    end
  
    def clear_session_filter_params
      session[:filter_params].clear
    end
    


end  # End of Class