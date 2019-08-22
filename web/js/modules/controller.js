export default class Controller {

    constructor(id, view) {
        this.id = id;
        this.view = view;
    }

    send(event, data, callback) {

        let msg = 'event=' + event;
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
    }

    terminate() {
        this.send('terminate', null, null);
    }

    start() {
        this.view.hide_home(
            () => this.send('start', null, data => this.view.handle(data)));
    }

    next() {
        this.view.hide_question(
            () => this.send('answer', this.view.get_answers(), data => this.view.handle(data)));
    }

    skip() {
        this.view.hide_question(
            () => this.send('skip', this.view.get_remaining(), data => this.view.handle(data)));
    }

    revisit(question) {
        this.view.hide_skipped(
            () => this.send('revisit', question, data => this.view.handle(data)));
    }

    submit() {
        this.view.submit();
        this.send('submit', this.view.get_info(), data => this.view.handle(data));
    }
}