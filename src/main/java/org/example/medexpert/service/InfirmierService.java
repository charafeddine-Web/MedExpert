package org.example.medexpert.service;

import org.example.medexpert.model.Patient;
import org.example.medexpert.model.SigneVital;

import java.time.LocalDateTime;
import java.util.List;

public class InfirmierService {
    private final PatientService patientService = new PatientService();

    public void enregistrerPatient(String nom, String prenom, LocalDateTime dateArrivee, String adresse, Boolean mutuelle, String numSecuriteSociale, String antecedents, String allergies, String traitementsEnCours, List<SigneVital> signesVitaux) {
        Patient patient = new Patient(null, nom, prenom, dateArrivee, adresse, mutuelle, numSecuriteSociale, antecedents, allergies, traitementsEnCours, null, signesVitaux);
        patientService.creerPatient(patient);
    }

    public List<Patient> getPatientsDuJour() {
        return patientService.getPatientsDuJour();
    }

//    public List<Object[]> getDerniersSignesVitauxPatientsDuJour() {
//        return patientService.getDerniersSignesVitauxPatientsDuJour();
//    }
}
