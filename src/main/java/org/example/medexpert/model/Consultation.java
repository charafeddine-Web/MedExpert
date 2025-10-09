package org.example.medexpert.model;

import jakarta.persistence.*;
import org.example.medexpert.model.enums.StatutConsultation;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name= "consultations")
public class Consultation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Double cout;

    @Column(nullable = false)
    private LocalDateTime dateConsultation;

    private String observations;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private StatutConsultation statut;

    private String diagnostic;
    private String prescription;
    private String symptomes;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "dossier_id", nullable = false)
    private DossierMedical dossier;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "generaliste_id", nullable = false)
    private Généraliste generaliste;

    @OneToMany(mappedBy = "consultation", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ActeMedical> actes;

    @OneToOne(mappedBy = "consultation", cascade = CascadeType.ALL, orphanRemoval = true)
    private DemandeExpertise demandeExpertise;


    public Consultation(){};

    public Consultation(Long id, Double cout, LocalDateTime dateConsultation, String observations, StatutConsultation statut, String diagnostic, String prescription, String symptomes, DossierMedical dossier, Généraliste generaliste) {
        this.id = id;
        this.cout = cout;
        this.dateConsultation = dateConsultation;
        this.observations = observations;
        this.statut = statut;
        this.diagnostic = diagnostic;
        this.prescription = prescription;
        this.symptomes = symptomes;
        this.dossier = dossier;
        this.generaliste = generaliste;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Double getCout() {
        return cout;
    }

    public void setCout(Double cout) {
        this.cout = cout;
    }

    public LocalDateTime getDateConsultation() {
        return dateConsultation;
    }

    public void setDateConsultation(LocalDateTime dateConsultation) {
        this.dateConsultation = dateConsultation;
    }

    public String getObservations() {
        return observations;
    }

    public void setObservations(String observations) {
        this.observations = observations;
    }

    public StatutConsultation getStatut() {
        return statut;
    }

    public void setStatut(StatutConsultation statut) {
        this.statut = statut;
    }

    public String getDiagnostic() {
        return diagnostic;
    }

    public void setDiagnostic(String diagnostic) {
        this.diagnostic = diagnostic;
    }

    public String getPrescription() {
        return prescription;
    }

    public void setPrescription(String prescription) {
        this.prescription = prescription;
    }

    public String getSymptomes() {
        return symptomes;
    }

    public void setSymptomes(String symptomes) {
        this.symptomes = symptomes;
    }

    public DossierMedical getDossier() {
        return dossier;
    }

    public void setDossier(DossierMedical dossier) {
        this.dossier = dossier;
    }

    public Généraliste getGeneraliste() {
        return generaliste;
    }

    public void setGeneraliste(Généraliste generaliste) {
        this.generaliste = generaliste;
    }

    @Override
    public String toString() {
        return "Consultation{" +
                "id=" + id +
                ", cout=" + cout +
                ", dateConsultation=" + dateConsultation +
                ", observations='" + observations + '\'' +
                ", statut=" + statut +
                ", diagnostic='" + diagnostic + '\'' +
                ", prescription='" + prescription + '\'' +
                ", symptomes='" + symptomes + '\'' +
                ", dossier=" + dossier +
                ", generaliste=" + generaliste +
                '}';
    }
}


