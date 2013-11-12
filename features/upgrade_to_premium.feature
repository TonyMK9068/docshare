Feature: In order to access premium features
  As a user
  I should be able to upgrade to a premium account

  Scenario: User decides to upgrade account
  Given I do not have a premium account
  And I am logged in
  When I purchase a premium account
  Then I should have access to premium features