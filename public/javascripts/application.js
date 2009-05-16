function show_crud(event) {
  element = event.element();
  element.down(".crud").show();
}

function hide_crud(event) {
  element = event.element();
  if(!this.descendantOf(element)) {
    element.down(".crud").hide();
  }
}

function hide_all_crud() {
  $("events").down(".crud").hide();
}

function bindUI() {
  hide_all_crud();
  $("events").observe("mouseover", show_crud);
  $("events").observe("mouseout", hide_crud);
}

document.observe('dom:loaded', bindUI);
