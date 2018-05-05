
function loadComments(){
  const url;
  $.ajax({
      method: "GET",
      url: '/recipes/4/comments',
      dataType: 'json'
    }).done(showComments)
}

function postComment(){
  const commentText;
  const url;
  $.ajax({
    method: "POST",
    url: '/recipes/4/comments',
    data: {text: ""},
    dataType: 'json'
  }).done(prependComment)
    
}

function showComments(){

}

function prependComment(){

}