package org.example.medexpert.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.example.medexpert.model.Patient;
import org.example.medexpert.model.SigneVital;
import org.example.medexpert.util.JpaUtil;
import java.util.List;

public class SigneVitalDAO {
    EntityManager em = JpaUtil.getEntityManager();


    public void create(Patient patient, SigneVital signeVital) {
        try {
            em.getTransaction().begin();
            Patient attachedPatient = em.find(Patient.class, patient.getId());
            signeVital.setPatient(attachedPatient);
            em.persist(signeVital);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        }
    }

    public SigneVital findById(Long id) {
        try {
            return em.find(SigneVital.class, id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<SigneVital> findAll() {
        try {
            TypedQuery<SigneVital> query = em.createQuery("SELECT s FROM SigneVital s", SigneVital.class);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void update(SigneVital signeVital) {
        try {
            em.getTransaction().begin();
            em.merge(signeVital);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        }
    }

    public void delete(Long id) {
        try {
            em.getTransaction().begin();
            SigneVital signeVital = em.find(SigneVital.class, id);
            if (signeVital != null) {
                em.remove(signeVital);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        }
    }
}
