package qwa.dao;

import qwa.domain.Editor;

import javax.persistence.NoResultException;

public class EditorDao extends AbstractDao {

    public Editor get(String username) {

        var em = createEntityManager();
        try {

            var q = em.createQuery("SELECT e FROM Editor e WHERE e.username = :username").setParameter("username", username);
            var ret = (Editor) q.getSingleResult();

            return ret;

        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }
}
