package org.example.medexpert.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.example.medexpert.model.Creneau;
import org.example.medexpert.util.JpaUtil;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public class CreneauDAO {

    public void create(Creneau creneau) {
        EntityManager em = JpaUtil.getEntityManager();
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
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Creneau.class, id);
        } finally {
            em.close();
        }
    }

    public List<Creneau> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Creneau> query = em.createQuery("SELECT c FROM Creneau c", Creneau.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Creneau> findAllAjourBySpecialiste(Long idSpecialiste) {
        EntityManager em = JpaUtil.getEntityManager();
        LocalDate aujourdhui = LocalDate.now();
        LocalDateTime debutJour = aujourdhui.atStartOfDay();
        LocalDateTime finJour = aujourdhui.plusDays(1).atStartOfDay();

        try {
            TypedQuery<Creneau> query = em.createQuery(
                    "SELECT c FROM Creneau c WHERE c.dateDebut >= :debutJour AND c.dateDebut < :finJour AND c.specialiste.id = :idSpecialiste AND c.disponible = true",
                    Creneau.class
            );
            query.setParameter("debutJour", debutJour);
            query.setParameter("finJour", finJour);
            query.setParameter("idSpecialiste", idSpecialiste);

            return query.getResultList();
        } finally {
            em.close();
        }
    }


    public void update(Creneau creneau) {
        EntityManager em = JpaUtil.getEntityManager();
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
        EntityManager em = JpaUtil.getEntityManager();
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
