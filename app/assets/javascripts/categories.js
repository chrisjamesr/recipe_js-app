// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

function createCategory(){
  let categories = []

  return class Category{
    constructor(categoryObject){
      this.id = categoryObject.id
      this.name = categoryObject.name
      categories.push(this)
    }

    static all(){
      return categories
    }

    static findOrCreateCategories(categoriesArray){
      return categoriesArray.map(function(category){
        return (Category.all().find(c=> c.id === category.id) || new Category(category) )     
      })
    }
  }

}
const Category = new createCategory