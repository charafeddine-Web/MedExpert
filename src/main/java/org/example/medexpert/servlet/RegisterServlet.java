package org.example.medexpert.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.medexpert.model.enums.TypeUtilisateur;
import org.example.medexpert.service.UtilisateurService;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private final UtilisateurService utilisateurService = new UtilisateurService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nom = req.getParameter("nom");
        String prenom = req.getParameter("prenom");
        String email = req.getParameter("email");
        String password = req.getParameter("motDePasse");
        TypeUtilisateur typeUtilisateur = TypeUtilisateur.valueOf(req.getParameter("role"));

        boolean success = utilisateurService.register(nom,prenom,email,password,typeUtilisateur);
        if (success) {
            resp.sendRedirect("views/login.jsp");
        } else {
            req.setAttribute("error", "Email déjà utilisé !");
            req.getRequestDispatcher("views/register.jsp").forward(req, resp);
        }
    }
}
