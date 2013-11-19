Feature: In order to provide the user with a service
  As a user
  I should be able to create wiki pages with Markdown syntax

  Scenario: User clicks 'New Page' link
  Given I am logged in
  When I click 'New Page'
  Then I should be redirected to a new wiki instance

  Scenario: User saves new wiki page
  Given I am logged in
    And I have filled in all information for new page
  When I click 'Save'
  Then the new page should be saved

  Scenario: User attempts to save without entering title
  Given I am logged in
    And I have filled in the page_body but not the page_title
  When I click 'Save'
  Then I should see an error

  Scenario: User attempts to save without entering body
  Given I am logged in
    And I have filled in the page_title but not the page_body
  When I click 'Save'
  Then I should see an error