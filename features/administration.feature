Feature: Administration
    In order to administer Image-A-Day users
    As an admin
    I want to view, create, and modify users and their attributes
  
    Background:
        Given I am logged in as an admin

    Scenario: Users list
        Given there is a user with the email "stu@mailinator.com" and the nickname "Stu"
        And   there is a user with the email "ryan@mailinator.com" and the nickname "Ryan"
        When  I go to the admin page
        Then  some "user_email" field within "#content .users" should contain "stu@mailinator.com"
        And   some "user_email" field within "#content .users" should contain "ryan@mailinator.com"
        And   some "user_nickname" field within "#content .users" should contain "Stu"
        And   some "user_nickname" field within "#content .users" should contain "Ryan"

    Scenario: Add a user
        When  I go to the admin page
        And   I fill in "user_name" with "First Last" within "#new_user .create_user"
        And   I fill in "user_nickname" with "Nick" within "#new_user .create_user"
        And   I fill in "user_email" with "nick@email.com" within "#new_user .create_user"
        And   I press "Create" within "#new_user .create_user"
        Then  some "user_name" field within "#content .users" should contain "First Last"
        And   some "user_nickname" field within "#content .users" should contain "Nick"
        And   some "user_email" field within "#content .users" should contain "nick@email.com"

    @javascript
    Scenario: Add a user
        When  I go to the admin page
        And   I fill in "user_name" with "First Last" within "#new_user .create_user"
        And   I fill in "user_nickname" with "Nick" within "#new_user .create_user"
        And   I fill in "user_email" with "nick@email.com" within "#new_user .create_user"
        And   I press "Create" within "#new_user .create_user"
        Then  some "user_name" field within "#content .users" should contain "First Last"
        And   some "user_nickname" field within "#content .users" should contain "Nick"
        And   some "user_email" field within "#content .users" should contain "nick@email.com"
