Feature: In order to offer incentives for visitors to subscribe
  As a subscriber
  I should have special privileges

  Scenario: User sets page to private
  Given I am logged in with a premium account
    And I have a page that is public
  When I edit the page
  Then I can set it to private

  Scenario: User sets page to public
  Given I am logged in with a premium account
    And I have a page that is private
  When I edit the page
  Then I can set it to public

  Scenario: User adds collaborators
  Given I am logged in with a premium account
    And I have a page that is private
  When I edit the page
  Then I can add collaborators

  Scenario: User adds collaborators
  Given I am logged in with a premium account
    And I have a page that is public
  When I edit the page
  Then I can add collaborators

  Scenario: User authorizes others to view private page
  Given I am logged in with a premium account
    And I have a page that is private
  When I edit the page
  Then I can authorize users that may view it