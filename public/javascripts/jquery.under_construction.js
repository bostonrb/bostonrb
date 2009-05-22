jQuery.under_construction = {
  hidePendingElements : function() {
    jQuery(".pending").each(function(i){
      jQuery(this).addClass("not_visible");
    });
  },
  
  showPendingElements : function() {
    jQuery(".pending").removeClass("not_visible");
  },
  
  hideOverlayOfPendingElements : function() {
    jQuery(".overlay_for_pending").remove();
  },
  
  overlayPendingElements : function() {
    jQuery(".pending").each(function(i){

      //clone the element so that we can overlay it
      var overlay_element = jQuery("<div>");

      //set the height
      var height = jQuery(this).outerHeight();
      var width = jQuery(this).outerWidth();

      jQuery(overlay_element).height(height);
      jQuery(overlay_element).width(width);

      //set the position
      var pos = jQuery(this).position();

      jQuery(overlay_element).css("top", pos.top);
      jQuery(overlay_element).css("left", pos.left);

      //add the class that sets opacity and background color
      jQuery(overlay_element).addClass("overlay_for_pending");

      //todo: replace this with a delimited class to indicate what milestone it is
      jQuery(overlay_element).html("");

      //insert after the element in question
      jQuery("body").append(overlay_element);
    });
  },
  
  toggleDisplayOfPendingElements : function() {
    if(jQuery(".pending").hasClass("not_visible")) {
      this.showPendingElements();
    }
    else {
      this.hidePendingElements();
    }
  },
  
  toggleOverlayOfPendingElements : function() {
    if(jQuery(".overlay_for_pending").length > 0) {
      this.hideOverlayOfPendingElements();
    }
    else {
      this.overlayPendingElements();
    }
  },
  

}

