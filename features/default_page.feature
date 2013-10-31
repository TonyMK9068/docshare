Feature: Users should be routed to default home page upon visiting
In order to read about DocShare and sign up or log in
As a new or unauthenticated user
I want to be directed to the default home page

  Scenario: The user "bob" is not signed in
  Given user "bob" is not signed in
  When user "bob" visits the website
  Then user "bob" should see the "log in" link
    And user "bob" should see the "sign up" link