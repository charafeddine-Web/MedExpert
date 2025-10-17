package org.example.medexpert.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.example.medexpert.model.Creneau;
import org.example.medexpert.util.JpaUtil;
import java.util.List;

public class CreneauDAO {

    EntityManager em = JpaUtil.getEntityManager();

    public void create(Creneau creneau) {
        try {
            em.getTransaction().begin();
            em.persist(creneau);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Creneau findById(Long id) {
        try {
            return em.find(Creneau.class, id);
        } finally {
            em.close();
        }
    }

    public List<Creneau> findAll() {
        try {
            TypedQuery<Creneau> query = em.createQuery("SELECT c FROM Creneau c", Creneau.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Creneau> findBySpecialisteId(Long specialisteId) {
        try {
            TypedQuery<Creneau> query = em.createQuery(
                    "SELECT c FROM Creneau c WHERE c.specialiste.id = :sid ORDER BY c.dateDebut",
                    Creneau.class
            );
            query.setParameter("sid", specialisteId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void update(Creneau creneau) {
        try {
            em.getTransaction().begin();
            em.merge(creneau);
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
            Creneau creneau = em.find(Creneau.class, id);
            if (creneau != null) {
                em.remove(creneau);
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
