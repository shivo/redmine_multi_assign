$(function() {
    $('#rma_edit_buttons').on('change', '#rma_edit_action_edit_roles', function() {
        $("#rma_edit_roles_form").fadeIn();
    });
    $('#rma_edit_buttons').on('change', '#rma_edit_action_delete', function() {
        $("#rma_edit_roles_form").fadeOut();
    });
});

