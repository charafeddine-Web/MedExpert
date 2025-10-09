package org.example.medexpert.service;

import org.example.medexpert.dao.UtilisateurDAO;
import org.example.medexpert.model.Utilisateur;
import org.example.medexpert.model.enums.TypeUtilisateur;
import org.mindrot.jbcrypt.BCrypt;

import java.util.List;

public class UtilisateurService {
    private final UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

    public boolean register(String nom, String prenom, String email, String motDePasse, TypeUtilisateur typeUtilisateur) {
        if (utilisateurDAO.findByEmail(email) != null) {
            throw new IllegalArgumentException("Email already in use");
        }
        String hashed = BCrypt.hashpw(motDePasse, BCrypt.gensalt());
        Utilisateur u = new Utilisateur (nom, prenom, email, hashed, TypeUtilisateur.USER);
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
}
