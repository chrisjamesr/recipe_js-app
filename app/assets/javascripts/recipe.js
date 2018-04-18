$(function(){
  addEventListeners()
})

function addEventListeners(){
  $('a#js-next').on('click', () => loadNext())
}

function loadNext(){
  event.preventDefault()
  alert("its working");
}