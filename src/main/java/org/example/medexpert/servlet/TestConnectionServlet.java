package org.example.medexpert.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.persistence.EntityManager;
import org.example.medexpert.util.JpaUtil;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/test-connexion")
public class TestConnectionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Object utilisateur = req.getSession().getAttribute("user");
        if (utilisateur != null) {
            resp.sendRedirect(req.getContextPath() + "/views/dashboard.jsp");
        } else {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
        }
    }
}
