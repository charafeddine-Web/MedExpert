package org.example.medexpert.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.example.medexpert.model.ActeMedical;
import org.example.medexpert.util.JpaUtil;
import java.time.LocalDate;
import java.util.List;

public class ActeMedicalDAO {

    public void create(ActeMedical acte) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(acte);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public ActeMedical findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(ActeMedical.class, id);
        } finally {
            em.close();
        }
    }

    public List<ActeMedical> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<ActeMedical> query = em.createQuery("SELECT a FROM ActeMedical a", ActeMedical.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void update(ActeMedical acte) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(acte);
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
            ActeMedical acte = em.find(ActeMedical.class, id);
            if (acte != null) {
                em.remove(acte);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
    
    public List<ActeMedical> getActesAujourdhui() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            LocalDate aujourdhui = LocalDate.now();
            TypedQuery<ActeMedical> query = em.createQuery(
                "SELECT a FROM ActeMedical a WHERE DATE(a.consultation.dateConsultation) = :aujourdhui", 
                ActeMedical.class);
            query.setParameter("aujourdhui", aujourdhui);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
