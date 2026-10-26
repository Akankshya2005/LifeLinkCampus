
package dao;

import entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;

public class UserDAO {

    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("LifeLinkPU");

    // Save a new user
    public boolean saveUser(User user) {

        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();
            em.persist(user);
            transaction.commit();
            return true;

        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
            return false;

        } finally {
            em.close();
        }
    }

    // Find a user by email
    public User findByEmail(String email) {

        EntityManager em = emf.createEntityManager();

        try {
            return em.createQuery(
                            "SELECT u FROM User u WHERE u.email = :email",
                            User.class)
                    .setParameter("email", email)
                    .getResultStream()
                    .findFirst()
                    .orElse(null);

        } finally {
            em.close();
        }
    }



    public User findById(int userId) {
        EntityManager em = emf.createEntityManager();

        try {
            return em.find(User.class, userId);
        } finally {
            em.close();
        }
    }

    public boolean updateUser(User user) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();
            em.merge(user);
            transaction.commit();
            return true;

        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }

            e.printStackTrace();
            return false;

        } finally {
            em.close();
        }
    }

}
