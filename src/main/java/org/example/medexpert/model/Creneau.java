package org.example.medexpert.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "creneaux")
public class Creneau {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "date_debut", nullable = false)
    private LocalDateTime dateDebut;

    @Column(name = "date_fin", nullable = false)
    private LocalDateTime dateFin;

    @Column(nullable = false)
    private Boolean disponible;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "specialiste_id", nullable = false)
    private Specialiste specialiste;


    public Creneau() {}

    public Creneau(LocalDateTime dateDebut, LocalDateTime dateFin, Boolean disponible) {
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
        this.disponible = disponible;
    }

    public Long getId() {
        return id;
    }

    public LocalDateTime getDateDebut() {
        return dateDebut;
    }

    public void setDateDebut(LocalDateTime dateDebut) {
        this.dateDebut = dateDebut;
    }

    public LocalDateTime getDateFin() {
        return dateFin;
    }

    public void setDateFin(LocalDateTime dateFin) {
        this.dateFin = dateFin;
    }

    public Boolean getDisponible() {
        return disponible;
    }

    public void setDisponible(Boolean disponible) {
        this.disponible = disponible;
    }

    @Override
    public String toString() {
        return "Creneau{" +
                "id=" + id +
                ", dateDebut=" + dateDebut +
                ", dateFin=" + dateFin +
                ", disponible=" + disponible +
                '}';
    }
}
