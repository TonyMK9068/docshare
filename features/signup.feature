Feature: Users should be able to sign up using a user name, password, and email
In order to sign up to docshare quickly
As a new user
I want to need only a user name, password, and email

  Scenario: Creating a new account
  Given I am not registered
  When I register with valid credentials
  Then I should see instructions to confirm account