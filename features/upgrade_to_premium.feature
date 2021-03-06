Feature: In order to access premium features
  As a user
  I should be able to upgrade to a premium account

  Scenario: User decides to upgrade account  
  Given I am logged in with a standard account
  When I upgrade to a premium account
  Then I should have access to premium features
