Feature: Users should be able to sign up using a user name, password, and email
In order to sign up to docshare quickly
As a new user
I want to need only a user name, password, and email

  Scenario: Creating a new account
  Given I am not signed in
  When I go to register
    And I fill in Email with 'text@example.com'
    And I fill in Username with 'textwiki'
    And I fill in Password with 'helloworld'
    And I fill in Password confirmation with "helloworld"
    And I press 'Sign up'
  Then I should see 'A message with a confirmation link...'