package org.example.medexpert.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import org.example.medexpert.model.Utilisateur;
import org.example.medexpert.util.JpaUtil;

import java.util.List;

public class UtilisateurDAO {

    private final EntityManager em = JpaUtil.getEntityManager();


    public void save(Utilisateur utilisateur){
        EntityTransaction tx= em.getTransaction();
        try{
            tx.begin();
            em.persist(utilisateur);
            tx.commit();
        }catch (Exception e){
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        }
    }


    public Utilisateur findById( long id){
        return em.find(Utilisateur.class,id);
    }

    public List<Utilisateur> findAll(){
        return em.createQuery("from Utilisateur ",Utilisateur.class).getResultList();
    }


    public void update(Utilisateur utilisateur){
        EntityTransaction tx= em.getTransaction();
        try{
            tx.begin();
            em.merge(utilisateur);
            tx.commit();
        }catch (Exception e){
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        }
    }

    public void delete(Long id) {
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Utilisateur utilisateur = em.find(Utilisateur.class, id);
            if (utilisateur != null) {
                em.remove(utilisateur);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        }
    }

    public Utilisateur findByEmail(String email) {
        try {
            return em.createQuery("SELECT u FROM Utilisateur u WHERE u.email = :email", Utilisateur.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }

}
