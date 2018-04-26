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
    static findIngredient(id){
      return ingredients.find(i=> i.id === id);
    }
    static findOrCreateIngredients(res){
      res.forEach(function(ingredient){
        return ingredients.find(i=> i.id === ingredient.id) || new Ingredient(ingredient)      
      })
    }
  }
}

const Ingredient = new createIngredient;