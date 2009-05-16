jQuery.fn.toggle_crud = function(lane) {
  $(this).observe(function() {
    $(lane).toggle();
    adjust_width_of($(".swim_lane:visible"));
  });
};

$(document).ready(function() {
  initialize_hoverables();
});

function initialize_hoverables() {
  $("#events").toggle_crud;
};

