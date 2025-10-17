package org.example.medexpert;


import org.example.medexpert.model.Patient;
import org.example.medexpert.model.SigneVital;
import org.example.medexpert.model.enums.StatutPatient;
import org.example.medexpert.service.PatientService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;

public class PatientTest {

    private PatientService service;

    @BeforeEach
    public void setup() {
        service = new PatientService();
    }

    private Patient createUniquePatient() {
        Patient p = new Patient();
        p.setNom("Nom_");
        p.setPrenom("Prenom_");
        p.setAdresse("Adresse_");
        p.setMutuelle(true);
        p.setNumSecuriteSociale("NS");
        p.setDateArrivee(LocalDateTime.now());
        p.setStatus(StatutPatient.EN_ATTENTE);
        return p;
    }

    private SigneVital createSigneVital() {
        SigneVital s = new SigneVital();
        s.setDateMesure(LocalDateTime.now());
        s.setTension(15.2);
        s.setTemperature(37.0);
        s.setFrequenceCardiaque(70.1);
        s.setFrequenceRespiratoire(16.0);
        s.setPoids(70.0);
        s.setTaille(1.75);
        return s;
    }

    @Test
    public void testAddAndFindById() {
        Patient p = createUniquePatient();
        SigneVital s = createSigneVital();
        service.createPatient(p);

        Patient found = service.getPatientById(p.getId());
        assertNotNull(found);
        assertEquals(p.getNom(), found.getNom());
    }

    @Test
    public void testFindByTodayIncludesAdded() {
        Patient p = createUniquePatient();
        SigneVital s = createSigneVital();
        service.createPatient(p);

        List<Patient> patientsToday = service.getPatientsDuJour();
        boolean found = patientsToday.stream().anyMatch(pt -> pt.getId().equals(p.getId()));
        assertTrue(found);
    }

    @Test
    public void testUpdatePatient() {
        Patient p = createUniquePatient();
        SigneVital s = createSigneVital();
        service.createPatient(p);

        p.setNom("Nom_Modifié");
        service.updatePatient(p);

        Patient updated = service.getPatientById(p.getId());
        assertEquals("Nom_Modifié", updated.getNom());
    }
}