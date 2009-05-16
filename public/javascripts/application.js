jQuery(document).ready(function($) {
    $('#events').hover(
      function() {
        $(this).find('.crud').show('blind');
      },
      function() {
        $(this).find('.crud').hide('blind');
      }
    );
});
