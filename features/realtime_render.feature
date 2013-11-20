Feature: In order to aid in the creation of markdown wikis
  As a user
  I should be able to see my markdown text rendered in realtime
  
  Scenario: User is creating a new page using markdown language
  Given I am logged in with a standard account
    And I am creating a new page
  When I enter markdown
  Then I should see the text formatted in real time