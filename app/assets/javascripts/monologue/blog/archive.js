$(function() {
  $('.js-year').on('click', function(){
    $(this).parent().find('>ul').toggle('fast');
    $(this).toggleClass('active');
  });

  $('.js-month').on('click', function(){
    $(this).parent().find('ul').toggle('fast');
    $(this).toggleClass('active');
  });
});