package org.example.medexpert.model;

import jakarta.persistence.*;
import org.example.medexpert.model.enums.StatutExpertise;
import java.time.LocalDateTime;

@Entity
@Table(name = "demandes_expertise")
public class DemandeExpertise {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String question;

    @Column(nullable = false)
    private String priorite;

    @Column(name = "date_demande", nullable = false)
    private LocalDateTime dateDemande;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private StatutExpertise status;

    @Column(name = "date_avis")
    private LocalDateTime dateAvis;

    private String avis;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "specialiste_id", nullable = false)
    private Specialiste specialiste;

    public DemandeExpertise() {}

    public DemandeExpertise(String question, String priorite, LocalDateTime dateDemande, StatutExpertise status, String avis, LocalDateTime dateAvis, Specialiste specialiste) {
        this.question = question;
        this.priorite = priorite;
        this.dateDemande = dateDemande;
        this.status = status;
        this.avis = avis;
        this.dateAvis = dateAvis;
        this.specialiste = specialiste;
    }


    public Long getId() {
        return id;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getPriorite() {
        return priorite;
    }

    public void setPriorite(String priorite) {
        this.priorite = priorite;
    }

    public LocalDateTime getDateDemande() {
        return dateDemande;
    }

    public void setDateDemande(LocalDateTime dateDemande) {
        this.dateDemande = dateDemande;
    }

    public StatutExpertise getStatus() {
        return status;
    }

    public void setStatus(StatutExpertise status) {
        this.status = status;
    }

    public LocalDateTime getDateAvis() {
        return dateAvis;
    }

    public void setDateAvis(LocalDateTime dateAvis) {
        this.dateAvis = dateAvis;
    }

    public String getAvis() {
        return avis;
    }

    public void setAvis(String avis) {
        this.avis = avis;
    }

    public Specialiste getSpecialiste() {
        return specialiste;
    }

    public void setSpecialiste(Specialiste specialiste) {
        this.specialiste = specialiste;
    }

    @Override
    public String toString() {
        return "DemandeExpertise{" +
                "id=" + id +
                ", question='" + question + '\'' +
                ", priorite='" + priorite + '\'' +
                ", dateDemande=" + dateDemande +
                ", status=" + status +
                ", dateAvis=" + dateAvis +
                ", avis='" + avis + '\'' +
                '}';
    }
}
