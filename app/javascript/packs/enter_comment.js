export function enterComment() {
  $('#comment_content').keypress(function(event) {
      if (event.keyCode === 13) { 
          $('.send').click();
      } 
  }); 
}

