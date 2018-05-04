$(document).on('turbolinks:load', function(){
  addRecipeIngredientEventListeners()
})

function addRecipeIngredientEventListeners(){
  $('#js-ingredients').on('click', 'a', (tag)=>destroyRecipeIngredient(tag))
  $('#js-add-ingredient').on('click', ()=>addIngredientRow())
  // add event listener to recipe links
}

function destroyRecipeIngredient(tag){
  event.stopImmediatePropagation()
  let riId = tag.target.dataset.id
  let recipeId = tag.target.dataset.recipeId
  let url = `/recipes/${recipeId}/recipe_ingredients/${riId}`
  $.ajax({
    type: "DELETE",
    data: {id: riId}.to_json,
    url: url,
    contentType: "application/json; charset=utf-8", 
    dataType: "json",    
    success: removeIngredientRow(tag)
  })  
}

function removeIngredientRow(tag){
  $(tag.target).parent().remove()
}

function addIngredientRow(){
  event.preventDefault();
  
  let inputKey = uniqueKey()
  let ingredientNameAttribute = `recipe[ingredients_attributes][${inputKey}][name]`
  let ingredientIdAttribute = `recipe_ingredients_attributes_${inputKey}_name`
  let $ingredient = $("<input>", {
    "placeholder": "Ingredient Name",
    "type": "text",
    "name": ingredientNameAttribute,
    "id": ingredientIdAttribute 
  })
  
  let quantityNameAttribute = `recipe[ingredients_attributes][${inputKey}][recipe_ingredients][quantity]`
  let quantityIdAttribute = `recipe_ingredients_attributes_${inputKey}_recipe_ingredients_quantity`
  let $quantity = $("<input>", {
    "placeholder": "Quantity",
    "type": "text",
    "name": quantityNameAttribute,
    "id": quantityIdAttribute 
  })
  
  let prepNameAttribute = `recipe[ingredients_attributes][${inputKey}][recipe_ingredients][preparation]`
  let prepIdAttribute = `recipe_ingredients_attributes_${inputKey}_recipe_ingredients_preparation`
  let $prep = $("<input>",{
    "placeholder": "Preparation",
    "type": "text",
    "name": prepNameAttribute,
    "id": prepIdAttribute 
  })
  let $ingredientRow = $(`<li></li>`).append($ingredient,[ " ",$quantity," ", $prep])

  $('#js-ingredients').append($ingredientRow)
  
}

// Helper Functions
function uniqueKey(){
    let date = new Date()
    return date.getTime();
}