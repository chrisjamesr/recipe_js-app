$(document).on('turbolinks:load', function(){
  addEventListeners()
})

function addEventListeners(){
  $('#js-next').on('click', ()=>loadNext())
  $('#js-previous').on('click', ()=>loadPrevious())
  $('.js-user-link').on('click', (tag)=>loadIndexedRecipes(tag))
    // add event listener to recipe links
  // $('.js-user-recipe-link').on('click', (tag)=>loadShowRecipe(tag))
}

 // Event Handlers

function loadIndexedRecipes(tag){
  event.preventDefault()
  let userUrl = $(tag.target).attr('href')
  let userId = userUrl.match(/\d+/)[0] 
  let indexedRecipes = []
  $.get(userUrl, {user_id: userId} , null,'json')
    .done(function(response){
      response.forEach(function(element){    
       return indexedRecipes.push(Recipe.findOrCreate(element))        
    })
    displayIndexedRecipes(indexedRecipes)    
  })
}

// function displays ajax rendered recipes in page 
// requires additional partial for previous/next navigation
function loadShowRecipe(tag){
  event.preventDefault()
  let recipeLink = tag.currentTarget.href 
  $.get(recipeLink,'',null,'json').done(displayShowRecipe)
}

      // Index Page Functions
function displayIndexedRecipes(indexedRecipes){
  let recipeTemplateString = $('#recipe-template').html()
  let recipeTemplate = Handlebars.compile(recipeTemplateString);
  $('#recipe-cards').html(recipeTemplate({ recipes: indexedRecipes}))
  // add event listener to newly rendered recipe links
  // $('.js-user-recipe-link').on('click', (tag)=>loadShowRecipe(tag))
}

      // Show Page Functions
function loadNext(){
  event.preventDefault()
  let userUrl = $('#js-user-link').attr('href')
  let currentId = $('#js-recipe-title').data()["recipeId"]
  $.get(`${userUrl}/${currentId}`,{ new_recipe_id: currentId+1 },null,'json')
    .done(displayShowRecipe)  
}

function displayIngredientRows(){
  // Handlebars.registerHelper('list_ingredient', function())
}

function loadPrevious(){
  event.preventDefault()
  let userUrl = $('#js-user-link').attr('href')
  let currentId = $('#js-recipe-title').data()["recipeId"]
  $.get(`${userUrl}/${currentId}`,{ new_recipe_id: currentId+1 },null,'json')
    .done(displayShowRecipe)  
}

function updateEditLink(recipe){
  $('#js-edit-link').attr("href", `/users/${recipe.user.id}/recipes/${recipe.id}/edit`)
}

        // Recipe Show Page Ajax

function displayShowRecipe(res){
  let showRecipe = Recipe.findOrCreate(res)
  let recipeShowString = $('#recipe-show-template').html()
  let recipeShowTemplate = Handlebars.compile(recipeShowString);
  $('#recipe-body').html(recipeShowTemplate({recipe: showRecipe}))
  updateEditLink(showRecipe)
}

// Helper Functions
// function getUserInfo(){
//   let userUrl = $(tag.target).attr('href')
//   let userId = userUrl.match(/\d+/)[0] 
//   return {url: userUrl, id: userId}
// }
function currentRecipeEditForm(){
return $('#js-recipe-title').data().recipeId
}
// JS Model Objects 

function createRecipe(){
  let recipes = []
  return class Recipe{
    constructor(response){
      this.id = response.id 
      this.description = response.description
      this.time = response.time
      this.title = response.title
      this.user = User.findOrCreateUser(response.user)
      this.directions = response.directions
      this.recipeIngredients = []
      this.categories = Category.findOrCreateCategories(response.categories)
      recipes.push(this);
      this.user.addRecipe(this);
      Ingredient.findOrCreateIngredients(response.ingredients)
      this.addRecipeIngredients(response.recipe_ingredients)
      
    }
    static all(){
      return recipes;
    }
    static userRecipes(userId){
      return Recipe.all().filter(function(recipe){
        return recipe.user.id === parseInt(userId)
      })
    }
    static findOrCreate(res){
      return Recipe.all().find(r=> r.id === res.id) || new Recipe(res)
    }
    // 
    addRecipeIngredients(recipeIngredientsArray){
      recipeIngredientsArray.forEach(function(item){
        this.recipeIngredients.push(new RecipeIngredient(item))
      }, this)
    }
  }  
}
const Recipe = new createRecipe

function createRecipeIngredient(){
  return class RecipeIngredient{
    constructor(recipeIngredientObject){
      this.id = recipeIngredientObject.id
      this.recipeId = recipeIngredientObject.recipe_id
      this.quantity = recipeIngredientObject.quantity
      this.preparation = recipeIngredientObject.preparation
      this.ingredient = Ingredient.findIngredient(recipeIngredientObject.ingredient_id)
    }
  }
}
const RecipeIngredient = new createRecipeIngredient
