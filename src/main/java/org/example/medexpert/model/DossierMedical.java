package org.example.medexpert.model;

import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "DossierMedicals")
public class DossierMedical {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(nullable = false)
    private LocalDateTime dateCreation;

    @OneToOne
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;

    @OneToMany(mappedBy = "dossier", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Consultation> consultations = new ArrayList<>();

    public DossierMedical(long id, LocalDateTime dateCreation, Patient patient) {
        this.id = id;
        this.dateCreation = dateCreation;
        this.patient = patient;
    }

    public DossierMedical() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public LocalDateTime getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(LocalDateTime dateCreation) {
        this.dateCreation = dateCreation;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }



    @Override
    public String toString() {
        return "DossierMedical{" +
                "id=" + id +
                ", dateCreation=" + dateCreation +
                ", patient=" + patient +
                ", consultations=" + consultations +
                '}';
    }
}
