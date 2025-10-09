package org.example.medexpert.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.example.medexpert.model.Infirmier;
import org.example.medexpert.util.JpaUtil;

import java.util.List;

public class InfirmierDAO {

    EntityManager em = JpaUtil.getEntityManager();

    public void create(Infirmier infirmier) {
        try {
            em.getTransaction().begin();
            em.persist(infirmier);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Infirmier findById(Long id) {
        try {
            return em.find(Infirmier.class, id);
        } finally {
            em.close();
        }
    }

    public List<Infirmier> findAll() {
        try {
            TypedQuery<Infirmier> query = em.createQuery("SELECT i FROM Infirmier i", Infirmier.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void update(Infirmier infirmier) {
        try {
            em.getTransaction().begin();
            em.merge(infirmier);
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
            Infirmier infirmier = em.find(Infirmier.class, id);
            if (infirmier != null) {
                em.remove(infirmier);
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
