function validate_comment() {
  var proceed = true;
  if ($F('comment_comment').strip() == '') {
    $('comment_comment').up().addClassName('error');
    proceed = false;
  } else {
    $('comment_comment').up().removeClassName('error');
  }

  if ($F('comment_name').strip() == '') {
    $('comment_name').up().addClassName('error');
    proceed = false;
  } else {
    $('comment_name').up().removeClassName('error');
  }

  return proceed;
}
