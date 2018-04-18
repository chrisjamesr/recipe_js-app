$(function(){
  addEventListeners()
})

function addEventListeners(){
  $('#js-next').on('click', () => loadNext())
}

function loadNext(){
  event.preventDefault()
  const recipeId = $('#js-next').data()["id"]
  let res = {}
  $.get(`http://localhost:3000/users/15/recipes/${recipeId + 1}`,'',null,'json')
    .done((response)=>{
      res = response
      $('#js-description').text(res["description"])
      $('#js-directions').text(res["directions"])
      $('#js-cook-time').text(res["time"])
      $('#js-recipe-title').text(res["title"])
  })  
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