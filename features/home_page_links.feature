Feature: All users should have access to the about page
In order to provide information to all visitors 
As a visitor on the home page
I want to be able to view the about page

  Scenario: I wants to view the about page and is not signed in
  Given I am not signed in
  When I visit the website
  Then I should see the about link