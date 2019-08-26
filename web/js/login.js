$('#login-button').click(function () {

    let username = $('#username').val();
    let password = $('#password').val();

    let msg = 'username=' + username
        + '&password=' + password;

    $(this).html('<span class="spinner-border spinner-border-sm mr-2" role="status" aria-hidden="true"></span>').addClass('disabled');
    $.post('/login', msg, data => {
        if (data.success)
            window.location = '/home';
        else {
            toastr.error(data.message);
            $(this).text('Log in').removeClass('disabled');
        }
    });
});
