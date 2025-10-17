package org.example.medexpert.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.medexpert.dao.DemandeExpertiseDAO;
import org.example.medexpert.dao.CreneauDAO;
import org.example.medexpert.dao.SpecialisteDAO;
import org.example.medexpert.model.DemandeExpertise;
import org.example.medexpert.model.Creneau;
import org.example.medexpert.model.Specialiste;
import org.example.medexpert.model.enums.StatutExpertise;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@WebServlet(name = "SpecialisteServlet", urlPatterns = {"/specialiste", "/specialiste/profil", "/specialiste/avis", "/specialiste/creneau"})
public class SpecialisteServlet extends HttpServlet {

    private final DemandeExpertiseDAO demandeExpertiseDAO = new DemandeExpertiseDAO();
    private final SpecialisteDAO specialisteDAO = new SpecialisteDAO();
    private final CreneauDAO creneauDAO = new CreneauDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Specialiste specialiste = session != null ? (Specialiste) session.getAttribute("user") : null;
        if (specialiste == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
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

        loadDashboardData(request, specialiste);

        request.getRequestDispatcher("/views/specialiste.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();

        HttpSession session = request.getSession(false);
        Specialiste specialiste = session != null ? (Specialiste) session.getAttribute("user") : null;
        if (specialiste == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        if ("/specialiste/profil".equals(servletPath)) {
            String specialite = request.getParameter("specialite");
            String tarifParam = request.getParameter("tarif");
            try {
                if (specialite != null && !specialite.isEmpty()) {
                    specialiste.setSpecialite(specialite);
                    if (tarifParam != null && !tarifParam.isBlank()) {
                        try {
                            specialiste.setTarif(Double.parseDouble(tarifParam));
                        } catch (NumberFormatException ignored) {}
                    }
                    specialisteDAO.update(specialiste);
                    
                    request.getSession().setAttribute("user", specialiste);
                    request.getSession().setAttribute("successMessage", "Profil mis à jour.");
                } else {
                    request.getSession().setAttribute("errorMessage", "La spécialité est obligatoire.");
                }
            } catch (Exception e) {
                request.getSession().setAttribute("errorMessage", "Erreur lors de la mise à jour: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/specialiste");
        } else if ("/specialiste/creneau".equals(servletPath)) {
            String dateDebut = request.getParameter("dateDebut");
            String dateFin = request.getParameter("dateFin");
            try {
                if (dateDebut != null && dateFin != null && !dateDebut.isBlank() && !dateFin.isBlank()) {
                    Creneau c = new Creneau();
                    c.setDateDebut(LocalDateTime.parse(dateDebut));
                    c.setDateFin(LocalDateTime.parse(dateFin));
                    c.setDisponible(true);
                    c.setSpecialiste(specialiste);
                    creneauDAO.create(c);
                    request.getSession().setAttribute("successMessage", "Créneau ajouté.");
                } else {
                    request.getSession().setAttribute("errorMessage", "Veuillez renseigner les dates de début et fin.");
                }
            } catch (Exception e) {
                request.getSession().setAttribute("errorMessage", "Erreur lors de l'ajout du créneau: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/specialiste");
        } else if ("/specialiste/avis".equals(servletPath)) {
            String expertiseIdParam = request.getParameter("expertiseId");
            String avis = request.getParameter("avis");
            String statutParam = request.getParameter("statut");
            try {
                Long expertiseId = Long.parseLong(expertiseIdParam);
                DemandeExpertise demande = demandeExpertiseDAO.findById(expertiseId);
                if (demande == null || demande.getSpecialiste() == null || !Objects.equals(demande.getSpecialiste().getId(), specialiste.getId())) {
                    request.getSession().setAttribute("errorMessage", "Demande introuvable ou non autorisée.");
                    response.sendRedirect(request.getContextPath() + "/specialiste");
                    return;
                }

                if (avis == null || avis.isBlank()) {
                    request.getSession().setAttribute("errorMessage", "L'avis médical est obligatoire.");
                    response.sendRedirect(request.getContextPath() + "/specialiste");
                    return;
                }

                demande.setAvis(avis);
                demande.setDateAvis(LocalDateTime.now());
                if (statutParam != null && !statutParam.isBlank()) {
                    demande.setStatus(StatutExpertise.valueOf(statutParam));
                }
                demandeExpertiseDAO.update(demande);

                request.getSession().setAttribute("successMessage", "Avis enregistré avec succès.");
            } catch (Exception e) {
                request.getSession().setAttribute("errorMessage", "Erreur lors de l'enregistrement de l'avis: " + e.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/specialiste");
        } else {
            response.sendRedirect(request.getContextPath() + "/specialiste");
        }
    }

    private void loadDashboardData(HttpServletRequest request, Specialiste specialiste) {
        try {
            List<DemandeExpertise> all = demandeExpertiseDAO.findAll();

            List<DemandeExpertise> expertises = all.stream()
                    .filter(d -> d.getSpecialiste() != null && d.getSpecialiste().getId() != null)
                    .filter(d -> Objects.equals(d.getSpecialiste().getId(), specialiste.getId()))
                    .collect(Collectors.toList());

            int total = expertises.size();
            int enAttente = (int) expertises.stream().filter(d -> d.getStatus() == StatutExpertise.EN_ATTENTE).count();
            int enCours = (int) expertises.stream().filter(d -> d.getStatus() == StatutExpertise.EN_COURS).count();
            int terminees = (int) expertises.stream().filter(d -> d.getStatus() == StatutExpertise.TERMINEE).count();

            Integer tempsMoyenReponse = null;
            List<DemandeExpertise> completed = expertises.stream()
                    .filter(d -> d.getStatus() == StatutExpertise.TERMINEE && d.getDateAvis() != null && d.getDateDemande() != null)
                    .collect(Collectors.toList());

            if (!completed.isEmpty()) {
                long totalHours = 0L;
                for (DemandeExpertise d : completed) {
                    totalHours += Duration.between(d.getDateDemande(), d.getDateAvis()).toHours();
                }
                tempsMoyenReponse = (int) Math.max(0, totalHours / completed.size());
            }

            Double revenusTotal = 0.0;

            request.setAttribute("specialiste", specialiste);
            request.setAttribute("expertises", expertises);
            request.setAttribute("totalExpertises", total);
            request.setAttribute("expertisesEnAttente", enAttente);
            request.setAttribute("expertisesEnCours", enCours);
            request.setAttribute("expertisesTerminees", terminees);
            request.setAttribute("revenusTotal", revenusTotal);

            // Load creneaux for calendar display
            try {
                List<Creneau> creneaux = creneauDAO.findBySpecialisteId(specialiste.getId());
                request.setAttribute("creneaux", creneaux);
            } catch (Exception ignored) {}


            if (tempsMoyenReponse != null) {
                request.setAttribute("tempsMoyenReponse", tempsMoyenReponse);
            }

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Erreur lors du chargement des données: " + e.getMessage());
        }
    }
}
