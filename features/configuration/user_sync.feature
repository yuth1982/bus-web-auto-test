Feature: User sync

  As an Mozy administrator
  I want to sync users from AD
  So that the partner admin can manage their users easily

  Background:
    Given I log in bus admin console as administrator

  @TC.17529-17536
  Scenario: Check the Sync rules UI is correct
    When I act as a partner user sync regression
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I move to the Sync rules tab
    And I add a new rule: cn=dev_test*
    Then There should be 4 items:
      | (default user group) | dev | pm | qa |
