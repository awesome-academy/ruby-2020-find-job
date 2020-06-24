$(function() {
    $('body').on('click', '#apply_job #cancel_job', function () {
      let url = $(this).data('url');
      $.ajax({
        method: 'POST',
        dataType: 'script',
        url: url,
        data: {
          authenticity_token: $('meta[name="csrf-token"]').attr('content'),
        },
        error: function() {
          alert(I18n.t('apply_error'));
        },
      });    
    });
  })
  