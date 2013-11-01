Feature: In order to provide the user with a service
  As a user
  I should be able to create wiki pages with Markdown syntax

  Scenario: User creates wiki page
  Given I am logged in
  When I click 'Create new wiki'
  Then I should be redirected to a new wiki instance