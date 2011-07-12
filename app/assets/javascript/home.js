$(document).ready(function () {
  expandSection();
});

var expandSection = function () {
  var section = $('section#container > section');
  if (!section.siblings('aside')[0]) {
    section.removeClass('thin');
  }
}

