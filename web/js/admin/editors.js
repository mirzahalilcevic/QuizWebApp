function edit_handler() {

    let id = $(this).parent().attr('data-id');

    let first_name = $('#first-name-' + id).val();
    let last_name = $('#last-name-' + id).val();
    let username = $('#username-' + id).val();
    let password = $('#password-' + id).val();

    if (username === "") {
        toastr.error("Username can't be empty.");
        return;
    }

    let msg = 'firstName=' + first_name
        + '&lastName=' + last_name
        + '&username=' + username;

    if (password !== "")
        msg = msg + '&password=' + password;

    $(this).html('<span class="spinner-border spinner-border-sm mr-2" role="status" aria-hidden="true"></span>').addClass('disabled');
    $.post('/admin/editor/' + id, msg, data => {
        if (data.success)
            toastr.success("Done.");
        else
            toastr.error(data.message);
        $(this).html('<i class="fas fa-magic mr-1"></i> Edit').removeClass('disabled');
    });
}

function delete_handler() {

    let id = $(this).parent().attr('data-id');
    if (!confirm('Are you sure you want to delete "' + $('#username-' + id).val() + '"?'))
        return;

    $(this).html('<span class="spinner-border spinner-border-sm mr-2" role="status" aria-hidden="true"></span>').addClass('disabled');
    $.ajax({
        url: '/admin/editor/' + id,
        method: 'DELETE',
        success: data => {
            if (data.success)
                $(this).parent().parent().fadeOut(300, () => {
                    toastr.success("Done.");
                    $(this).parent().parent().remove()
                });
            else {
                toastr.error(data.message);
                $(this).html('<i class="fas fa-times"></i> Delete').removeClass('disabled');
            }
        }
    });
}

$('.edit-button').click(edit_handler);
$('.delete-button').click(delete_handler);

$('#add-button').click(function () {
    $('#editor-modal').modal();
});

$('#save-button').click(function () {

    let first_name = $('#first-name').val();
    let last_name = $('#last-name').val();
    let username = $('#username').val();
    let password = $('#password').val();

    let msg = 'firstName=' + first_name
        + '&lastName=' + last_name
        + '&username=' + username
        + '&password=' + password;

    $(this).html('<span class="spinner-border spinner-border-sm mr-2" role="status" aria-hidden="true"></span>').addClass('disabled');
    $.post('/admin/editor', msg, data => {
        if (data.success) {

            toastr.success("Done.");

            $('#editor-modal').modal('hide');
            $('#first-name').val('');
            $('#last-name').val('');
            $('#username').val('');
            $('#password').val('');

            $('#editor-table tbody').prepend(create_row(data.message, first_name, last_name, username, password));
            $('#editor-table tbody tr:first-child input').focus();
            $('#editor-table tbody tr:first-child .edit-button').click(edit_handler);
            $('#editor-table tbody tr:first-child .delete-button').click(delete_handler);

        } else
            toastr.error(data.message);

        $(this).text('Save').removeClass('disabled');
    });
});

function create_row(id, first_name, last_name, username, password) {
    return '<tr class="animated fadeIn fast">'
        + '<td class="align-middle"><div class="md-form"><input type="text" id="first-name-' + id + '" class="form-control text-white" value="' + first_name + '"><label for="first-name-' + id + '">First name</label></div></td>'
        + '<td class="align-middle"><div class="md-form"><input type="text" id="last-name-' + id + '" class="form-control text-white" value="' + last_name + '"><label for="last-name-' + id + '">Last name</label></div></td>'
        + '<td class="align-middle"><div class="md-form"><input type="text" id="username-' + id + '" class="form-control text-white" value="' + username + '"><label for="username-' + id + '">Username</label></div></td>'
        + '<td class="align-middle"><div class="md-form"><input type="password" id="password-' + id + '" class="form-control text-white" value="' + password + '"><label for="password-' + id + '">Password</label></div></td>'
        + '<td class="text-right align-middle" data-id="' + id + '">'
        + '<button type="button" class="btn btn-sm btn-secondary btn-rounded waves-effect edit-button"><i class="fas fa-magic mr-1"></i>&nbsp; Edit</button>'
        + '<button type="button" class="btn btn-sm btn-danger btn-rounded waves-effect delete-button"><i class="fas fa-times"></i>&nbsp; Delete</button>'
        + '</td></tr>';
}
