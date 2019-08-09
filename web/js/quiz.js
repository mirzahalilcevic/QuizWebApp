$(document).ready(function () {
    $('#start-button').click(function () {
        $.post(window.location.pathname, "event=start", function (data) {
            $('#quiz-home').hide();
            $('#quiz-question').show();
        }, 'json');
    });
});