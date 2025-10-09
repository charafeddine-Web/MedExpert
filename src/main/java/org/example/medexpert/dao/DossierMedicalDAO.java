package org.example.medexpert.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.example.medexpert.model.DossierMedical;
import org.example.medexpert.util.JpaUtil;
import java.util.List;

public class DossierMedicalDAO {
    EntityManager em = JpaUtil.getEntityManager();

    public void create(DossierMedical dossier) {
        try {
            em.getTransaction().begin();
            em.persist(dossier);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public DossierMedical findById(Long id) {
        try {
            return em.find(DossierMedical.class, id);
        } finally {
            em.close();
        }
    }

    public List<DossierMedical> findAll() {
        try {
            TypedQuery<DossierMedical> query = em.createQuery("SELECT d FROM DossierMedical d", DossierMedical.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void update(DossierMedical dossier) {
        try {
            em.getTransaction().begin();
            em.merge(dossier);
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
            DossierMedical dossier = em.find(DossierMedical.class, id);
            if (dossier != null) {
                em.remove(dossier);
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
