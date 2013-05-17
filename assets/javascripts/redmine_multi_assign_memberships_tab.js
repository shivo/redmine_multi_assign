Event.observe(window, 'load', function() {
  rma_observe_edit_buttons();
});

function rma_observe_edit_buttons() {
  Event.observe('rma_edit_buttons', 'change', rma_respond_to_select);
  $('rma_edit_roles_form').hide();
}

// Callback function to handle the event.
function rma_respond_to_select(event) {
  if (event.findElement().id == 'rma_edit_action_edit_roles') {
    $('rma_edit_roles_form').show();
  } else {
    $('rma_edit_roles_form').hide();
  }
}