$(document).ready(function() {
  var $spinner = $('<img id="spinner" src="ajax-loader_blue_512.gif" height="32" width="32">');
  var $form = $('form');
  var $tweet_container = $('.tweet_container');

  var updateTweet = function(response) {
    // debugger
    console.log('got here 3');
    $spinner.remove();
    $tweet_container.find('.tweet').remove();
    // $('.tweet').remove();
    $tweet_container.append(response);
  };

  var loadTweets = function() {
    var data = $form.serialize();
    $form.append($spinner);
    var request = $.ajax({method: "post",
                          url:    "/tweets",
                          data:   data});
    console.log('got here 2');
    request.done(updateTweet);
  }

  var debouncedLoadTweets = _.debounce(loadTweets, 300);

  
  var handleFormSubmit = function(e) {
    e.preventDefault();
    debouncedLoadTweets();
  };

  

  $('#get_tweets').on('submit', handleFormSubmit);
});
