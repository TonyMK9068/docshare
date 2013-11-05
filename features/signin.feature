Feature: To reduce unnecessary user interaction
  In order to provide registered users with only desired pages
  As a user
  I want to be redirected to my personal index after signing in

  Scenario: User logs in
  Given I am not signed in
  When I sign in
  Then I should be redirected to my page index
