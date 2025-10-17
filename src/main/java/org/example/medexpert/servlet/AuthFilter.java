package org.example.medexpert.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.medexpert.model.Utilisateur;
import org.example.medexpert.model.enums.TypeUtilisateur;

import java.io.IOException;
@WebFilter(urlPatterns = "/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        String path = req.getRequestURI();
        Utilisateur user = (session != null) ? (Utilisateur) session.getAttribute("user") : null;

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
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if (user != null && (path.endsWith("login") || path.endsWith("login.jsp") ||
                path.endsWith("register") || path.endsWith("register.jsp"))) {
            switch (user.getRole()) {
                case MEDECIN_SPECIALISTE -> res.sendRedirect(req.getContextPath() + "/specialiste");
                case MEDECIN_GENERALISTE -> res.sendRedirect(req.getContextPath() + "/generaliste?action=list");
                case INFIRMIER -> res.sendRedirect(req.getContextPath() + "/infirmier");
                default -> res.sendRedirect(req.getContextPath() + "/");
            }
            return;
        }

        if (path.contains("/specialiste") && (user == null || !user.getRole().equals(TypeUtilisateur.MEDECIN_SPECIALISTE))) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if (path.contains("/generaliste") && (user == null || !user.getRole().equals(TypeUtilisateur.MEDECIN_GENERALISTE))) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if (path.contains("/infirmier") && (user == null || !user.getRole().equals(TypeUtilisateur.INFIRMIER))) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        chain.doFilter(request, response);
    }
}
