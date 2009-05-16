jQuery(document).ready(function($) {
    $('#events, #jobs').hover(
      function() {
        $(this).find('.crud').show('blind');
      },
      function() {
        $(this).find('.crud').hide('blind');
      }
    );
});
