export function countAssociation() {
  $('.add_fields').click(function(){
    let field = $(this).data('associations');
    setTimeout(() => {
      let newBoxItem = $(`.${field} .box-item`).last()
      newBoxItem[0].querySelector('.total_item').innerHTML = newBoxItem.index() + 1
    }, 0)
  }) 
}
