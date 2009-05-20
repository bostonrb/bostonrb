jQuery(document).ready(function($) {
  $('#events, #jobs, #show').hover(
    function() {
      $(this).find('.crud').show();
    },
    function() {
      $(this).find('.crud').hide();
    }
  );

  $(document).bind('keydown', 'd', toggleDisplayOfPendingElements);
  $(document).bind('keydown', 'o', toggleOverlayOfPendingElements);
  
});
