package org.example.medexpert.service;

import org.example.medexpert.dao.GénéralisteDAO;
import org.example.medexpert.model.Généraliste;

import java.util.List;

public class GénéralisteService {

    private final GénéralisteDAO generalisteDAO;

    public GénéralisteService() {
        this.generalisteDAO = new GénéralisteDAO();
    }

    public void ajouterGénéraliste(Généraliste generaliste) {
        if (generaliste == null) {
            throw new IllegalArgumentException("Le généraliste ne peut pas être null.");
        }
        generalisteDAO.create(generaliste);
    }

    public Généraliste trouverParId(Long id) {
        if (id == null) {
            throw new IllegalArgumentException("L'ID ne peut pas être null.");
        }
        return generalisteDAO.findById(id);
    }

    public List<Généraliste> listerTous() {
        return generalisteDAO.findAll();
    }

    public void mettreAJour(Généraliste generaliste) {
        if (generaliste == null || generaliste.getId() == null) {
            throw new IllegalArgumentException("Le généraliste ou son ID ne peut pas être null.");
        }
        generalisteDAO.update(generaliste);
    }

    public void supprimer(Long id) {
        if (id == null) {
            throw new IllegalArgumentException("L'ID ne peut pas être null.");
        }
        generalisteDAO.delete(id);
    }
}
