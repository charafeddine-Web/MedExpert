package org.example.medexpert.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.example.medexpert.model.Consultation;
import org.example.medexpert.util.JpaUtil;
import java.time.LocalDate;
import java.util.List;

public class ConsultationDAO {

    public void create(Consultation consultation) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(consultation);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public Consultation findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Consultation.class, id);
        } finally {
            em.close();
        }
    }

    public List<Consultation> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Consultation> query = em.createQuery("SELECT c FROM Consultation c", Consultation.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void update(Consultation consultation) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(consultation);
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
            Consultation consultation = em.find(Consultation.class, id);
            if (consultation != null) {
                em.remove(consultation);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
    
    public List<Consultation> getConsultationsAujourdhui() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            LocalDate aujourdhui = LocalDate.now();
            TypedQuery<Consultation> query = em.createQuery(
                "SELECT c FROM Consultation c WHERE DATE(c.dateConsultation) = :aujourdhui", 
                Consultation.class);
            query.setParameter("aujourdhui", aujourdhui);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
