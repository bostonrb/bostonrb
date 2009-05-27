jQuery(document).ready(function($) {
  $('#events, #jobs, #projects, #presentations, #companies, #apps, #show, #edit').hover(
    function() {
      $(this).find('.crud').show();
    },
    function() {
      $(this).find('.crud').hide();
    }
  );

  $(document).bind('keydown', 'd', function(){ 
    $.under_construction.hideOverlayOfPendingElements();
    $.under_construction.toggleDisplayOfPendingElements();
  });
  $(document).bind('keydown', 'o', function(){ 
    $.under_construction.showPendingElements();
    $.under_construction.toggleOverlayOfPendingElements();
  });

  $('#people .collage').cycle({ fx: 'scrollDown',
                                timeout: 8000});

  $('#user_twitter').bind('keyup', function(){
    this.value = this.value.replace(/\W/g,'');
  });
  
});
