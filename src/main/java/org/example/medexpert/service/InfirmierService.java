package org.example.medexpert.service;

import org.example.medexpert.model.Patient;
import org.example.medexpert.model.SigneVital;

import java.time.LocalDateTime;
import java.util.List;

public class InfirmierService {
    private final PatientService patientService = new PatientService();
    private final SigneVitalService signeVitalService = new SigneVitalService();

    public Patient enregistrerPatient(String nom, String prenom, LocalDateTime dateArrivee, String adresse, Boolean mutuelle, String numSecuriteSociale, String antecedents, String allergies, String traitementsEnCours) {
        Patient patient = new Patient(null, nom, prenom, dateArrivee, adresse, mutuelle, numSecuriteSociale, antecedents, allergies, traitementsEnCours, null);
        patientService.creerPatient(patient);
        return patient;
    }

    public List<Patient> getPatientsDuJour() {
        return patientService.getPatientsDuJour();
    }

    public Patient patientExiste(String nom, String prenom, String numSecuriteSociale) {
        return patientService.patientExiste(nom, prenom, numSecuriteSociale);
    }

    public void ajouterSigneVital(Patient patient, SigneVital signeVital) {
        signeVitalService.ajouterSigneVital(patient, signeVital);
    }


//    public List<Object[]> getDerniersSignesVitauxPatientsDuJour() {
//        return patientService.getDerniersSignesVitauxPatientsDuJour();
//    }
}
