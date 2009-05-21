jQuery(document).ready(function($) {
  $('#events, #jobs, #projects, #presentations, #show, #edit').hover(
    function() {
      $(this).find('.crud').show();
    },
    function() {
      $(this).find('.crud').hide();
    }
  );

  $(document).bind('keydown', 'd', toggleDisplayOfPendingElements);
  $(document).bind('keydown', 'o', toggleOverlayOfPendingElements);

  $('#people .collage').cycle({ fx: 'scrollDown',
                                timeout: 8000});
  
});
