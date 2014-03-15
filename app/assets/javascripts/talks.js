$(document).ready(function(){

  $('#tabs div').on('click', function(e){
    e.preventDefault();
    var activecontent = $(this).find('a').attr('href');
    var tab = $(this).parent();

    // $('#tabs a').removeClass('sel');
    // $('#tabs a').each(function(){
    //   $(this).parent().css('background-color', '#C3D9FF')
    // });
    // $(this).addClass('sel');

    // tab.addClass('active');

    $('#content section').each(function(){
      if(!$(this).hasClass('hide')) { $(this).addClass('hide'); }
    });

    $(activecontent).removeClass('hide');
  });

});