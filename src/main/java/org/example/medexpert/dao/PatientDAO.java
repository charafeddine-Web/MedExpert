package org.example.medexpert.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.example.medexpert.model.Patient;
import org.example.medexpert.util.JpaUtil;

import java.util.List;

public class PatientDAO {
    public void create(Patient patient) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(patient);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Patient findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Patient.class, id);
        } finally {
            em.close();
        }
    }

    public List<Patient> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Patient> query = em.createQuery("SELECT p FROM Patient p", Patient.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void update(Patient patient) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(patient);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
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
        } finally {
            em.close();
        }
    }

    public List<Patient> findPatientsDuJour() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Patient> query = em.createQuery(
                "SELECT DISTINCT c.dossier.patient FROM Consultation c WHERE DATE(c.dateConsultation) = CURRENT_DATE",
                Patient.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }

//    public List<Object[]> findDerniersSignesVitauxPatientsDuJour() {
//        EntityManager em = JpaUtil.getEntityManager();
//        try {
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
