Feature: Week Page
    In order to view images by week
    As a user
    I want to see a weeks worth of images and navigate through time to see more images
  
    Background:
        Given I am logged in

    Scenario: Week list
        Given today is "2010-01-01"
        Given there is a user with the nickname "Stu"
        And   there is a user with the nickname "Ryan"
        When  I go to the week page
        Then  I should see "Stu"
        And   I should see "Ryan"
        And   I should see the date "2010-01-01"
        And   I should see the date "2010-12-26"
        And   I should not see the date "2010-01-02"
        And   I should not see the date "2010-12-25"
        Then  I follow /Prev/
        Then  I should see the date "2010-12-25"
        And   I should see the date "2010-12-19"
        And   I should not see the date "2010-12-26"
        And   I should not see the date "2010-12-18"

    @javascript
    Scenario: Week list
        Given today is "2010-01-01"
        Given there is a user with the nickname "Stu"
        And   there is a user with the nickname "Ryan"
        When  I go to the week page
        Then  I should see "Stu"
        And   I should see "Ryan"
        And   I should see the date "2010-01-01"
        And   I should see the date "2010-12-26"
        And   I should not see the date "2010-01-02"
        And   I should not see the date "2010-12-25"
        Then  I follow /Prev/
        Then  I should see the date "2010-12-25"
        And   I should see the date "2010-12-19"
        And   I should not see the date "2010-12-26"
        And   I should not see the date "2010-12-18"
    