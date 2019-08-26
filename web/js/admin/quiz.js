var edit, edit_button;

$('#save-question-button').click(() => {

    let text = $('#question-text').val();
    if (text === '') {
        toastr.error("Text can't be empty.");
        return;
    }

    let time = $('#question-time').val();
    if (time === '') {
        toastr.error("Time can't be empty.");
        return;
    }

    let points = $('#question-points').val();
    if (points === '') {
        toastr.error("Points can't be empty.");
        return;
    }

    let answers = [];
    for (let i = 1; i <= 5; i++) {
        if ($('#answer-active-' + i).prop('checked')) {
            let text = $('#answer-text-' + i).val();
            let correctness = $('#answer-correct-' + i).prop('checked');
            answers.push({text: text, correctness: correctness});
        }
    }

    if (edit) {

        edit_button.parent().parent().children('.text').text(text);
        edit_button.parent().parent().attr('data-text', text);
        edit_button.parent().parent().attr('data-time', time);
        edit_button.parent().parent().attr('data-points', points);
        edit_button.parent().parent().attr('data-answers', JSON.stringify(answers).replace(/"/g, '\''));

    } else {

        $('#sortable').append('<li class="list-group-item '
            + 'd-flex justify-content-between align-items-center" '
            + 'data-text="' + text + '" data-time="' + time + '" data-points="' + points + '" '
            + 'data-answers="' + JSON.stringify(answers).replace(/"/g, '\'') + '">'
            + '<span class="d-inline-block text-truncate text" style="max-width: 230px;">' + text + '</span>'
            + '<span>'
            + '<a class="btn-floating btn-sm btn-secondary edit-question-button">'
            + '<i class="fas fa-magic mr-1"></i>'
            + '</a>'
            + '<a class="btn-floating btn-sm btn-danger delete-question-button">'
            + '<i class="fas fa-times mr-1"></i>'
            + '</a>'
            + '</span>'
            + '</li>');

        $('.edit-question-button').click(edit_question_handler);
        $('.delete-question-button').click(delete_question_handler);
    }

    $('#question-modal').modal('hide');
});

$('#add-question-button').click(function () {

    edit = false;

    $('#question-text').val('');
    $('#question-time').val('');
    $('#question-points').val('');

    for (let i = 1; i <= 5; i++) {
        $('#answer-active-' + i).prop('checked', false);
        $('#answer-correct-' + i).prop('checked', false);
        $('#answer-text-' + i).val('');
    }

    $('#question-modal .modal-title').html('<strong>New question</strong>');
    $('#question-modal').modal();
});

function edit_question_handler() {

    edit = true;
    edit_button = $(this);

    $('#question-text').val($(this).parent().parent().attr('data-text'));
    $('#question-time').val($(this).parent().parent().attr('data-time'));
    $('#question-points').val($(this).parent().parent().attr('data-points'));

    for (let i = 1; i <= 5; i++) {
        $('#answer-active-' + i).prop('checked', false);
        $('#answer-correct-' + i).prop('checked', false);
        $('#answer-text-' + i).val('');
    }

    let answers = JSON.parse($(this).parent().parent().attr('data-answers').replace(/'/g, '"'));
    for (let i = 0; i < answers.length; i++) {
        $('#answer-active-' + (i + 1)).prop('checked', true);
        $('#answer-correct-' + (i + 1)).prop('checked', answers[i].correctness);
        $('#answer-text-' + (i + 1)).val(answers[i].text);
    }

    $('#question-modal .modal-title').html('<strong>Edit question</strong>');
    $('#question-modal').modal();
}

function delete_question_handler() {
    $(this).parent().parent().remove();
}

$('.edit-question-button').click(edit_question_handler);
$('.delete-question-button').click(delete_question_handler);
