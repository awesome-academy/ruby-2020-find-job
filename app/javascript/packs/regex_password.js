$(function() {
  $('#dmm').click(function(e) {
    e.preventDefault();   
  
    password = $("#reset-pw").val();

    if (password_regex.exec(password)) {
      $('#new_user').submit();
    } else {
      alert(I18n.t("errors.messages.password_regex"));
    }
  })
})
