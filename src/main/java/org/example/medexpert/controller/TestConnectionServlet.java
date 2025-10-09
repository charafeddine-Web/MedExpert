package org.example.medexpert.controller;

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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Object result = em.createNativeQuery("SELECT 1").getSingleResult();
            em.getTransaction().commit();
            out.println("<h2>Connexion réussie ! Test SQL retourne : " + result + "</h2>");
        } catch (Exception e) {
            out.println("<h2>Erreur de connexion : " + e.getMessage() + "</h2>");
            e.printStackTrace(out);
        } finally {
            em.close();
        }
    }
}
