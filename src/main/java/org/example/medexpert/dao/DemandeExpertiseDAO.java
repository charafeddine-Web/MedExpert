package org.example.medexpert.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.example.medexpert.model.DemandeExpertise;
import org.example.medexpert.util.JpaUtil;
import java.util.List;

public class DemandeExpertiseDAO {

    public void create(DemandeExpertise demande) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(demande);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public DemandeExpertise findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(DemandeExpertise.class, id);
        } finally {
            em.close();
        }
    }

    public List<DemandeExpertise> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<DemandeExpertise> query = em.createQuery("SELECT d FROM DemandeExpertise d", DemandeExpertise.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void update(DemandeExpertise demande) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(demande);
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
            DemandeExpertise demande = em.find(DemandeExpertise.class, id);
            if (demande != null) {
                em.remove(demande);
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
