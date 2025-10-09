package org.example.medexpert.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.example.medexpert.model.Specialiste;
import org.example.medexpert.util.JpaUtil;
import java.util.List;

public class SpecialisteDAO {
    EntityManager em = JpaUtil.getEntityManager();

    public void create(Specialiste specialiste) {
        try {
            em.getTransaction().begin();
            em.persist(specialiste);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Specialiste findById(Long id) {
        try {
            return em.find(Specialiste.class, id);
        } finally {
            em.close();
        }
    }

    public List<Specialiste> findAll() {
        try {
            TypedQuery<Specialiste> query = em.createQuery("SELECT s FROM Specialiste s", Specialiste.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void update(Specialiste specialiste) {
        try {
            em.getTransaction().begin();
            em.merge(specialiste);
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
            Specialiste specialiste = em.find(Specialiste.class, id);
            if (specialiste != null) {
                em.remove(specialiste);
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
