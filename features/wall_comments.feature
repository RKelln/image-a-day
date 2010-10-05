Feature: Wall Comments
    In order to use the wall of comments
    As a user
    I want to view, create, and modify comments on the wall
  
    Background:
        Given I am logged in

    Scenario: Comments list
        Given there is a comment with the text "Hello"
        Given there is a comment with the text "I love you"
        When  I go to the home page
        Then  I should see "Hello" within "#wall .comment"
        And   I should see "I love you" within "#wall .comment"

    Scenario: Add a comment
        When  I go to the home page
        When  I fill in "Add a comment:" with "This is my comment"
        And   I press "Add Comment" within "#wall"
        Then  I should see "This is my comment" within "#wall .comment"

    @javascript
    Scenario: Add a comment using AJAX
        When  I go to the home page
        When  I fill in "Add a comment:" with "This is my comment"
        And   I press "Add Comment" within "#wall"
        Then  I should see "This is my comment" within "#wall .comment"
