$(function() {
  $('#dmm').click(function(e) {
    password = $("#reset-pw").val();
    password_regex = /^(?=.*[a-zA-Z])(?=.*[0-9])/i;

    if (password_regex.exec(password)) {
      $('#new_user').submit();
    } else {
      alert(I18n.t("errors.messages.password_regex"));
    }

    e.preventDefault();   
  })
})
