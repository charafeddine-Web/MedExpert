package org.example.medexpert.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.medexpert.model.Utilisateur;
import org.example.medexpert.model.enums.TypeUtilisateur;
import org.example.medexpert.service.UtilisateurService;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private final UtilisateurService utilisateurService = new UtilisateurService();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("user") != null) {
            Utilisateur user = (Utilisateur) session.getAttribute("user");

            String redirectUrl;
            switch (user.getRole()) {
                case MEDECIN_GENERALISTE:
                    redirectUrl = request.getContextPath() + "/generaliste";
                    break;
                case INFIRMIER:
                    redirectUrl = request.getContextPath() + "/infirmier";
                    break;
                case MEDECIN_SPECIALISTE:
                    redirectUrl = request.getContextPath() + "/specialiste";
                    break;
                default:
                    redirectUrl = request.getContextPath() + "/views/login.jsp";
                    break;
            }

            response.sendRedirect(redirectUrl);
            return;
        }

        request.getRequestDispatcher("views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nom = req.getParameter("nom");
        String prenom = req.getParameter("prenom");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String specialite = req.getParameter("specialite");
        String service = req.getParameter("service");
        TypeUtilisateur role = TypeUtilisateur.valueOf(req.getParameter("role"));

        if (password == null || !password.equals(confirmPassword)) {
            req.setAttribute("error", "Les mots de passe ne correspondent pas.");
            req.getRequestDispatcher("views/register.jsp").forward(req, resp);
            return;
        }

        boolean success;
        try {
            success = utilisateurService.register(nom, prenom, email, password, role, specialite, service);
        } catch (IllegalArgumentException e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("views/register.jsp").forward(req, resp);
            return;
        }

        if (success) {
            resp.sendRedirect("views/login.jsp");
        } else {
            req.setAttribute("error", "Email déjà utilisé !");
            req.getRequestDispatcher("views/register.jsp").forward(req, resp);
        }
    }
}
