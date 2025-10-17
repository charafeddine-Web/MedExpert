package org.example.medexpert.service;

import org.example.medexpert.dao.DossierMedicalDAO;
import org.example.medexpert.dao.PatientDAO;
import org.example.medexpert.model.DossierMedical;
import org.example.medexpert.model.Patient;
import org.example.medexpert.model.SigneVital;

import java.time.LocalDateTime;
import java.util.List;

public class PatientService {
    private final PatientDAO patientDAO = new PatientDAO();
    private final DossierMedicalDAO dossierMedicalDAO = new DossierMedicalDAO();


    public void createPatient(Patient patient) {
        patientDAO.create(patient);
        
        DossierMedical dossier = new DossierMedical();
        dossier.setPatient(patient);
        dossier.setDateCreation(LocalDateTime.now());
        dossierMedicalDAO.create(dossier);
        
    }

    public Patient getPatientById(Long id) {
        return patientDAO.findById(id);
    }

    public List<Patient> listerPatients() {
        return patientDAO.findAll();
    }

    public void mettreAJourPatient(Patient patient) {
        patientDAO.update(patient);
    }

    public void updatePatient(Patient patient) {
        patientDAO.update(patient);
    }

    public void supprimerPatient(Long id) {
        patientDAO.delete(id);
    }

    public List<Patient> getPatientsDuJour() {
        return patientDAO.findPatientsDuJour();
    }

    public Patient patientExiste(String nom, String prenom, String numSecuriteSociale){
        return patientDAO.findByNomPrenomOuNumero(nom,prenom,numSecuriteSociale);
    }


//    public List<Object[]> getDerniersSignesVitauxPatientsDuJour() {
//        return patientDAO.findDerniersSignesVitauxPatientsDuJour();
//    }
}
