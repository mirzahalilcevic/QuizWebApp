package qwa.dao;

import qwa.domain.Player;

import javax.persistence.NoResultException;

public class PlayerDao extends AbstractDao {

    public Player get(String email) {

        var em = createEntityManager();
        try {

            var q = em.createQuery("SELECT p FROM Player p WHERE p.email = :email").setParameter("email", email);
            var ret = (Player) q.getSingleResult();

            return ret;

        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }
}
