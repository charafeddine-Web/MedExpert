package org.example.medexpert.model;

import jakarta.persistence.Column;
import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import org.example.medexpert.model.enums.TypeUtilisateur;

@Entity
@DiscriminatorValue("INFIRMIER")
@Table(name = "infirmiers")
public class Infirmier extends Utilisateur {

    @Column(nullable = true)
    private String service;

    public Infirmier(String nom, String prenom, String email, String motDePasse, TypeUtilisateur role, String service) {
        super(nom, prenom, email, motDePasse, role);
        this.service = service;
    }
    public Infirmier() {

    }

    public String getService() { return service; }
    public void setService(String service) { this.service = service; }
}
