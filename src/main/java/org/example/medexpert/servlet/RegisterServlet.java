package org.example.medexpert.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.medexpert.model.enums.TypeUtilisateur;
import org.example.medexpert.service.UtilisateurService;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet {
    private final UtilisateurService utilisateurService = new UtilisateurService();

    protected boolean doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nom = req.getParameter("nom");
        String prenom = req.getParameter("prenom");
        String email = req.getParameter("email");
        String password = req.getParameter("motDePasse");
        TypeUtilisateur typeUtilisateur = TypeUtilisateur.valueOf(req.getParameter("typeUtilisateur"));

        boolean success = utilisateurService.register(nom,prenom,email,password,typeUtilisateur);
        if (success) {
            resp.sendRedirect("login.jsp");
        } else {
            req.setAttribute("error", "Email déjà utilisé !");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
        }
    return success;
    }
}
