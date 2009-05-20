function toggleDisplayOfPendingElements() {
  if($(".pending").hasClass("not_visible")) {
    showPendingElements();
  }
  else {
    hidePendingElements();
  }
}

function toggleOverlayOfPendingElements() {
  if($(".overlay_for_pending").length > 0) {
    hideOverlayOfPendingElements();
  }
  else {
    overlayPendingElements();
  }

}

function hidePendingElements(){
  $(".pending").each(function(i){
    $(this).addClass("not_visible");
  });
}

function showPendingElements() {
  $(".pending").removeClass("not_visible");
}

function hideOverlayOfPendingElements() {
  $(".overlay_for_pending").remove();
}

function overlayPendingElements(){
  $(".pending").each(function(i){
    
    //clone the element so that we can overlay it
    var overlay_element = $(this).clone();
    

    //set the height
    var height = $(this).height();
    var width = $(this).width();
    
    $(overlay_element).height(height);
    $(overlay_element).width(width);
    
    //set the position
    var pos = $(this).position();

    $(overlay_element).css("top", pos.top);
    $(overlay_element).css("left", pos.left);
    
    //add the class that sets opacity and background color
    $(overlay_element).addClass("overlay_for_pending");

    //todo: replace this with a delimited class to indicate what milestone it is
    $(overlay_element).html("");
    
    //insert after the element in question
    $(this).after(overlay_element);
  });
}
