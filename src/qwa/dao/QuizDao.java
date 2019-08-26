package qwa.dao;

import qwa.domain.Quiz;

import java.util.List;

public class QuizDao extends AbstractDao {

    public List<Quiz> search(String query) {

        var em = createEntityManager();

        var q = em.createQuery("SELECT q FROM Quiz q WHERE (q.name LIKE CONCAT('%',:query,'%') OR q.description LIKE CONCAT('%',:query,'%')) and q.active = true ORDER BY q.id DESC").setParameter("query", query);
        var ret = (List<Quiz>) q.getResultList();

        em.close();
        return ret;
    }

    public List<Quiz> get() {

        var em = createEntityManager();

        var q = em.createQuery("SELECT q FROM Quiz q WHERE q.active = true ORDER BY q.id DESC");
        var ret = (List<Quiz>) q.getResultList();

        em.close();
        return ret;
    }

    public List<Quiz> get(String username) {

        var em = createEntityManager();

        var q = em.createQuery("SELECT q FROM Quiz q WHERE q.editor = :username").setParameter("username", username);
        var ret = (List<Quiz>) q.getResultList();

        em.close();
        return ret;
    }
}
