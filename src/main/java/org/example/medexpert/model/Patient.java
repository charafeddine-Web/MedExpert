package org.example.medexpert.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "patients")
public class Patient {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String nom;

    @Column(nullable = false)
    private String prenom;

    @Column(name = "date_arrivee", nullable = false)
    private LocalDateTime dateArrivee;

    private String adresse;
    private Boolean mutuelle;

    @Column(name = "num_securite_sociale", unique = true)
    private String numSecuriteSociale;

    @Column(nullable = false)
    private String antecedents;

    @Column(nullable = false)
    private String allergies;

    @Column(nullable = false)
    private String traitementsEnCours;

    @OneToOne(mappedBy = "patient", cascade = CascadeType.ALL)
    private DossierMedical dossier;

    @OneToMany(mappedBy = "patient", cascade = CascadeType.ALL)
    private List<SigneVital> signesVitaux;

    public Patient() {}

    public Patient(Long id, String nom, String prenom, LocalDateTime dateArrivee, String adresse, Boolean mutuelle, String numSecuriteSociale, String antecedents, String allergies, String traitementsEnCours, DossierMedical dossier, List<SigneVital> signesVitaux) {
        this.id = id;
        this.nom = nom;
        this.prenom = prenom;
        this.dateArrivee = dateArrivee;
        this.adresse = adresse;
        this.mutuelle = mutuelle;
        this.numSecuriteSociale = numSecuriteSociale;
        this.antecedents = antecedents;
        this.allergies = allergies;
        this.traitementsEnCours = traitementsEnCours;
        this.dossier = dossier;
        this.signesVitaux = signesVitaux;
    }

    // Getters & Setters
    public Long getId() { return id; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }

    public LocalDateTime getDateArrivee() { return dateArrivee; }
    public void setDateArrivee(LocalDateTime dateArrivee) { this.dateArrivee = dateArrivee; }

    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }

    public Boolean getMutuelle() { return mutuelle; }
    public void setMutuelle(Boolean mutuelle) { this.mutuelle = mutuelle; }

    public String getNumSecuriteSociale() { return numSecuriteSociale; }
    public void setNumSecuriteSociale(String numSecuriteSociale) { this.numSecuriteSociale = numSecuriteSociale; }

    public String getAntecedents() { return antecedents; }
    public void setAntecedents(String antecedents) { this.antecedents = antecedents; }

    public String getAllergies() { return allergies; }
    public void setAllergies(String allergies) { this.allergies = allergies; }

    public String getTraitementsEnCours() { return traitementsEnCours; }
    public void setTraitementsEnCours(String traitementsEnCours) { this.traitementsEnCours = traitementsEnCours; }

    public DossierMedical getDossier() { return dossier; }
    public void setDossier(DossierMedical dossier) { this.dossier = dossier; }

    @Override
    public String toString() {
        return "Patient{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", prenom='" + prenom + '\'' +
                ", dateArrivee=" + dateArrivee +
                ", adresse='" + adresse + '\'' +
                ", mutuelle=" + mutuelle +
                ", numSecuriteSociale='" + numSecuriteSociale + '\'' +
                '}';
    }
}
