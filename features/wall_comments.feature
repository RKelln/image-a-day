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
        When  I fill in "Add a comment:" with "This is my comment" within "#wall"
        And   I press "Add Comment" within "#wall"
        Then  I should see "This is my comment" within "#wall .comment"

    @javascript
    Scenario: Add a comment
        When  I go to the home page
        When  I fill in "Add a comment:" with "This is my comment" within "#wall"
        And   I press "Add Comment" within "#wall"
        Then  I should see "This is my comment" within "#wall .comment"

    Scenario: Modify a comment
        Given I have a comment with the text "Modify me"
        When  I go to the home page
        And   I follow "Edit" within "#wall .comment"
        And   I fill in "Edit your comment:" with "Modified"
        And   I press "Edit Comment"
        Then  I should not see "Modify me" within "#wall .comment"
        And   I should see "Modified" within "#wall .comment"
        
    @javascript
    Scenario: Modify a comment
        Given I have a comment with the text "Modify me"
        When  I go to the home page
        And   I follow "Edit" within "#wall .comment"
        And   I fill in "Edit your comment:" with "Modified" within "#wall"
        And   I press "Edit Comment" within "#wall"
        Then  I should not see "Modify me" within "#wall .comment"
        And   I should see "Modified" within "#wall .comment"
        
    Scenario: Delete a comment
        Given I have a comment with the text "Delete me"
        When  I go to the home page
        And   I follow "Delete" within "#wall .comment"
        Then  I should not see "Delete me" within "#wall"
    
    @javascript
    Scenario: Delete a comment
        Given I have a comment with the text "Delete me"
        When  I go to the home page
        Given I will confirm all javascript dialogs on this page
        And   I follow "Delete" within "#wall .comment"
        Then  I should not see "Delete me" within "#wall"
        