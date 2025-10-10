package org.example.medexpert.model;

import jakarta.persistence.*;
import org.example.medexpert.model.enums.TypeUtilisateur;

import java.util.List;

@Entity
@DiscriminatorValue("SPECIALISTE")
@Table(name = "specialistes")
public class Specialiste extends  Utilisateur{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = true)
    private String specialite;

    @OneToMany(mappedBy = "specialiste", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<DemandeExpertise> demandeList;

    @OneToMany(mappedBy = "specialiste", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Creneau> creneaux;

    public Specialiste() {}


    public Specialiste(String nom, String prenom, String email, String motDePasse, TypeUtilisateur role, Long id, String specialite, List<DemandeExpertise> demandeList, List<Creneau> creneaux) {
        super(nom, prenom, email, motDePasse, role);
        this.id = id;
        this.specialite = specialite;
        this.demandeList = demandeList;
        this.creneaux = creneaux;
    }

    public Long getId() {
        return id;
    }

    public String getSpecialite() {
        return specialite;
    }

    public void setSpecialite(String specialite) {
        this.specialite = specialite;
    }

    public List<DemandeExpertise> getDemandeList() {
        return demandeList;
    }

    public void setDemandeList(List<DemandeExpertise> demandeList) {
        this.demandeList = demandeList;
    }

    public List<Creneau> getCreneaux() {
        return creneaux;
    }

    public void setCreneaux(List<Creneau> creneaux) {
        this.creneaux = creneaux;
    }

    @Override
    public String toString() {
        return "Specialiste{" +
                "id=" + id +
                ", specialite='" + specialite + '\'' +
                '}';
    }
}
