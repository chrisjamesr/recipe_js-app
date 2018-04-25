// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
function createIngredient(){
  let ingredients = []
  return class Ingredient{
    constructor(ingredientObject){
    this.id = ingredientObject.id
    this.name = ingredientObject.name
    ingredients.push(this)
    }
    static all(){
      return ingredients
    }  
    static findOrCreateIngredients(res){
      res.forEach(function(ingredient){
        return Ingredient.all().find(i=> i.id === ingredient.id) || new Ingredient(ingredient)      
      })
    }
  }
}

const Ingredient = new createIngredient;