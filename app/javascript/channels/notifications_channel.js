import consumer from './consumer'

consumer.subscriptions.create('NotificationsChannel', {
  connected() {
  },

  disconnected() {
  },

  received(data) {
    $('#notificationList').prepend(data.html);
    $('#noti-not-viewed').html(data.count_not_viewes_noti)
  }
});
