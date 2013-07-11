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
  };

  var sendTweet = function() {
    var data = $form.serialize();
    $form.append($spinner);

    console.log(data);
    var request = $.ajax({method: "post",
                          url:    "/tweet/send",
                          data:   data});
    request.done(function (response) {
      $spinner.remove();
      $tweet_container.find('.tweet').remove();
      $tweet_container.append(response);
    });
  };

  var debouncedLoadTweets = _.debounce(loadTweets, 300);
  var debouncedSendTweet  = _.debounce(sendTweet, 300);
  
  var handleFormSubmit = function(e) {
    e.preventDefault();
    console.log('registered the click');
    // debouncedLoadTweets();
    debouncedSendTweet();
  };

  

  $('#get_tweets').on('submit', handleFormSubmit);


  $('#get_tweets').on('keyup', function(e) {
    e.preventDefault();
    var tweet = $('textarea[name=tweet]', this).val();
    var tweet_count = tweet.length;
    var tweet_count_string = 'Characters Left: ' + (140 - tweet_count);
    var count_label = $(this).find('#char_count');
    count_label.text(tweet_count_string);

    console.log(tweet_count);
    if (tweet_count > 140) {
      count_label.css('color', 'red');
      var legit_portion = tweet.substring(0, 140);
      var excess = tweet.substring(141);
      // disable the submit button
      $('form input[type=submit]').attr('disabled', 'disabled');
      document.getElementById('tweet_area').setSelectionRange(140, 140 + tweet.length);

    } else {
      count_label.css('color', 'black');
      // enable the submit button
      $('form input[type=submit]').removeAttr('disabled');
    }
  });


});
