package org.example.medexpert.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "SpecialisteServlet",urlPatterns = {"/specialiste"})
public class SpecialisteServlet extends HttpServlet {

    @Override
    protected  void doGet(HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
        req.getRequestDispatcher("/views/specialiste.jsp").forward(req,res);
    }

}
