
function View(id, total) {
    this.id = id;
    this.total = total;
    this.checked = 0;
}

View.prototype.constructor = View;

View.prototype.hideHome = function () {
    $('#' + this.id + ' .quiz-home').hide();
};

View.prototype.hideQuestion = function () {
    $('#' + this.id + ' .quiz-question').hide();
};

View.prototype.hideSkipped = function () {
    $('#' + this.id + ' .quiz-skipped').hide();
};

View.prototype.showQuestion = function (data) {

    $('#' + this.id + ' .question-text').html('<strong>' + data.text + '</strong>');
    $('#' + this.id + ' .question-counter').text(data.number + 1 + '/' + this.total);

    for (var i = 0; i < 5; i++) {

        var checkbox = $('#' + this.id + ' .answer-' + i);
        var label = $('#' + this.id + ' .answer-label-' + i);

        checkbox.prop("checked", false);

        var answer = data.answers[i];
        if (answer === undefined) {
            checkbox.hide();
            label.hide();
        } else {
            checkbox.show();
            label.show();
            label.text(answer);
        }
    }

    this.checked = 0;
    $('#' + this.id + ' .next-button').attr('disabled', true);

    $('#' + this.id + ' .time-progress-bar').css('width', '100%');
    $('#' + this.id + ' .time-progress-bar').text(data.time + 's');

    $('#' + this.id + ' .quiz-question').show();
};

View.prototype.showSkipped = function (data) {

    var list = $('#' + this.id + ' .skipped-questions');
    list.empty();

    var i = 0;
    for (var number in data.skipped)
        list.append(this.makeSkippedItem(number, data.skipped[number], data.questions[i++]));

    $('#' + this.id + ' .quiz-skipped').show();
};

View.prototype.makeSkippedItem = function (number, remaining, question) {

    var color;
    if (remaining > 40)
        color = 'badge-success';
    else if (remaining > 10)
        color = 'badge-warning';
    else
        color = 'badge-danger';

    return '<button type="button" class="list-group-item list-group-item-action waves-effect d-flex justify-content-between align-items-center">'
        + question + '<span class="badge ' + color + ' badge-pill">' + remaining + 's</span></button>';
};

View.prototype.handle = function (data) {
    switch (data.type) {
        case 'question':
            this.showQuestion(data);
            break;
        case 'skipped':
            this.showSkipped(data);
            break;
        case 'summary':
            break;
    }
};

View.prototype.handleCheckboxChange = function (checked) {
    if (checked)
        this.checked++ === 0 && $('#' + this.id + ' .next-button').attr('disabled', false);
    else
        this.checked-- === 1 && $('#' + this.id + ' .next-button').attr('disabled', true);
};

View.prototype.getAnswers = function () {

    var answers = [];
    for (var i = 0; i < 5; i++) {
        var checkbox = $('#' + this.id + ' .answer-' + i);
        answers.push(checkbox.is(":checked"));
    }

    return answers;
};


function Controller(id, view) {
    this.id = id;
    this.view = view;
}

Controller.prototype.constructor = Controller;

Controller.prototype.send = function (event, data, callback) {

    var msg = 'event=' + event;
    if (data !== null) {
        switch (event) {
            case 'answer':
                msg += '&answers=' + JSON.stringify({answers: data});
                break;
            case 'skip':
                msg += '&remaining=' + JSON.stringify({remaining: data});
                break;
            case 'revisit':
                msg += '&question=' + JSON.stringify({question: data});
                break;
            case 'submit':
                msg += '&info=' + JSON.stringify(data);
                break;
        }
    }

    $.post('/quiz/' + this.id, msg, callback, 'json');
};

Controller.prototype.terminate = function () {
    this.send('terminate', null, null);
};

Controller.prototype.start = function () {
    this.view.hideHome();
    this.send('start', null, data => this.view.handle(data));
};

Controller.prototype.next = function () {
    this.view.hideQuestion();
    this.send('answer', this.view.getAnswers(), data => this.view.handle(data));
};

Controller.prototype.skip = function () {
    this.view.hideQuestion();
    this.send('skip', 60, data => this.view.handle(data));
};

Controller.prototype.revisit = function (question) {
    this.view.hideSkipped();
    this.send('revisit', question, data => this.view.handle(data));
};
