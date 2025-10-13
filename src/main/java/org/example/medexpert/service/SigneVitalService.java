package org.example.medexpert.service;

import org.example.medexpert.dao.SigneVitalDAO;
import org.example.medexpert.model.Patient;
import org.example.medexpert.model.SigneVital;

public class SigneVitalService {

    private final SigneVitalDAO signeVitalDAO = new SigneVitalDAO();

    public void ajouterSigneVital(Patient patient, SigneVital signeVital) {
        signeVitalDAO.create(patient, signeVital);
    }

}
