Feature: Users should be routed to default home page upon visiting
In order to read about DocShare and sign up or log in
As a new or unauthenticated user
I want to be directed to the default home page

  Scenario: Visiting home page not signed in
  Given I am not signed in
  When I visit the website
  Then I should see the sign up link
    And I should see the sign in link