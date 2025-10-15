package org.example.medexpert.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.medexpert.model.Patient;
import org.example.medexpert.model.SigneVital;
import org.example.medexpert.service.InfirmierService;
import org.example.medexpert.service.PatientService;
import org.example.medexpert.service.SigneVitalService;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/infirmier")
public class InfirmierServlet extends HttpServlet {
    private final PatientService patientService = new PatientService();
    private final SigneVitalService signeVitalService = new SigneVitalService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {


        String nom = req.getParameter("nom");
        String prenom = req.getParameter("prenom");
        String numSecuriteSociale = req.getParameter("numSecuriteSociale");


        Patient patient = patientService.patientExiste(nom, prenom, numSecuriteSociale);

        if (patient != null) {
            req.setAttribute("patientExistant", patient);
            req.setAttribute("infoMessage", "Ce patient existe déjà. Vous pouvez ajouter de nouveaux signes vitaux.");

            SigneVital signeVital = new SigneVital();
            signeVital.setTension(Double.valueOf(req.getParameter("tension")));
            signeVital.setFrequenceCardiaque(Double.valueOf(req.getParameter("frequenceCardiaque")));
            signeVital.setTemperature(Double.valueOf(req.getParameter("temperature")));
            signeVital.setFrequenceRespiratoire(Double.valueOf(req.getParameter("frequenceRespiratoire")));
            signeVital.setPoids(Double.valueOf(req.getParameter("poids")));
            signeVital.setTaille(Double.valueOf(req.getParameter("taille")));
            signeVital.setDateMesure(LocalDateTime.now());
            signeVital.setPatient(patient);

            signeVitalService.ajouterSigneVital(patient,signeVital);
            req.setAttribute("successMessage", "Nouveaux signes vitaux ajoutés avec succès pour " + patient.getNom() + " " + patient.getPrenom() + ".");
            req.removeAttribute("patientExistant");

        } else {
            String adresse = req.getParameter("adresse");
            String mutuelleStr = req.getParameter("mutuelle");
            LocalDateTime dateArrivee = LocalDateTime.now();
            Boolean mutuelle = mutuelleStr != null && (mutuelleStr.equalsIgnoreCase("true") || mutuelleStr.equals("1"));
            String antecedents = req.getParameter("antecedents");
            String allergies = req.getParameter("allergies");
            String traitementsEnCours = req.getParameter("traitementsEnCours");

            Patient nouveauPatient = new Patient();
            nouveauPatient.setNom(nom);
            nouveauPatient.setPrenom(prenom);
            nouveauPatient.setDateArrivee(dateArrivee);
            nouveauPatient.setAdresse(adresse);
            nouveauPatient.setMutuelle(mutuelle);
            nouveauPatient.setNumSecuriteSociale(numSecuriteSociale);
            nouveauPatient.setAntecedents(antecedents);
            nouveauPatient.setAllergies(allergies);
            nouveauPatient.setTraitementsEnCours(traitementsEnCours);

            patientService.creerPatient(nouveauPatient);

            SigneVital signeVital = new SigneVital();
            signeVital.setTension(Double.valueOf(req.getParameter("tension")));
            signeVital.setFrequenceCardiaque(Double.valueOf(req.getParameter("frequenceCardiaque")));
            signeVital.setTemperature(Double.valueOf(req.getParameter("temperature")));
            signeVital.setFrequenceRespiratoire(Double.valueOf(req.getParameter("frequenceRespiratoire")));
            signeVital.setPoids(Double.valueOf(req.getParameter("poids")));
            signeVital.setTaille(Double.valueOf(req.getParameter("taille")));
            signeVital.setDateMesure(LocalDateTime.now());
            signeVital.setPatient(nouveauPatient);

            signeVitalService.ajouterSigneVital(nouveauPatient,signeVital);

            req.setAttribute("successMessage", "Patient et signe vital enregistrés avec succès.");
        }
        List<Patient> patientsDuJour = patientService.getPatientsDuJour();
        req.setAttribute("patientsDuJour", patientsDuJour);

        req.getRequestDispatcher("/views/infirmier.jsp").forward(req, res);
    }
}
