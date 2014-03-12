$(document).ready(function(){

  $('#tabs a').on('click', function(e){
    e.preventDefault();
    console.log('HELLO')
    var newcontent = $(this).attr('href');
    var tab = $(this).parent();

    $('#tabs a').removeClass('sel');
    $('#tabs a').each(function(){
      $(this).parent().css('background-color', '#63BFD8')
    });
    $(this).addClass('sel');
    tab.css('background-color', '#A9D0F5');

    $('#content section').each(function(){
      if(!$(this).hasClass('hidden')) { $(this).addClass('hidden'); }
    });

    $(newcontent).removeClass('hidden');
  });

});