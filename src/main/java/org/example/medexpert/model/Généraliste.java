package org.example.medexpert.model;

import jakarta.persistence.*;
import org.example.medexpert.model.enums.TypeUtilisateur;

import java.util.List;


@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@Table(name = "generalistes" )

public class Généraliste extends Utilisateur {

    @OneToMany(mappedBy = "generaliste", cascade = CascadeType.ALL)
    private List<Consultation> consultationList;

    public Généraliste() {}

    public Généraliste(Long id, String nom, String prenom, String email, String motDePasse, TypeUtilisateur role, List<Consultation> consultationList) {
        super(id, nom, prenom, email, motDePasse, role);
        this.consultationList = consultationList;
    }

    public List<Consultation> getConsultationList() {
        return consultationList;
    }

    public void setConsultationList(List<Consultation> consultationList) {
        this.consultationList = consultationList;
    }

    @Override
    public String toString() {
        return "Généraliste{" +
                "consultationList=" + consultationList +
                '}';
    }
}
