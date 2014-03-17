$(document).ready(function(){
  $('#tabs div').on('click', function(e){
    e.preventDefault();
    var activecontent = $(this).find('a').attr('href');

    $('#tabs div').each(function(){
      $(this).removeClass('active-tab');
    });
    $(this).addClass('active-tab');

    $('#content section').each(function(){
      $(this).addClass('hide');
    });
    $(activecontent).removeClass('hide');
  });
});