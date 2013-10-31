Feature: All users should have access to the about page
In order to provide information to all visitors 
As a visitor on the home page
I want to be able to view the about page

  Scenario: User "bob" wants to view the about page and is not signed in
  Given user "bob" is not signed in
  When user "bob" visits the website
  Then user "bob" should see the "about" link

  Scenario: User "bob" wants to view the about page and is signed in
  Given user "bob" is signed in
  When user "bob" visits the website
  Then user "bob" should see the "about" link