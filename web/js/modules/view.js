export default class View {

    constructor(id, num_questions) {

        this.id = id;
        this.id_selector = '#' + id;

        this.num_questions = num_questions;

        this.checked = 0;
        this.interval = undefined;

        this.revisit_callback = undefined;
    }

    hide_home(callback) {
        $(this.id_selector + ' .quiz-home .card-body').animate({
            'margin-top': '-30%'
        }, 600, 'swing', () => $(this.id_selector + ' .quiz-home').animate({
            'opacity': '0.0',
            'margin-top': '-5%'
        }, 400, 'linear', () => {
            $(this.id_selector + ' .quiz-home').hide();
            callback();
        })).delay(250);
    }

    hide_question(callback) {

        clearInterval(this.interval);

        $(this.id_selector + ' .time-progress-bar').removeClass('bg-success bg-warning bg-danger');
        $(this.id_selector + ' .time-progress-bar').addClass('bg-info');
        $(this.id_selector + ' .time-progress-bar').css('width', '100%');

        for (let i = 0; i < 5; i++)
            if (!$(this.id_selector + ' .answer-' + i).is(':checked'))
                $(this.id_selector + ' .answer-label-' + i).animate({
                    'opacity': '0.0',
                    'margin-left': '+5%'
                }, 400, 'swing');

        $(this.id_selector + ' .quiz-question').animate({
            'opacity': '0.0'
        }, 400, 'linear', () => {
            $(this.id_selector + ' .quiz-question').hide();
            callback();
        }).delay(300);
    }

    hide_skipped(callback) {
        $(this.id_selector + ' .quiz-skipped').animate({
            'opacity': '0.0'
        }, 400, 'linear', () => {
            $(this.id_selector + ' .quiz-skipped').hide();
            callback();
        }).delay(250);
    }

    show_question(data) {

        this.show_answer(data.correct);

        $(this.id_selector + ' .question-counter').text(data.number + 1 + ' of ' + this.num_questions);
        $(this.id_selector + ' .question-text').html(data.text);

        for (let i = 0; i < 5; i++) {

            let checkbox = $(this.id_selector + ' .answer-' + i);
            let label = $(this.id_selector + ' .answer-label-' + i);

            checkbox.attr('disabled', false);
            checkbox.prop('checked', false);

            label.css('opacity', '1.0');
            label.css('margin-left', '0');

            let answer = data.answers[i];
            if (answer === undefined) {
                checkbox.hide();
                label.css('visibility', 'hidden');
            } else {
                checkbox.show();
                label.css('visibility', 'visible');
                label.text(answer);
            }
        }

        $(this.id_selector + ' .next-button').attr('disabled', true);
        $(this.id_selector + ' .skip-button').attr('disabled', false);

        $(this.id_selector + ' .time-progress-bar').attr('data-time', data.time);

        this.checked = 0;
        this.update_progress(data.remaining);

        $(this.id_selector + ' .quiz-question').attr('data-points', data.points);

        $(this.id_selector + ' .quiz-question').css({
            'opacity': '0.0'
        });
        $(this.id_selector + ' .quiz-question').show();
        $(this.id_selector + ' .quiz-question').animate({
            'opacity': '1.0'
        }, 400, 'linear', () => this.interval = setInterval(() => this.handle_interval(), 1000));
    }

    show_skipped(data) {

        this.show_answer(data.correct);

        let list = $(this.id_selector + ' .skipped-questions');
        list.empty();

        let i = 0;
        for (let number in data.skipped) {
            list.append(this.make_skipped(number, data.skipped[number], data.questions[i++]));
            $(this.id_selector + ' .skipped-' + number).click(() => this.revisit_callback(number));
        }

        $(this.id_selector + ' .quiz-skipped').css({
            'opacity': '0.0'
        });
        $(this.id_selector + ' .quiz-skipped').show();
        $(this.id_selector + ' .quiz-skipped').animate({
            'opacity': '1.0'
        }, 400, 'linear');
    }

    show_summary(data) {

        this.show_answer(data.isCorrect);

        let percent = data.score / data.total * 100;
        $(this.id_selector + ' .summary-chart').attr('data-percent', percent);

        $(this.id_selector + ' .summary-correct').text(data.correct.length + '/' + this.num_questions);
        $(this.id_selector + ' .summary-points').text(data.score + '/' + data.total);

        let color, hex;
        if (percent >= 60) {
            color = 'success-color';
            hex = '#00c851';
        } else if (percent >= 40) {
            color = 'warning-color';
            hex = '#ffbb33';
        } else {
            color = 'danger-color';
            hex = '#ff4444';
        }

        $(this.id_selector + ' .summary-badge').removeClass('success-color warning-color danger-color');
        $(this.id_selector + ' .summary-badge').addClass(color);

        $(this.id_selector + ' .summary-chart').easyPieChart({
            barColor: hex,
            onStep: function (from, to, percent) {
                $(this.el).find('.percent').text(Math.round(percent));
            }
        });

        $(this.id_selector + ' .quiz-summary').css({
            'opacity': '0.0',
            'margin-top': '-10%'
        });
        $(this.id_selector + ' .quiz-summary').show();
        $(this.id_selector + ' .quiz-summary').animate({
            'opacity': '1.0',
            'margin-top': '0'
        }, 400, 'linear');
    }

    show_answer(correct) {
        let points = $(this.id_selector + ' .quiz-question').attr('data-points');
        correct !== undefined && (correct ? toastr.success('+' + points + ' points')
            : toastr.error('Incorrect'));
    }

    make_skipped(number, remaining, question) {
        let color = 'badge-' + this.get_color(remaining);
        return '<button type="button" class="list-group-item list-group-item-action waves-effect d-flex '
            + 'justify-content-between align-items-center skipped-' + number + '" title="' + question
            + '"><span class="d-inline-block ' + 'text-truncate">' + question + '</span>&nbsp;&nbsp;'
            + '<span class="badge ' + color + ' badge-pill">' + remaining + 's</span></button>';
    }

    handle(data) {
        switch (data.type) {
            case 'question':
                this.show_question(data);
                break;
            case 'skipped':
                this.show_skipped(data);
                break;
            case 'summary':
                this.show_summary(data);
                break;
            case 'ack':
                this.submit_done(data);
                break;
        }
    }

    handle_checkbox(checked) {
        if (checked)
            this.checked++ === 0 && $(this.id_selector + ' .next-button').attr('disabled', false);
        else
            this.checked-- === 1 && $(this.id_selector + ' .next-button').attr('disabled', true);
    }

    handle_interval() {

        let remaining = this.get_remaining() - 1;
        if (remaining <= 0) {

            clearInterval(this.interval);

            $(this.id_selector + ' .next-button').attr('disabled', false);
            $(this.id_selector + ' .skip-button').attr('disabled', true);

            for (let i = 0; i < 5; i++) {
                $(this.id_selector + ' .answer-' + i).prop('checked', false);
                $(this.id_selector + ' .answer-' + i).attr('disabled', true);
            }

            $(this.id_selector + ' .time-progress-bar').css('width', '100%');
            $(this.id_selector + ' .time-progress-bar').text("alright pinhead, your time's up");

            return;
        }

        this.update_progress(remaining);
    }

    update_progress(remaining) {

        let color = 'bg-' + this.get_color(remaining);
        $(this.id_selector + ' .time-progress-bar').removeClass('bg-success bg-warning bg-danger bg-info');
        $(this.id_selector + ' .time-progress-bar').addClass(color);

        let time = $(this.id_selector + ' .time-progress-bar').attr('data-time');
        $(this.id_selector + ' .time-progress-bar').css('width', (remaining / time * 100) + '%');
        $(this.id_selector + ' .time-progress-bar').text(remaining + 's');
    }

    get_answers() {

        let answers = [];
        for (let i = 0; i < 5; i++) {
            let checkbox = $(this.id_selector + ' .answer-' + i);
            answers.push(checkbox.is(":checked"));
        }

        return answers;
    }

    get_remaining() {
        let remaining = $(this.id_selector + ' .time-progress-bar').text();
        return remaining.substring(0, remaining.length - 1);
    }

    get_color(remaining) {
        if (remaining > 30)
            return 'success';
        else if (remaining > 10)
            return 'warning';
        else
            return 'danger';
    }

    get_info() {

        let first_name = $(this.id_selector + ' .first-name').val();
        let last_name = $(this.id_selector + ' .last-name').val();
        let email = $(this.id_selector + ' .email').val();

        return {firstName: first_name, lastName: last_name, email: email};
    }

    subscribe_revisit(callback) {
        this.revisit_callback = callback;
    }

    submit() {
        $(this.id_selector + ' .submit-button').html('<span class="spinner-border spinner-border-sm mr-2"'
            + ' role="status" aria-hidden="true"></span>').addClass('disabled');
    }

    submit_done(data) {
        if (data.success)
            $(this.id_selector + ' .submit-button').text('Submitted');
        else {
            $(this.id_selector + ' .submit-button').text('Send').removeClass('disabled');
            toastr.error('Submitting results failed.');
        }
    }
}