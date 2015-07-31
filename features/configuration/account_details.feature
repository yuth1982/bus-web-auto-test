Feature: Configurations: Account Details


  Background:
    Given I log in bus admin console as administrator

  @TC.880 @account_details @bus
  Scenario: 880 Edit the name on an account
    When I add a new MozyPro partner:
     | net terms |
     | yes       |
    Then New partner should be created
    And I act as newly created partner account
    Then I navigate to Account Details section from bus admin console page
    When I change the display name to auto test account
    Then display name changed success message should be displayed
    And I stop masquerading
    And I search and delete partner account by newly created partner company name
