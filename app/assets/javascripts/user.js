function createUser(){
  let users = []
  return class User{
    constructor(responseUser){
      this.id = responseUser.id
      this.email = responseUser.email
      this.recipes = []
      users.push(this)
    }
    static recipes(){
      return this.recipes
    }
    static all(){
      return users
    }
    addRecipe(recipe){
      this.recipes.push(recipe);
    }
    static findOrCreateUser(userObj){
      return users.find(user=> user.id === userObj.id && user.email === userObj.email) || new User(userObj) 
    }
  }
}

const User = new createUser
