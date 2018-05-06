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
    }).done(showComments)
}

function showComments(commentsResponse){
  $('#show-comments').css('visibility','hidden')
  let $commentTemplate = $('<div>', { "id": "comments"})
  let currentComments = $('#comments').children()
  addCommentField()
  if (commentsResponse.length > 0 ) {  
    for (let i = 0; i < commentsResponse.length; i++){    
      prependComment(commentsResponse[i])
      // let userLink = `<a href="/users/${comment.user_id}/recipes">${comment.user_name}</a>`
      // let $commentString = $(`<p>${userLink}<br>${comment.text}</p>`)    
      // $('#comments').prepend($commentString)
    }
    // $('#comments').append($commentTemplate)
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
  }).done(prependComment)
  // $('#js-comment-div').remove()  
  $('#js-comment-input').val('')  
}

function prependComment(comment){
  let userLink = `<a href="/users/${comment.user_id}/recipes">${comment.user_name}</a>`
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
function displayComment(commentString){
  let $commentString = $(`<p>${comment.user_name}<br>${comment.text}</p>`)   
  $('#comments').append($commentTemplate)
}

// NOT IN USE
function hideComments(){
  $('#js-comment-div').remove()
  $('#show-comments').text("Hide Comments").on('click', clearComments)
}

// NOT IN USE
function addCommentLink(){
  let recipeId = $('#js-recipe-title').data().recipeId
  let $commentLink = $("<a>",{
    text: "Add A Comment",
    "href": "#",
    "id": "js-add-comment",
    "data-recipe-id": recipeId,
  }).on('click', addCommentField)

  $('#show-comments').after($($commentLink))
}