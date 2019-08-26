package qwa.session;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

public final class CompletedQuizHelper {

    public static void add(HttpServletRequest req, int id) {

        var completed = (List<Integer>) req.getSession().getAttribute("completed");
        if (completed == null)
            completed = new ArrayList<Integer>();

        completed.add(id);

        req.getSession().removeAttribute("completed");
        req.getSession().setAttribute("completed", completed);
    }

    public static List<Integer> get(HttpServletRequest req) {
        var completed = (List<Integer>) req.getSession().getAttribute("completed");
        return completed;
    }

    public static void print(HttpServletRequest req) {

        var completed = (List<Integer>) req.getSession().getAttribute("completed");
        if (completed == null) {
            System.out.println("null");
            return;
        }

        for (int id : completed)
            System.out.println(id);
    }
}
