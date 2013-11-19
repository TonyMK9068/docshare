Feature: Users should be able to sign up using a user name, password, and email
In order to sign up to docshare quickly
As a new user
I want to need only a user name, password, and email

  Scenario: Creating a new account with valid credentials
  Given I am not registered
    And I visit the new user registration page
  When I input valid credentials
  Then I should see instructions to confirm account

  Scenario: Creating a new account without entering username
  Given I am not registered
    And I visit the new user registration page
  When I register without entering a username
  Then I should see a registration error

  Scenario: Creating a new account without entering username
  Given I am not registered
    And I visit the new user registration page
  When I register without entering a password
  Then I should see a registration error
  
  Scenario: Creating a new account without entering username
  Given I am not registered
    And I visit the new user registration page
  When I register without entering a password confirmation
  Then I should see a registration error

  Scenario: Creating a new account without entering username
  Given I am not registered
    And I visit the new user registration page
  When I register without entering an email
  Then I should see a registration error

  Scenario: Creating a new account without password and password confirmation matching
  Given I am not registered
    And I visit the new user registration page
  When I register with different password password_confirmation values
  Then I should see a registration error