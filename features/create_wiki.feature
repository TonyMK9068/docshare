Feature: In order to provide the user with a service
  As a user
  I should be able to create wiki pages with Markdown syntax

  Scenario: User clicks 'New Page' link
  Given I am logged in with a standard account
  When I click 'New Page'
  Then I should be redirected to a new wiki instance

  Scenario: User saves new wiki page
  Given I am logged in with a standard account
    And I have filled in all information for new page
  When I click 'Save'
  Then the new page should be saved

  Scenario: User attempts to save without entering title
  Given I am logged in with a standard account
    And I have filled in the body but not the title
  When I click 'Save'
  Then I should see an error

  Scenario: User attempts to save without entering body
  Given I am logged in with a standard account
    And I have filled in the title but not the body
  When I click 'Save'
  Then I should see an error