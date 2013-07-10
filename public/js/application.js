$(document).ready(function() {
  $('#get_tweets').on('submit', function(e) {
    e.preventDefault();
    // var screen_name = $(this).find('input[name="screen_name"]').val();

    var loader_image = '<img id="spinner" src="ajax-loader_blue_512.gif" height="32" width="32">';  

    var $form = $(this);
    var data = $form.serialize();
    console.log(data);

    $(this).append(loader_image);
    // debugger
    var request = $.ajax({method: "post",
                          url:    "/tweets",
                          data:   data});

    request.done(function(response) {
      $('#spinner').remove();
      $('.tweet').remove();
      // $('')
      $form.append(response);
      // console.log(response);
      // debugger
    });

  });
});
