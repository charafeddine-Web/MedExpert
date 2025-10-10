package org.example.medexpert.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "signes_vitaux")
public class SigneVital {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;

    @OneToOne
    @JoinColumn(name = "consultation_id", unique = true)
    private Consultation consultation;

    private Double tension;
    private Double frequenceCardiaque;
    private Double temperature;
    private Double frequenceRespiratoire;
    private Double poids;
    private Double taille;
    private LocalDateTime dateMesure;

    public SigneVital() {
    }


    public SigneVital(Long id, Patient patient, Consultation consultation, Double tension, Double frequenceCardiaque, Double temperature, Double frequenceRespiratoire, Double poids, Double taille, LocalDateTime dateMesure) {
        this.id = id;
        this.patient = patient;
        this.consultation = consultation;
        this.tension = tension;
        this.frequenceCardiaque = frequenceCardiaque;
        this.temperature = temperature;
        this.frequenceRespiratoire = frequenceRespiratoire;
        this.poids = poids;
        this.taille = taille;
        this.dateMesure = dateMesure;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Double getTension() { return tension; }
    public void setTension(Double tension) { this.tension = tension; }

    public Double getFrequenceCardiaque() { return frequenceCardiaque; }
    public void setFrequenceCardiaque(Double frequenceCardiaque) { this.frequenceCardiaque = frequenceCardiaque; }

    public Double getTemperature() { return temperature; }
    public void setTemperature(Double temperature) { this.temperature = temperature; }

    public Double getFrequenceRespiratoire() { return frequenceRespiratoire; }
    public void setFrequenceRespiratoire(Double frequenceRespiratoire) { this.frequenceRespiratoire = frequenceRespiratoire; }

    public Double getPoids() { return poids; }
    public void setPoids(Double poids) { this.poids = poids; }

    public Double getTaille() { return taille; }
    public void setTaille(Double taille) { this.taille = taille; }

    public LocalDateTime getDateMesure() { return dateMesure; }
    public void setDateMesure(LocalDateTime dateMesure) { this.dateMesure = dateMesure; }

    public Consultation getConsultation() { return consultation; }
    public void setConsultation(Consultation consultation) { this.consultation = consultation; }

    public Patient getPatient() { return patient; }
    public void setPatient(Patient patient) { this.patient = patient; }

    @Override
    public String toString() {
        return "SigneVital{" +
                "id=" + id +
                ", tension=" + tension +
                ", frequenceCardiaque=" + frequenceCardiaque +
                ", temperature=" + temperature +
                ", frequenceRespiratoire=" + frequenceRespiratoire +
                ", poids=" + poids +
                ", taille=" + taille +
                ", dateMesure=" + dateMesure +
                ", consultation=" + consultation +
                '}';
    }
}
