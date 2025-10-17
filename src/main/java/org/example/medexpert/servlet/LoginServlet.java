package org.example.medexpert.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.medexpert.dao.GénéralisteDAO;
import org.example.medexpert.model.Généraliste;
import org.example.medexpert.model.Utilisateur;
import org.example.medexpert.model.enums.TypeUtilisateur;
import org.example.medexpert.service.UtilisateurService;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UtilisateurService utilisateurService = new UtilisateurService();

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

        request.getRequestDispatcher("views/login.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("password");

        Utilisateur u = utilisateurService.login(email, motDePasse);
           HttpSession session = request.getSession();


        if (u != null) {
            session.setAttribute("user",  u);

            String redirectUrl = "error.jsp";

            switch (u.getRole()) {
                case MEDECIN_GENERALISTE:
                    redirectUrl = request.getContextPath() + "/generaliste";
                    break;
                case INFIRMIER:
                    redirectUrl = "views/infirmier.jsp";
                    break;
                case MEDECIN_SPECIALISTE:
                    redirectUrl = request.getContextPath() + "/specialiste";
                    break;
                default:
                    redirectUrl = "views/login.jsp";
                    break;
            }
            response.sendRedirect(redirectUrl);
        } else {
            request.setAttribute("error", "Email ou mot de passe incorrect");
            request.getRequestDispatcher("views/login.jsp").forward(request, response);
        }
    }
}
