Feature: Month Page
    In order to view images by month
    As a user
    I want to see a months worth of images and navigate through time to see more images
  
    Background:
        Given I am logged in

    Scenario: Month list
        Given today is "2010-01-01"
        Given there is a user with the nickname "Stu"
        And   there is a user with the nickname "Ryan"
        When  I go to the month page
        Then  I should see "Stu"
        And   I should see "Ryan"
        And   I should see the date "2010-01-01"
        And   I should see the date "2010-01-31"
        And   I should see the date "2009-12-28"
        And   I should not see the date "2010-02-01"
        And   I should not see the date "2010-12-27"
        Then  I follow /Prev/
        Then  I should see the date "2009-12-1"
        And   I should see the date "2010-12-31"
        And   I should see the date "2010-01-03"
        And   I should see the date "2009-11-30"
        And   I should not see the date "2010-01-04"
        And   I should not see the date "2010-11-29"

    @javascript
    Scenario: Month list
        Given today is "2010-01-01"
        Given there is a user with the nickname "Stu"
        And   there is a user with the nickname "Ryan"
        When  I go to the month page
        Then  I should see "Stu"
        And   I should see "Ryan"
        And   I should see the date "2010-01-01"
        And   I should see the date "2010-01-31"
        And   I should see the date "2009-12-28"
        And   I should not see the date "2010-02-01"
        And   I should not see the date "2010-12-27"
        Then  I follow /Prev/
        Then  I should see the date "2009-12-1"
        And   I should see the date "2010-12-31"
        And   I should see the date "2010-01-03"
        And   I should see the date "2009-11-30"
        And   I should not see the date "2010-01-04"
        And   I should not see the date "2010-11-29"
