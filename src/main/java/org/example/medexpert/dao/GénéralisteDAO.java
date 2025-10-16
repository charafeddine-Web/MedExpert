package org.example.medexpert.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.example.medexpert.model.Généraliste;
import org.example.medexpert.util.JpaUtil;
import java.util.List;

public class GénéralisteDAO {

    public void create(Généraliste generaliste) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(generaliste);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Généraliste findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Généraliste.class, id);
        } finally {
            em.close();
        }
    }

    public List<Généraliste> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Généraliste> query = em.createQuery("SELECT g FROM Généraliste g", Généraliste.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Généraliste findByEmail(String email) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Généraliste> query = em.createQuery(
                    "SELECT g FROM Généraliste g WHERE g.email = :email", Généraliste.class);
            query.setParameter("email", email);
            List<Généraliste> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }

    public void update(Généraliste generaliste) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(generaliste);
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
            Généraliste generaliste = em.find(Généraliste.class, id);
            if (generaliste != null) {
                em.remove(generaliste);
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
