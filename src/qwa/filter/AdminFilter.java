package qwa.filter;

import qwa.domain.Editor;
import qwa.servlet.LoginServlet;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/admin/*")
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

        var req = (HttpServletRequest) servletRequest;
        var resp = (HttpServletResponse) servletResponse;

        var session = req.getSession(false);
        if (session != null) {
            var user = session.getAttribute("user");
            if (user != null) {
                filterChain.doFilter(req, resp);
                return;
            }
        }

        resp.sendRedirect("/login");
    }
}
