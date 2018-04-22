$(document).on('turbolinks:load', function(){
  addEventListeners()
  // loadRecipes()
})

function addEventListeners(){
  $('#js-next').on('click', ()=>loadNext())
  $('#js-previous').on('click', ()=>loadPrevious())
  $('.js-user-link').on('click', (tag)=>loadIndexedRecipes(tag))
}

function loadIndexedRecipes(tag){
  event.preventDefault()
  debugger
  let userUrl = $(tag.target).attr('href')
  let userId = userUrl.match(/\d+/)[0] 
  // let res = {}
  $.get(userUrl, {user_id: userId} , null,'json')
    .done(function(response){
      response.forEach(element=> new Recipe(element))
    }).done(
    recipes=> console.log(recipes));
    // displayIndexedRecipes(recipes)
    
}

function displayIndexedRecipes(recipes){
  $('#recipe-cards').empty();
  debugger
}

function displayRecipe(recipe){
  let recipeTemplateString = `<div class="card">
  <div class="card-body">
    <h5 class="card-title"><%= link_to recipe.title, user_recipe_path(recipe.user, recipe) %></h5>
     <div class="category-tag">
      <%= render :partial => "categories/categories", :collection => recipe.categories, :as => :category %>
    </div>
    <h6 class="card-subtitle mb-2 text-muted">Submitted by <%= link_to ${recipe}, user_recipes_path(recipe.user),class: "js-user-link" %></h6>
    <em>Approximate Cook Time: ${recipe.time} Min</em><br>
    <%= recipe.description %>
   
  </div>
</div>  
  <br>`

}

function loadNext(){
  event.preventDefault()
  let userUrl = $('#js-user-link').attr('href')
  let currentId = $('#js-recipe-title').data()["recipeId"]
  $.get(`${userUrl}/${currentId}`,{ new_recipe_id: currentId+1 },null,'json')
    .done(loadRecipeText)  
}

function loadPrevious(){
  event.preventDefault()
  let userUrl = $('#js-user-link').attr('href')
  let currentId = $('#js-recipe-title').data()["recipeId"]
  $.get(`${userUrl}/${currentId}`,{ new_recipe_id: currentId+1 },null,'json')
    .done(loadRecipeText)  
}

function loadRecipeText(res){
  // debugger
  $('#js-description').text(res["description"])
  $('#js-directions').text(res["directions"])
  $('#js-cook-time').text(res["time"])
  $('#js-recipe-title').text(res["title"])
  $('#js-recipe-title').data().recipeId = res["id"]
  
}
// {
//   created_at: "2018-04-18T01:24:09.009Z"
//   description:  "Fresh parsley, Italian sausage, shallots, garlic, sun-dried tomatoes and mozzarella cheese in an all-butter crust. With a side of mixed fruits."
//   directions: "Girl, if God created anything less beautiful than you, I hope He kept it for Himself."
//   id:36
//   time: 6
//   title:   "Vegetable Soup"
//   user_id: 16
// }

function createRecipe(){
  let recipes = []
  return class Recipe{
    constructor(response){
      this.id = response.id 
      this.description = response.description
      this.time = response.time
      this.title = response.title
      this.user = response.user
      this.directions = response.directions
      recipes.push(this)
    }
    static all(){
      return recipes;
    }
  }
}
const Recipe = new createRecipe

function createUser(){
  let users = []
  return class User{
    constructor(responseUser){
      this.id = responseUser.id
      this.name = responseUser.name
    }
  }
}