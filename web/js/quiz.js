function send(event) {
    $.post(window.location.pathname, event, function (data) {
        console.log(data);
    }, 'json');
}

var start = "event=start";
var answer_right = "event=answer&answers={answers:[false, true, false]}";
var answer_wrong = "event=answer&answers={answers:[false, false, false]}";
var submit = "event=submit&info={firstName:'dummy',lastName:'test',email:'dummy@test.com'}";

function make_skip(remaining) {
    return "event=skip&remaining={remaining:" + remaining + "}";
}

function make_revisit(question) {
    return "event=revisit&question={question:" + question + "}";
}

$(window).on("beforeunload", function () {
    send("event=terminate");
});
