$(document).ready( function() {
  $('.browser .buttons input').click(function(e) {
    e.preventDefault();

    var form_path = $(this).parent('form').attr('action');
    var all_buttons = $(this).parent('form').find('input');
    var button = $(this);

    $.ajax({
      type: "PUT",
      url: form_path,
      data: { result: $(this).attr('name') },
      success: function(data) {
        button.removeClass('loading').addClass('selected');
        load_new_mapping();
      },
      failure: function(data) {
        button.removeClass('loading');
        alert(data);
      },
      beforeSend: function(data) {
        all_buttons.removeClass('selected');
        button.addClass('loading');
      }
    });
  });

  function load_new_mapping() {
    window.location = '/browse';
  }
});