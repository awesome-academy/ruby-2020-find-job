export function enterComment() {
  $('body').on('keypress', '.comment_content', function(event) {
    if (event.keyCode === 13) {
      this.nextElementSibling.click()
    } 
  })
}

export function showMessageCancel() {
  $('body').on('click', '.edit-comment', function (event) {
    let {find_row} = findElement(event)
    let find_p = $(find_row.nextElementSibling).find('p')[0]
    let find_note = $(find_row.nextElementSibling).find('.cancel-comment')[0]
    
    $(find_p).hide()
    $(find_note).css("display","block")
  })
}

export function escapeEditComment() {
  $('body').on('keyup', '.edit_comment', function (event) {
    if (event.key === "Escape") {
      let {find_row} = findElement(event)
      let find_p = $(find_row).find('.comment-content')[0]
      let find_note = $(find_row).find('.cancel-comment')[0]
      
      $(this).remove()
      $(find_p).css("display","block")
      $(find_note).css("display","none")
    }
  })
}

function findElement(event) {
  let find_row = $(event.currentTarget).parents('.row')[0]
  return {find_row}
}
