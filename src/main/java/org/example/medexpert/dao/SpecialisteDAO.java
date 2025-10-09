package org.example.medexpert.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import org.example.medexpert.model.Specialiste;
import java.util.List;

public class SpecialisteDAO {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("default");

    public void create(Specialiste specialiste) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(specialiste);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public Specialiste findById(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Specialiste.class, id);
        } finally {
            em.close();
        }
    }

    public List<Specialiste> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Specialiste> query = em.createQuery("SELECT s FROM Specialiste s", Specialiste.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void update(Specialiste specialiste) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(specialiste);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Specialiste specialiste = em.find(Specialiste.class, id);
            if (specialiste != null) {
                em.remove(specialiste);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
}
