package org.example.medexpert.service;

import org.example.medexpert.model.Patient;
import org.example.medexpert.model.SigneVital;

import java.time.LocalDateTime;
import java.util.List;

public class InfirmierService {
    private final PatientService patientService = new PatientService();
    private final SigneVitalService signeVitalService = new SigneVitalService();


//    public List<Object[]> getDerniersSignesVitauxPatientsDuJour() {
//        return patientService.getDerniersSignesVitauxPatientsDuJour();
//    }
}
