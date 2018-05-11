$(document).on('turbolinks:load', function(){
  addCommentEventListeners()
})

function addCommentEventListeners(){
  $("#show-comments").on('click', loadComments)
}

function addCommentField(){
  event.stopPropagation()
  // disable addcommentbutton
  let $commentField = $("<textarea>",{
    "placeholder": "Add Comment...",
    "id": "js-comment-input",
    "type": "text",
    "name": "comment",
    "autofocus": true,
    "rows": "1",
    "cols": "70",
    "wrap": "hard"
  })
  let $commentButton = $("<button>", {
    text: "Submit",
    "value": "Submit",
    "type": "button"
  }).on('click', postComment)

  let $commentForm = $("<form>", {
    "id": "js-comment-form"
    })
  let $addCommentDiv = $("<div></div>",{
    "id": "js-comment-div"
  }).append($commentField,[$commentButton])

  $($addCommentDiv).insertBefore($('#comments'))
}

function loadComments(){
  event.stopPropagation()
  let recipeId = $('#js-recipe-title').data().recipeId
  $.ajax({
      method: "GET",
      url: `/recipes/${recipeId}/comments`,
      dataType: 'json'
  }).done(function(commentResponse){
    let commentObjectArray = commentResponse.map(commentObject=> new Comment(commentObject))
    showComments(commentObjectArray)
  })
}

function showComments(commentObjectArray){
  debugger
  $('#show-comments').css('visibility','hidden')
  let $commentTemplate = $('<div>', { "id": "comments"})

  addCommentField()
  if (commentObjectArray.length > 0 ) {  
    for (let i = 0; i < commentObjectArray.length; i++){    
      prependComment(commentObjectArray[i])
    }
  }
}

function postComment(){
  let commentText = $('#js-comment-input').val().trim()
  let recipeId = $('#js-recipe-title').data().recipeId
  $.ajax({
    method: "POST",
    url: `/recipes/${recipeId}/comments`,
    data: {text: commentText},
    dataType: 'json'
  }).done((response)=> prependComment(new Comment(response)))
  $('#js-comment-input').val('')  
}

function prependComment(comment){
  let userLink = `<a href="/users/${comment.userId}/recipes">${comment.userName}</a>`
  let $commentString = $(`<p>${comment.text} - ${userLink}</p>`)    
  $('#comments').prepend($commentString)
}

function toggleCommentLink(){
  $('#show-comments').toggleClass('hidden')
}

function clearComments(){
  $('#show-comments').css('visibility','visible')
  $('#js-comment-div').remove()
  $('#comments').empty()
}

// NOT IN USE
// function displayComment(commentString){
//   let $commentString = $(`<p>${comment.userName}<br>${comment.text}</p>`)   
//   $('#comments').append($commentTemplate)
// }

// NOT IN USE
// function hideComments(){
//   $('#js-comment-div').remove()
//   $('#show-comments').text("Hide Comments").on('click', clearComments)
// }

// NOT IN USE
// function addCommentLink(){
//   let recipeId = $('#js-recipe-title').data().recipeId
//   let $commentLink = $("<a>",{
//     text: "Add A Comment",
//     "href": "#",
//     "id": "js-add-comment",
//     "data-recipe-id": recipeId,
//   }).on('click', addCommentField)

//   $('#show-comments').after($($commentLink))
// }

function createComment(){
  comments = []
  return class Comment{
    constructor(commentObject){
      debugger
      this.recipe = Recipe.findRecipe(commentObject.recipe_id)
      this.userId = commentObject.user_id
      this.userName = commentObject.user_name
      this.text = commentObject.text
      comments.push(this)

      if (this.recipe){
        this.recipe.comments.push(this)
      }
    }
    static all(){
      return comments
    }
    userPath(){
     return `/users/${this.userId}/recipes`
    }
  }
}
const Comment = new createComment()
