package org.example.medexpert.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.example.medexpert.model.SigneVital;
import org.example.medexpert.util.JpaUtil;
import java.util.List;

public class SigneVitalDAO {
    EntityManager em = JpaUtil.getEntityManager();

    public void create(SigneVital signeVital) {
        try {
            em.getTransaction().begin();
            em.persist(signeVital);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public SigneVital findById(Long id) {
        try {
            return em.find(SigneVital.class, id);
        } finally {
            em.close();
        }
    }

    public List<SigneVital> findAll() {
        try {
            TypedQuery<SigneVital> query = em.createQuery("SELECT s FROM SigneVital s", SigneVital.class);
            return query.getResultList();
        } finally {
            em.close();
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
        } finally {
            em.close();
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
        } finally {
            em.close();
        }
    }
}
