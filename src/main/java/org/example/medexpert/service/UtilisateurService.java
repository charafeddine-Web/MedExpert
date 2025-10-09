package org.example.medexpert.service;

import org.example.medexpert.dao.UtilisateurDAO;
import org.example.medexpert.model.Utilisateur;

import java.util.List;

public class UtilisateurService {
    private final UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

    public void creerUtilisateur(Utilisateur utilisateur) {
        utilisateurDAO.save(utilisateur);
    }

    public Utilisateur trouverParId(Long id) {
        return utilisateurDAO.findById(id);
    }

    public List<Utilisateur> listerUtilisateurs() {
        return utilisateurDAO.findAll();
    }

    public void mettreAJourUtilisateur(Utilisateur utilisateur) {
        utilisateurDAO.update(utilisateur);
    }

    public void supprimerUtilisateur(Long id) {
        utilisateurDAO.delete(id);
    }

    public Utilisateur trouverParEmail(String email) {
        return utilisateurDAO.findByEmail(email);
    }
}
