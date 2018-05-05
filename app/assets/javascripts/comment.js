$(document).on('turbolinks:load', function(){
  addCommentEventListeners()
})


function addCommentEventListeners(){
  $("#show-comments").on('click', loadComments)
  $("#add-comment").on('click', addCommentField)
}

function addCommentField(){
  event.stopPropagation()
  let $commentField = $("<input>",{
    "placeholder": "Add Comment...",
    "type": "text",
    "name": "comment"
  })
  // $('#comments')
}
function loadComments(){
  event.stopPropagation()
  const recipeId = this.dataset.recipeId
  $.ajax({
      method: "GET",
      url: `/recipes/${recipeId}/comments`,
      dataType: 'json'
    }).done(showComments)
}

function postComment(){
  
  // const commentText;
  // const url;
  $.ajax({
    method: "POST",
    url: '/recipes/4/comments',
    data: {text: ""},
    dataType: 'json'
  }).done(prependComment)
    
}

function showComments(commentsResponse){
  debugger
  console.log(commentsResponse)
}

function prependComment(){
  console.log(response)
}