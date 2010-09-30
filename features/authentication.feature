Feature: Authentication
    In order to use the Image-A-Day site
    As a user
    I want to log in and out
  
    Scenario: Log In
        Given I have a user "stu@mailinator.com" with nickname "Stu" and password "dnib729"
        When  I go to the home page
        Then  I should see "Log in"
        When  I fill in "Email" with "stu@mailinator.com"
        And   I fill in "Password" with "dnib729"
        And   I press "Sign in"
        Then  I should be on the home page
        And   I should see "Signed in as Stu" within "header"
