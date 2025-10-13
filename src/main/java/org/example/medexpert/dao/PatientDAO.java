package org.example.medexpert.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.example.medexpert.model.Patient;
import org.example.medexpert.model.SigneVital;
import org.example.medexpert.util.JpaUtil;

import java.util.List;

public class PatientDAO {
    EntityManager em = JpaUtil.getEntityManager();

    public void create(Patient patient) {
        try {
            em.getTransaction().begin();
            em.persist(patient);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        }
    }

    public Patient findById(Long id) {
        try {
            return em.find(Patient.class, id);
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public List<Patient> findAll() {
        try {
            TypedQuery<Patient> query = em.createQuery("SELECT p FROM Patient p", Patient.class);
            return query.getResultList();
        } catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public void update(Patient patient) {
        try {
            em.getTransaction().begin();
            em.merge(patient);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        }
    }

    public void delete(Long id) {
        try {
            em.getTransaction().begin();
            Patient patient = em.find(Patient.class, id);
            if (patient != null) {
                em.remove(patient);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        }
    }

    public List<Patient> findPatientsDuJour() {
        try {
            TypedQuery<Patient> query = em.createQuery(
                "SELECT DISTINCT c.dossier.patient FROM Consultation c WHERE DATE(c.dateConsultation) = CURRENT_DATE",
                Patient.class
            );
            return query.getResultList();
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public Patient findByNomPrenomOuNumero(String nom, String prenom, String numSecuriteSociale) {
        try {
            TypedQuery<Patient> query = em.createQuery(
                    "SELECT p FROM Patient p WHERE p.nom = :nom OR p.prenom = :prenom OR p.numSecuriteSociale = :num",
                    Patient.class
            );
            query.setParameter("nom", nom);
            query.setParameter("prenom", prenom);
            query.setParameter("num", numSecuriteSociale);

            List<Patient> results = query.getResultList();

            return results.isEmpty() ? null : results.get(0);

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }



//    public List<Object[]> findDerniersSignesVitauxPatientsDuJour() {
////        try {
//            TypedQuery<Object[]> query = em.createQuery(
//                "SELECT p, sv FROM Consultation c JOIN c.dossier.patient p JOIN p.signesVitaux sv " +
//                "WHERE DATE(c.dateConsultation) = CURRENT_DATE AND sv.datePrise = (SELECT MAX(sv2.datePrise) FROM SigneVital sv2 WHERE sv2.patient = p)",
//                Object[].class
//            );
//            return query.getResultList();
//        } finally {
//            em.close();
//        }
//    }
}
