package org.example.medexpert.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "specialistes")
public class Specialiste {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String specialite;

    @OneToMany(mappedBy = "specialiste", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<DemandeExpertise> demandeList;

    @OneToMany(mappedBy = "specialiste", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Creneau> creneaux;

    public Specialiste() {}

    public Specialiste(String specialite) {
        this.specialite = specialite;
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
