package dao;




import entity.Donor;
import entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;

public class DonorDAO {

    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("LifeLinkPU");

    // Find a donor record using the registered user's ID
    public Donor findByUserId(Integer userId) {

        EntityManager em = emf.createEntityManager();

        try {
            return em.createQuery(
                            "SELECT d FROM Donor d WHERE d.user.userId = :userId",
                            Donor.class
                    )
                    .setParameter("userId", userId)
                    .getResultStream()
                    .findFirst()
                    .orElse(null);

        } finally {
            em.close();
        }
    }

    // Save a new donor registration
    public boolean saveDonor(Donor donor) {

        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();

            User managedUser = em.find(
                    User.class,
                    donor.getUser().getUserId()
            );

            if (managedUser == null) {
                transaction.rollback();
                return false;
            }

            donor.setUser(managedUser);

            em.persist(donor);
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

    // Update an existing donor record
    public boolean updateDonor(Donor donor) {

        EntityManager em = emf.createEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();

            Donor existingDonor = em.find(
                    Donor.class,
                    donor.getDonorId()
            );

            if (existingDonor == null) {
                transaction.rollback();
                return false;
            }

            existingDonor.setBloodGroup(donor.getBloodGroup());
            existingDonor.setPhone(donor.getPhone());
            existingDonor.setCollege(donor.getCollege());
            existingDonor.setAvailabilityStatus(
                    donor.getAvailabilityStatus()
            );
            existingDonor.setConsentToContact(
                    donor.isConsentToContact()
            );

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

