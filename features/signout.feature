Feature: Users are able to sign in and out
  In order to allows users to begin and end their session
  As a user
  I want to be able to login and logout

  Scenario: User decides to sign out
  Given I am logged in with a standard account
  When I log out
  Then I should see 'Signed out successfully.'

  Scenario: User decides to sign in
  Given I am not signed in
  When I sign in
  Then I should see 'Signed in successfully.'

  Scenario: User decides to sign out
  Given I am logged in with a standard account
  When I log out
  Then I should see 'Signed out successfully.'

  Scenario: User decides to sign out
  Given I am logged in with a standard account
  When I log out
  Then I should be redirected to the home page