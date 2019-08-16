package qwa.session;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

public final class CompletedQuizHelper {

    public static void add(HttpServletRequest req, HttpServletResponse resp, int id) {

        var cookies = req.getCookies();
        if (cookies != null)
            for (var cookie : cookies)
                if (cookie.getName().equals("completed")) {
                    cookie.setValue(cookie.getValue() + ":" + id);
                    resp.addCookie(cookie);
                    return;
                }

        create(resp, id);
    }

    public static List<Integer> get(HttpServletRequest req) {

        var cookies = req.getCookies();
        if (cookies != null)
            for (var cookie : cookies)
                if (cookie.getName().equals("completed")) {
                    var quizzes = cookie.getValue().split(":");
                    return parse(quizzes);
                }

        return null;
    }

    private static void create(HttpServletResponse resp, int id) {
        var cookie = new Cookie("completed", Integer.toString(id));
        cookie.setMaxAge(ttl);
        resp.addCookie(cookie);
    }

    private static List<Integer> parse(String[] quizzes) {
        var ret = new ArrayList<Integer>();
        for (var quiz : quizzes)
            ret.add(Integer.parseInt(quiz));
        return ret;
    }

    private static final int ttl = 60 * 60 * 24 * 365;
}
