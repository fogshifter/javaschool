package com.tmobile.dto;

import org.junit.Test;
import pl.pojo.tester.api.assertion.Method;

import static pl.pojo.tester.api.assertion.Assertions.assertPojoMethodsFor;

public class CustomerDTOTest {

    @Test
    public void testPojo() {
        final Class<?> classUnderTest = CustomerDTO.class;
        assertPojoMethodsFor(classUnderTest).testing(Method.GETTER, Method.SETTER)
                .testing(Method.EQUALS)
                .testing(Method.HASH_CODE)
                .testing(Method.CONSTRUCTOR)
                .areWellImplemented();
    }
}
