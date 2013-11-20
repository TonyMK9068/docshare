Feature: In order to offer incentives for visitors to subscribe
  As a subscriber
  I should have special privileges

  Scenario: Subscriber wants to change page settings for private page
  Given I am logged in with a premium account
    And I have a page that is public
  When I am at the edit page view
  Then I can select Page Settings

  Scenario: Subscriber wants to change page settings for public page
  Given I am logged in with a premium account
    And I have a page that is private
  When I am at the edit page view
  Then I can select Page Settings