Feature: Users should be able to sign up using a user name, password, and email
In order to sign up to docshare quickly
As a new user
I want to need only a user name, password, and email

  Scenario Outline: Creating a new account
  Given I am not authenticated
  When I go to register
  And I fill in "user_email" with "<email>"
  And I fill in "user_password" with "<password>"
  And I fill in "user_password_confirmation" with "<password>"
  And I press "Sign up"
  Then I should see "logged in as <email>"

      Examples:
      | email            | password   |
      | test@example.com | hellowrold |
      | foo@bar.com      | testpass   |