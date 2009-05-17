jQuery(document).ready(function($) {
  $('#events, #jobs, #show').hover(
    function() {
      $(this).find('.crud').show('blind');
    },
    function() {
      $(this).find('.crud').hide('blind');
    }
  );
});
