$(document).on('turbolinks:load', function(){
  addCommentEventListeners()
})


function addCommentEventListeners(){
  $("#show-comments").on('click', loadComments)
  $("#add-comment").on('click', addCommentField)
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
  let $commentButton = $("<button>Submit</button>", {
    "value": "Submit",
    "type": "button",
  })
  $commentButton.on('click', postComment)
  // $('#comments')
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
  const recipeId = this.dataset.recipeId
  $.ajax({
      method: "GET",
      url: `/recipes/${recipeId}/comments`,
      dataType: 'json'
    }).done(showComments)
}

function postComment(){
  alert('postComment')
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