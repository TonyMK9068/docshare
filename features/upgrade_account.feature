Feature: In order to generate revenue
  As a user
  I should have to pay to create private pages

  Scenario: User upgrades account
  Given I am logged in
  When I upgrade to a premium account
  Then I can create private pages