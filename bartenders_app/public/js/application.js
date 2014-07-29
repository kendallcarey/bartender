$(document).ready(function() {
  bindAll();
});

function bindAll() {
  // debugger
  // $('.stars').raty({
  // score: function() {
  //   half     : true,
  //   starHalf : 'star-half-mono.png'
  //   return $(this).attr('data-score');
  // }
  $('form').on('submit', doubleCheck);
}


function doubleCheck(e) {
  if ( $('#input-password').val() !== $('#double-check').val() ) {
    e.preventDefault();
    alert('The passwords do not match');
  }
}