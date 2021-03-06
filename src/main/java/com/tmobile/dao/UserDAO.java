package com.tmobile.dao;

import javax.persistence.Query;

import com.tmobile.exception.EntryNotFoundException;
import org.springframework.stereotype.Repository;
import com.tmobile.entity.User;

import java.util.List;


@Repository
public class UserDAO extends GenericDAO<User> {

    public User findByEmail(String email) {
        Query selQ = entityManager.createQuery("select c from User c where c.email=:email");
        selQ.setParameter("email", email);

        List<User> users = selQ.getResultList();

        if (users.isEmpty()) {
            return null;
        }

        return users.get(0);
    }

    public List<User> getAllCustomers() {
        return entityManager.createQuery("select c from User c where c.role='ROLE_CUSTOMER'").getResultList();
    }

    public int findId(User user) throws EntryNotFoundException {
        Query selQ = entityManager.createQuery("select u from User u where u.email=:email and u.firstName=:firstName and u.lastName=:lastName and u.birthDate=:birthDate and u.address=:address and u.passportData=:passportData");

        selQ.setParameter("email", user.getEmail());
        selQ.setParameter("firstName", user.getFirstName());
        selQ.setParameter("address", user.getAddress());
        selQ.setParameter("birthDate", user.getBirthDate());
        selQ.setParameter("lastName", user.getLastName());
        selQ.setParameter("passportData", user.getPassportData());

        List<User> results = selQ.getResultList();

        if (results.isEmpty()) {
//            return 0;
            throw new EntryNotFoundException("User not found");
        }

        return results.get(0).getId();
    }
}
 