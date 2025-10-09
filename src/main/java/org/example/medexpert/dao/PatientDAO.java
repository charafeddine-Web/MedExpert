package org.example.medexpert.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import org.example.medexpert.model.Patient;

import java.util.List;

public class PatientDAO {
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("default");

    public void create(Patient patient) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(patient);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public Patient findById(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Patient.class, id);
        } finally {
            em.close();
        }
    }

    public List<Patient> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Patient> query = em.createQuery("SELECT p FROM Patient p", Patient.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void update(Patient patient) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(patient);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Patient patient = em.find(Patient.class, id);
            if (patient != null) {
                em.remove(patient);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
}
