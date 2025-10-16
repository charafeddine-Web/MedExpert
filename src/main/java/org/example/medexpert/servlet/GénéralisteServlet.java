package org.example.medexpert.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.medexpert.dao.PatientDAO;
import org.example.medexpert.dao.ConsultationDAO;
import org.example.medexpert.dao.ActeMedicalDAO;
import org.example.medexpert.dao.DossierMedicalDAO;
import org.example.medexpert.dao.GénéralisteDAO;
import org.example.medexpert.model.DossierMedical;
import org.example.medexpert.model.Patient;
import org.example.medexpert.model.Consultation;
import org.example.medexpert.model.ActeMedical;
import org.example.medexpert.model.Généraliste;
import org.example.medexpert.model.Utilisateur;
import org.example.medexpert.model.enums.TypeUtilisateur;
import org.example.medexpert.model.enums.StatutConsultation;
import org.example.medexpert.model.enums.TypeActe;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@WebServlet(name = "GénéralisteServlet", urlPatterns = {"/generaliste", "/generaliste/consultation", "/generaliste/actes"})
public class GénéralisteServlet extends HttpServlet {

    private PatientDAO patientDAO = new PatientDAO();
    private ConsultationDAO consultationDAO = new ConsultationDAO();
    private ActeMedicalDAO acteDAO = new ActeMedicalDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        
        loadDashboardData(request);

        // Ensure session holds a Généraliste entity if the user is a generalist
        HttpSession sessionAuth = request.getSession(false);
        if (sessionAuth != null) {
            Object sessionUserObj = sessionAuth.getAttribute("user");
            if (sessionUserObj instanceof Utilisateur && !(sessionUserObj instanceof Généraliste)) {
                Utilisateur u = (Utilisateur) sessionUserObj;
                if (u.getRole() == TypeUtilisateur.MEDECIN_GENERALISTE) {
                    GénéralisteDAO generalisteDAO = new GénéralisteDAO();
                    Généraliste g = generalisteDAO.findByEmail(u.getEmail());
                    if (g == null && u.getId() != null) {
                        g = generalisteDAO.findById(u.getId());
                    }
                    if (g == null) {
                        // single-generalist fallback
                        java.util.List<Généraliste> all = generalisteDAO.findAll();
                        if (!all.isEmpty()) g = all.get(0);
                    }
                    if (g != null) sessionAuth.setAttribute("user", g);
                }
            }
        }



        HttpSession sessionForMessages = request.getSession(false);
        if (sessionForMessages != null) {
            Object info = sessionForMessages.getAttribute("infoMessage");
            Object success = sessionForMessages.getAttribute("successMessage");
            Object error = sessionForMessages.getAttribute("errorMessage");
            if (info != null) {
                request.setAttribute("infoMessage", info);
                sessionForMessages.removeAttribute("infoMessage");
            }
            if (success != null) {
                request.setAttribute("successMessage", success);
                sessionForMessages.removeAttribute("successMessage");
            }
            if (error != null) {
                request.setAttribute("errorMessage", error);
                sessionForMessages.removeAttribute("errorMessage");
            }
        }

        if ("listePatients".equals(action)) {
            List<Patient> patients = patientDAO.getPatientsEnAttente();
            request.setAttribute("patients", patients);
            request.getRequestDispatcher("/views/generaliste.jsp").forward(request, response);

        } else if ("creerConsultation".equals(action)) {
            Long patientId = Long.parseLong(request.getParameter("patientId"));
            request.setAttribute("patientId", patientId);
            request.getRequestDispatcher("/views/generaliste.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/views/generaliste.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String servletPath = request.getServletPath();

        if ("/generaliste/consultation".equals(servletPath)) {

            Long patientId = Long.parseLong(request.getParameter("patientId"));
            String diagnostic = request.getParameter("diagnostic");
            String prescription = request.getParameter("prescription");
            String symptomes = request.getParameter("symptomes");
            String observations = request.getParameter("observations");
            String dateConsultation = request.getParameter("dateConsultation");
            String heureConsultation = request.getParameter("heureConsultation");
            String coutParam = request.getParameter("cout");
            String statutParam = request.getParameter("statut");

            Patient patient = patientDAO.findById(patientId);

            HttpSession session = request.getSession(false);

           Généraliste generaliste = (Généraliste) session.getAttribute("user");
//            Object sessionUser = session.getAttribute("user");
//
//            Généraliste generaliste = null;
//            if (sessionUser instanceof Généraliste) {
//                generaliste = (Généraliste) sessionUser;
//            } else if (sessionUser instanceof Utilisateur) {
//                Utilisateur u = (Utilisateur) sessionUser;
//                if (u.getRole() == TypeUtilisateur.MEDECIN_GENERALISTE) {
//                    GénéralisteDAO generalisteDAO = new GénéralisteDAO();
//                    generaliste = generalisteDAO.findByEmail(u.getEmail());
//                    if (generaliste == null && u.getId() != null) {
//                        generaliste = generalisteDAO.findById(u.getId());
//                    }
//                    if (generaliste != null) {
//                        session.setAttribute("user", generaliste);
//                    }
//                }
//            }
//            if (generaliste == null) {
//                // final fallback: pick first generalist from DB if the app only has one
//                GénéralisteDAO generalisteDAO = new GénéralisteDAO();
//                java.util.List<Généraliste> all = generalisteDAO.findAll();
//                if (!all.isEmpty()) {
//                    generaliste = all.get(0);
//                    session.setAttribute("user", generaliste);
//                } else {
//                    session.setAttribute("errorMessage", "Impossible de déterminer le médecin généraliste courant.");
//                    response.sendRedirect(request.getContextPath() + "/views/login.jsp");
//                    return;
//                }
//            }

            DossierMedical dossier = patient.getDossier();
            if (dossier == null) {
                dossier = new DossierMedical();
                dossier.setPatient(patient);
                dossier.setDateCreation(java.time.LocalDateTime.now());
                DossierMedicalDAO dossierDAO = new DossierMedicalDAO();
                dossierDAO.create(dossier);
                patient.setDossier(dossier);
            }

            LocalDate date = LocalDate.parse(dateConsultation);
            LocalTime time = LocalTime.parse(heureConsultation);
            LocalDateTime dateTime = LocalDateTime.of(date, time);

            Consultation consultation = new Consultation();

            consultation.setDossier(dossier);
            consultation.setGeneraliste(generaliste);
            consultation.setDateConsultation(dateTime);
            consultation.setDiagnostic(diagnostic);
            consultation.setPrescription(prescription);
            consultation.setSymptomes(symptomes);
            consultation.setObservations(observations);
            consultation.setStatut(StatutConsultation.valueOf(statutParam));
            consultation.setCout(Double.parseDouble(coutParam));

            consultationDAO.create(consultation);
            session.setAttribute("successMessage", "Consultation créée avec succès.");
            response.sendRedirect(request.getContextPath() + "/generaliste");

        } else if ("/generaliste/actes".equals(servletPath)) {

            String consultationIdParam = request.getParameter("consultationIdSelect");
            if (consultationIdParam == null || consultationIdParam.isEmpty()) {
                consultationIdParam = request.getParameter("consultationId");
            }
            Long consultationId = Long.parseLong(consultationIdParam);

            String typeActe = request.getParameter("typeActe");
            Double cout = Double.parseDouble(request.getParameter("coutActe"));

            Consultation consultation = consultationDAO.findById(consultationId);

            ActeMedical acte = new ActeMedical();
            acte.setTypeActe(TypeActe.valueOf(typeActe));
            acte.setCout(cout);
            acte.setConsultation(consultation);

            acteDAO.create(acte);
            HttpSession sessionActe = request.getSession();
            sessionActe.setAttribute("successMessage", "Acte médical enregistré avec succès.");
            response.sendRedirect(request.getContextPath() + "/generaliste");
        }
    }
    
    private void loadDashboardData(HttpServletRequest request) {
        try {
            List<Patient> patientsAttente = patientDAO.getPatientsEnAttente();
            request.setAttribute("patientsAttente", patientsAttente);
            
            List<Consultation> consultationsRecentes = consultationDAO.getConsultationsAujourdhui();
            request.setAttribute("consultationsRecentes", consultationsRecentes);
            request.setAttribute("nbConsultationsJour", consultationsRecentes.size());
            
            List<ActeMedical> actesAujourdhui = acteDAO.getActesAujourdhui();
            request.setAttribute("nbActesJour", actesAujourdhui.size());
            
            List<Consultation> consultations = consultationDAO.findAll();
            request.setAttribute("consultations", consultations);
            
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Erreur lors du chargement des données: " + e.getMessage());
        }
    }
}
