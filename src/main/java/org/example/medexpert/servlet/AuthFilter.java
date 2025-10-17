package org.example.medexpert.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {
        "/generaliste", "/generaliste/*",
        "/specialiste", "/specialiste/*",
        "/infirmier", "/infirmier/*"
})

public class AuthFilter implements Filter {


    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String path = req.getRequestURI();
        Object user = (session != null) ? session.getAttribute("user") : null;


        boolean isPublicPath = path.contains("/login") ||
                path.contains("/register") ||
                path.contains("/views/login.jsp") ||
                path.contains("/views/register.jsp") ||
                path.contains("/assets/") ||
                path.endsWith(".css") ||
                path.endsWith(".js") ||
                path.endsWith(".png") ||
                path.endsWith(".jpg");


        res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        res.setHeader("Pragma", "no-cache");
        res.setDateHeader("Expires", 0);

        if (user == null && !isPublicPath) {
            res.sendRedirect(req.getContextPath() + "/views/login.jsp");
        } else {
            chain.doFilter(request, response);
        }
    }


}
