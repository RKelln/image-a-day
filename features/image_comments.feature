Feature: Image Comments
    In order to use the comments on images
    As a user
    I want to view, create, and modify comments for an image
  
    Background:
        Given I am logged in

    Scenario: Comments list
        Given there is an image
        Given there is a comment with the image above and the text "this image is awesome"
        When  I go to the home page
        Then  I should see "this image is awesome"

    Scenario: Add a comment
        Given there is an image
        When  I go to the home page
        When  I fill in "Add a comment:" with "This is my comment" within "#gallery"
        And   I press "Add Comment" within "#gallery"
        Then  I should see "This is my comment" within "#gallery .comment"

    @javascript
    Scenario: Add a comment
        Given there is an image
        When  I go to the home page
        When  I fill in "Add a comment:" with "This is my comment" within "#gallery"
        And   I press "Add Comment" within "#gallery"
        Then  I should see "This is my comment" within "#gallery .comment"

    Scenario: Modify a comment
        Given there is an image
        And   I have a comment with the image above and the text "Modify me"
        When  I go to the home page
        And   I follow "Edit" within "#gallery .comment"
        And   I fill in "Edit your comment:" with "Modified" within "form[id^='comment_form_edit_comment_']"
        And   I press "Edit Comment" within "form[id^='comment_form_edit_comment_']"
        Then  I should not see "Modify me" within "#gallery .comment"
        And   I should see "Modified" within "#gallery .comment"
        
    @javascript
    Scenario: Modify a comment
        Given there is an image
        And   I have a comment with the image above and the text "Modify me"
        When  I go to the home page
        And   I follow "Edit" within "#gallery .comment"
        And   I fill in "Edit your comment:" with "Modified" within "#gallery"
        And   I press "Edit Comment" within "#gallery"
        Then  I should not see "Modify me" within "#gallery .comment"
        And   I should see "Modified" within "#gallery .comment"
        
    Scenario: Delete a comment
        Given there is an image
        Given I have a comment with the image above and the text "Delete me"
        When  I go to the home page
        And   I follow "Delete" within "#gallery .comment"
        Then  I should not see "Delete me" within "#gallery"
    
    @javascript
    Scenario: Delete a comment
        Given there is an image
        Given I have a comment with the image above and the text "Delete me"
        When  I go to the home page
        Given I will confirm all javascript dialogs on this page
        And   I follow "Delete" within "#gallery .comment"
        Then  I should not see "Delete me" within "#gallery"
