$(document).on('click', 'a[data-method]', function(evt) {
  evt.preventDefault();

  $.ajax({
    url: this.href,
    data: $(this).data('params'),
    method: $(this).data('method'),
    success: function() { $(this).data('no-reload') ? null : window.location.reload(); }
  })

  return false;
});
