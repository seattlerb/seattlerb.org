$(document).ready(function(){

  $('.tabs a').on('click', function(e){
    e.preventDefault();
    console.log('HELLO')
    var newcontent = $(this).attr('href');

    $('.tabs a').removeClass('sel');
    $(this).addClass('sel');

    $('#content section').each(function(){
      if(!$(this).hasClass('hidden')) { $(this).addClass('hidden'); }
    });

    $(newcontent).removeClass('hidden');
  });

});