package com.boiechko.service.implementations;

import com.boiechko.dao.implementations.PersonDaoImpl;
import com.boiechko.dao.interfaces.PersonDao;
import com.boiechko.entity.Person;
import com.boiechko.enums.PersonType;
import com.boiechko.service.interfaces.PersonService;

import java.util.List;

public class PersonServiceImpl implements PersonService {

    private final PersonDao personDao = new PersonDaoImpl();

    @Override
    public Person getPersonByColumn(final String column, final String credentials) { return personDao.getPersonByColumn(column, credentials); }

    @Override
    public boolean addPerson(final Person person) { return personDao.add(person); }

    @Override
    public Person getPersonById(final int idPerson) { return personDao.getById(idPerson); }

    @Override
    public List<Person> getAllPersons() { return personDao.getAll(); }

    @Override
    public boolean updatePerson(final Person person) { return personDao.update(person); }

    @Override
    public boolean deletePerson(final int id) { return personDao.delete(id); }

    @Override
    public boolean isPersonAdmin(final Person person) { return person != null && person.getPersonType().equals(PersonType.ADMIN); }
}
