package org.example.medexpert.service;

import jakarta.servlet.http.HttpSession;
import org.example.medexpert.dao.UtilisateurDAO;
import org.example.medexpert.model.Généraliste;
import org.example.medexpert.model.Utilisateur;
import org.example.medexpert.model.Specialiste;
import org.example.medexpert.model.Infirmier;

import org.example.medexpert.model.enums.TypeUtilisateur;
import org.mindrot.jbcrypt.BCrypt;

import java.util.ArrayList;
import java.util.List;

public class UtilisateurService {
    private final UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

    public boolean register(String nom, String prenom, String email, String motDePasse, TypeUtilisateur role, String specialite, String service) {
        if (utilisateurDAO.findByEmail(email) != null) {
            throw new IllegalArgumentException("Email already in use");
        }
        String hashed = BCrypt.hashpw(motDePasse, BCrypt.gensalt());
        Utilisateur u;
        switch (role) {
            case MEDECIN_SPECIALISTE:
                u = new Specialiste(nom, prenom, email, hashed, role, null, specialite, null, null);
                break;
            case MEDECIN_GENERALISTE:
                u = new Généraliste(nom, prenom, email, hashed, role, new ArrayList<>());
                break;
            case INFIRMIER:
                u = new Infirmier(nom, prenom, email, hashed, role, service);
                break;
            default:
                u = new Utilisateur(nom, prenom, email, hashed, role);
        }
        utilisateurDAO.save(u);
        return true;
    }

    public Utilisateur login(String email, String motDePasse) {
        Utilisateur u = utilisateurDAO.findByEmail(email);
        if (u != null && BCrypt.checkpw(motDePasse, u.getMotDePasse())) {
            return u;
        }
        return null;
    }

    public Utilisateur trouverParEmail(String email) {
        return utilisateurDAO.findByEmail(email);
    }

    public boolean valideteuser(String email,String password){
        Utilisateur utilisateur = utilisateurDAO.findByEmail(email);
        if (utilisateur != null && utilisateur.getMotDePasse().equals(password)) {
            return true;
        }
        return false;

    }

    public void logout(HttpSession session) {
        if (session != null) {
            session.invalidate();
        }
    }
}
