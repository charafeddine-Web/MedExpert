package org.example.medexpert.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.medexpert.model.SigneVital;
import org.example.medexpert.service.InfirmierService;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/infirmier")
public class InfirmierServlet extends HttpServlet {
    private final InfirmierService infirmierService = new InfirmierService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String nom = req.getParameter("nom");
        String prenom = req.getParameter("prenom");
        String dateArriveeStr = req.getParameter("dateArrivee");
        String adresse = req.getParameter("adresse");
        String mutuelleStr = req.getParameter("mutuelle");
        String numSecuriteSociale = req.getParameter("numSecuriteSociale");
        String antecedents = req.getParameter("antecedents");
        String allergies = req.getParameter("allergies");
        String traitementsEnCours = req.getParameter("traitementsEnCours");

        LocalDateTime dateArrivee = null;
        if (dateArriveeStr != null && !dateArriveeStr.isEmpty()) {
            dateArrivee = java.time.LocalDate.parse(dateArriveeStr).atStartOfDay();
        }
        Boolean mutuelle = mutuelleStr != null && (mutuelleStr.equalsIgnoreCase("true") || mutuelleStr.equals("1"));

        List<SigneVital> signesVitaux = new ArrayList<>();

        infirmierService.enregistrerPatient(nom, prenom, dateArrivee, adresse, mutuelle, numSecuriteSociale, antecedents, allergies, traitementsEnCours, signesVitaux);
        res.sendRedirect("/views/infirmier.jsp");
    }
}
