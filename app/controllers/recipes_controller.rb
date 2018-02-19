class RecipesController < ApplicationController
  before_action :set_recipe!, :only => [:show, :edit]
  before_action :set_categories_ingredients, :only => [:index, :newest, :oldest, :shortest, :longest] 
  before_action :current_user, :only => [:show, :edit]
  before_action :has_permission?, :only =>[:edit, :update, :destroy]


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
    # raise params.inspect
    if params[:user_id]
      @recipes = Recipe.where(:user_id => params[:user_id])
    elsif params[:filter].present?
      redirect_to "/recipes/#{params[:filter]}"
    else
      @recipes = Recipe.all
    end
  end
  
  def show
    
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
    @recipes = Recipe.newest
    render :index
  end

  def oldest
    @recipes = Recipe.oldest
    render :index
  end

  def shortest
    @recipes = Recipe.shortest
    render :index
  end

  def longest
    @recipes = Recipe.longest
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

end
