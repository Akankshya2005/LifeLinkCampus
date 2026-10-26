package util;



import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JpaTest {

    public static void main(String[] args) {

        EntityManagerFactory emf = null;

        try {
            emf = Persistence.createEntityManagerFactory("LifeLinkPU");

            System.out.println(
                    "LifeLink Campus JPA initialized successfully!"
            );

        } catch (Exception e) {
            System.out.println("JPA initialization failed!");
            e.printStackTrace();

        } finally {
            if (emf != null) {
                emf.close();
            }
        }
    }
}
