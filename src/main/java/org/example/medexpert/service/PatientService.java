package org.example.medexpert.service;

import org.example.medexpert.dao.PatientDAO;
import org.example.medexpert.model.Patient;

import java.util.List;

public class PatientService {
    private final PatientDAO patientDAO = new PatientDAO();

    public void creerPatient(Patient patient) {
        patientDAO.create(patient);
    }

    public Patient trouverParId(Long id) {
        return patientDAO.findById(id);
    }

    public List<Patient> listerPatients() {
        return patientDAO.findAll();
    }

    public void mettreAJourPatient(Patient patient) {
        patientDAO.update(patient);
    }

    public void supprimerPatient(Long id) {
        patientDAO.delete(id);
    }

    public List<Patient> getPatientsDuJour() {
        return patientDAO.findPatientsDuJour();
    }

//    public List<Object[]> getDerniersSignesVitauxPatientsDuJour() {
//        return patientDAO.findDerniersSignesVitauxPatientsDuJour();
//    }
}
