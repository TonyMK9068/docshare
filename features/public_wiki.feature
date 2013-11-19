Feature: In order to allow users to share their work

As a user
I want to be able to make my wikis public

  Scenario:Create public wiki
  Given I am logged in
  When I click 'New Page'
  Then I should be able to make it public
