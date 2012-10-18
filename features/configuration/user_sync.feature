Feature: User sync

  As an Mozy administrator
  I want to sync users from AD
  So that the partner admin can manage their users easily

  Background:
    Given I log in bus admin console as administrator
    And I act as the partner by usrsync@test.com on admin details panel
    And I navigate to Authentication Policy section from bus admin console page

  @TC.17529-17536
  Scenario: Check the Sync rules UI is correct
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add a new rule: cn=dev_test*
    Then There should be 4 items:
      | (default user group) | dev | pm | qa |
