package org.example.medexpert.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.medexpert.dao.*;
import org.example.medexpert.model.*;
import org.example.medexpert.model.enums.StatutConsultation;
import org.example.medexpert.model.enums.StatutExpertise;
import org.example.medexpert.model.enums.StatutPatient;
import org.example.medexpert.model.enums.TypeActe;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet(name = "GénéralisteServlet", urlPatterns = {"/generaliste", "/generaliste/consultation", "/generaliste/actes", "/generaliste/expertise"})
public class GénéralisteServlet extends HttpServlet {

    private PatientDAO patientDAO = new PatientDAO();
    private ConsultationDAO consultationDAO = new ConsultationDAO();
    private ActeMedicalDAO acteDAO = new ActeMedicalDAO();
    private CreneauDAO creneauDAO = new CreneauDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        
        loadDashboardData(request);

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
        } else if ("loadCreneaux".equals(action)) {

            String specialisteIdParam = request.getParameter("specialisteId");
            if (specialisteIdParam != null && !specialisteIdParam.isEmpty()) {
                try {
                    Long specialisteId = Long.parseLong(specialisteIdParam);
                    List<Creneau> creneaux = creneauDAO.findAllAjourBySpecialiste(specialisteId);
                    
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    
                    StringBuilder json = new StringBuilder();
                    json.append("{\"creneaux\":[");
                    
                    for (int i = 0; i < creneaux.size(); i++) {
                        Creneau c = creneaux.get(i);
                        if (i > 0) json.append(",");
                        json.append("{");
                        json.append("\"id\":").append(c.getId()).append(",");
                        json.append("\"dateDebut\":\"").append(c.getDateDebut()).append("\",");
                        json.append("\"dateFin\":\"").append(c.getDateFin()).append("\",");
                        json.append("\"disponible\":").append(c.getDisponible());
                        json.append("}");
                    }
                    
                    json.append("]}");
                    response.getWriter().write(json.toString());
                    return;
                } catch (NumberFormatException e) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("{\"error\":\"ID spécialiste invalide\"}");
                    return;
                }
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\":\"ID spécialiste manquant\"}");
                return;
            }
        } else if ("loadSpecialistes".equals(action)) {
            try {
                SpecialisteDAO specialisteDAO = new SpecialisteDAO();
                List<Specialiste> specialistes = specialisteDAO.findAll();
                
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                
                StringBuilder json = new StringBuilder();
                json.append("{\"specialistes\":[");
                
                for (int i = 0; i < specialistes.size(); i++) {
                    Specialiste s = specialistes.get(i);
                    if (i > 0) json.append(",");
                    json.append("{");
                    json.append("\"id\":").append(s.getId()).append(",");
                    json.append("\"nom\":\"").append(s.getNom()).append("\",");
                    json.append("\"prenom\":\"").append(s.getPrenom()).append("\",");
                    json.append("\"specialite\":\"").append(s.getSpecialite() != null ? s.getSpecialite() : "").append("\"");
                    json.append("}");
                }
                
                json.append("]}");
                response.getWriter().write(json.toString());
                return;
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"error\":\"Erreur lors du chargement des spécialistes\"}");
                return;
            }
        }
         else {
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
            LocalDateTime dateConsultation = LocalDateTime.parse(request.getParameter("dateConsultation"));
            String coutParam = request.getParameter("cout");
            String statutParam = request.getParameter("statut");

            Patient patient = patientDAO.findById(patientId);

            HttpSession session = request.getSession(false);

           Généraliste generaliste = (Généraliste) session.getAttribute("user");

            DossierMedical dossier = patient.getDossier();
            if (dossier == null) {
                dossier = new DossierMedical();
                dossier.setPatient(patient);
                dossier.setDateCreation(java.time.LocalDateTime.now());
                DossierMedicalDAO dossierDAO = new DossierMedicalDAO();
                dossierDAO.create(dossier);
                patient.setDossier(dossier);
            }


            Consultation consultation = new Consultation();

            consultation.setDossier(dossier);
            consultation.setGeneraliste(generaliste);
            consultation.setDateConsultation(dateConsultation);
            consultation.setDiagnostic(diagnostic);
            consultation.setPrescription(prescription);
            consultation.setSymptomes(symptomes);
            consultation.setObservations(observations);
            consultation.setStatut(StatutConsultation.valueOf(statutParam));
            consultation.setCout(Double.parseDouble(coutParam));

            consultationDAO.create(consultation);
            patient.setStatus(StatutPatient.TERMINE);
            patientDAO.update(patient);
            
            session.setAttribute("successMessage", "Consultation créée avec succès. Statut du patient mis à jour.");
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

            Double currentCost = consultation.getCout() != null ? consultation.getCout() : 0.0;
            consultation.setCout(currentCost + cout);
            consultationDAO.update(consultation);
            HttpSession sessionActe = request.getSession();
            sessionActe.setAttribute("successMessage", "Acte médical enregistré avec succès.");
            response.sendRedirect(request.getContextPath() + "/generaliste");
        } else if ("/generaliste/expertise".equals(servletPath)) {

            Long consultationId = Long.parseLong(request.getParameter("consultationId"));
            String question = request.getParameter("question");
            String priorite = request.getParameter("priorite");
            String specialisteIdParam = request.getParameter("specialisteId");
            String creneauIdParam = request.getParameter("creneauId");

            Consultation consultation = consultationDAO.findById(consultationId);

            if (consultation == null || consultation.getStatut() != StatutConsultation.EN_ATTENTE_AVIS_SPECIALISTE) {
                HttpSession sessionErr = request.getSession();
                sessionErr.setAttribute("errorMessage", "Consultation invalide pour une demande d'expertise.");
                response.sendRedirect(request.getContextPath() + "/generaliste");
                return;
            }

            DemandeExpertiseDAO deDao = new DemandeExpertiseDAO();
            DemandeExpertise de = new DemandeExpertise();
            de.setConsultation(consultation);
            de.setQuestion(question);
            de.setPriorite(priorite);
            de.setDateDemande(java.time.LocalDateTime.now());
            de.setStatus(StatutExpertise.EN_ATTENTE);

            if (specialisteIdParam != null && !specialisteIdParam.isEmpty()) {
                Long specialisteId = Long.parseLong(specialisteIdParam);
                SpecialisteDAO specialisteDAO = new SpecialisteDAO();
               Specialiste specialiste = specialisteDAO.findById(specialisteId);
                if (specialiste == null) {
                    HttpSession sessionErr2 = request.getSession();
                    sessionErr2.setAttribute("errorMessage", "Spécialiste introuvable.");
                    response.sendRedirect(request.getContextPath() + "/generaliste");
                    return;
                }
                de.setSpecialiste(specialiste);
                
//                // Ajouter le créneau si sélectionné
//                if (creneauIdParam != null && !creneauIdParam.isEmpty()) {
//                    try {
//                        Long creneauId = Long.parseLong(creneauIdParam);
//                        Creneau creneau = creneauDAO.findById(creneauId);
//                        if (creneau != null) {
//                            de.setCreneau(creneau);
//                        }
//                    } catch (NumberFormatException e) {
//                    }
//                }

            } else {
                HttpSession sessionErr2 = request.getSession();
                sessionErr2.setAttribute("errorMessage", "Veuillez choisir un spécialiste.");
                response.sendRedirect(request.getContextPath() + "/generaliste");
                return;
            }

            deDao.create(de);

            HttpSession sessionOk = request.getSession();
            sessionOk.setAttribute("successMessage", "Demande d'expertise créée avec succès.");
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


            String specIdParam = request.getParameter("specialite");
            if (specIdParam != null && !specIdParam.isEmpty()) {
                try {
                    Long specId = Long.parseLong(specIdParam);
                    SpecialisteDAO specialisteDAO = new SpecialisteDAO();
                    Specialiste spec = specialisteDAO.findById(specId);

                    if (spec != null) {
                        List<Creneau> creneauxAujourdhui = creneauDAO.findAllAjourBySpecialiste(spec.getId());
                        request.setAttribute("creneaux", creneauxAujourdhui);
                        request.setAttribute("specialisteSelectionne", spec);
                    } else {
                        request.setAttribute("errorMessage", "Spécialiste introuvable.");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "Identifiant de spécialiste invalide.");
                }
            }


            try {
                SpecialisteDAO specialisteDAO = new SpecialisteDAO();
                List<Specialiste> specialistes = specialisteDAO.findAll();
                request.setAttribute("specialistes", specialistes);
            } catch (Exception ignored) {
                request.setAttribute("errorMessage", "Erreur lors du chargement des specialistes: " + ignored.getMessage());
            }
            
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Erreur lors du chargement des données: " + e.getMessage());
        }
    }

}


