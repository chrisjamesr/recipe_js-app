$(document).on('turbolinks:load', function(){
  addEventListeners()
  // loadRecipes()
})

function addEventListeners(){
  $('#js-next').on('click', ()=>loadNext())
  $('#js-previous').on('click', ()=>loadPrevious())
  console.log("listeners loaded")
}

function loadRecipes(){
  const userId = $('js-recipe-title').data()["userId"]
  let res = {}
  $.get(`http://localhost:3000/users/${userId}/recipes/`,'',null,'json')
    .done(function(response){
      response.forEach(element=> new Recipe(element))
    })  
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
      this.userId = response.user_id
      this.directions = response.directions
      recipes.push(this)
    }
    static all(){
      return recipes;
    }
  }
}

const Recipe = new createRecipe