Feature: Image Comments
    In order to use the comments on images
    As a user
    I want to view, create, and modify comments for an image
  
    Background:
        Given I am logged in

    Scenario: Comments list
        Given "Image 1" is an image with the description "Behold Image 1"
        Given there is a comment with the image "Image 1" and the text "Image 1 is awesome"
        When  I go to the home page
        Then  I should see "Behold Image 1"
        And   I should see "Image 1 is awesome"
