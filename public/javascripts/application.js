Bostonrb = {
  showCrud: function() {
      $(this).find('.crud').show();
  },

  hideCrud: function() {
    $(this).find('.crud').hide();
  },

  normalizeTwitter: function(){
    this.value = this.value.replace(/\W/g,'');
  },

  scrollToHash: function() {
    if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') ){
      $('html,body').animate({scrollTop: $(this.hash).offset().top}, 1000 );
      return false;
    }
  },

  focusThis: function() {
    $(this).focus();
  },

  collageCycleOptions: {
    fx: 'scrollDown',
    timeout: 8000,
    pause: 1
  },

  datepickerOptions: {
    minDate: new Date(),
    showOn: 'button',
    buttonImage: '/images/calendar.png',
    buttonImageOnly: true,
    constrainInput: false,
    dateFormat: 'DD, MM dd, yy '
  }
}

Bostonrb.datepickerOptions.onSelect = Bostonrb.focusThis; // can't seem to assign focusThis in the middle of the object...

jQuery(document).ready(function($) {
    $('#events, #jobs, #projects, #presentations, #companies, #apps, #show, #edit').hover(Bostonrb.showCrud, Bostonrb.hideCrud);

    $('#people .collage').cycle(Bostonrb.collageCycleOptions);

    $('#user_twitter').bind('keyup', Bostonrb.normalizeTwitter);

    $('.navigation a').click(Bostonrb.scrollToHash);

    $('#event_date').datepicker(Bostonrb.datepickerOptions);
  });
