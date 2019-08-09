package qwa.dao;

import javax.persistence.EntityManager;
import javax.persistence.Persistence;
import java.util.List;

public abstract class AbstractDao {

    public static long count(Class c) {

        var em = createEntityManager();

        var q = em.createQuery("SELECT count(x) FROM " + c.getSimpleName() + " x");
        var ret = (long) q.getSingleResult();

        em.close();
        return ret;
    }

    public static Object get(Class c, int id) {

        var em = createEntityManager();

        var q = em.createQuery("SELECT x FROM " + c.getSimpleName() + " x WHERE x.id = :id").setParameter("id", id);
        var ret = q.getSingleResult();

        em.close();
        return ret;
    }

    public static List<Object> get(Class c, int n, int offset) {

        var em = createEntityManager();

        var q = em.createQuery("SELECT x FROM " + c.getSimpleName() + " x").setMaxResults(n).setFirstResult(offset);
        var ret = (List<Object>) q.getResultList();

        em.close();
        return ret;
    }

    public static void save(Object o) {

        var em = createEntityManager();

        em.getTransaction().begin();
        em.persist(o);
        em.getTransaction().commit();

        em.close();
    }

    public static void update(Object o) {

        var em = createEntityManager();

        em.getTransaction().begin();
        em.merge(o);
        em.getTransaction().commit();

        em.close();
    }

    public static void delete(Object o) {

        var em = createEntityManager();

        em.getTransaction().begin();
        em.remove(o);
        em.getTransaction().commit();

        em.close();
    }

    private static EntityManager createEntityManager() {
        var emf = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT);
        return emf.createEntityManager();
    }

    private static final String PERSISTENCE_UNIT = "qwa";
}
