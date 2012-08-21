Feature: Add a new user

  Background:

  Scenario: Add a new user to MozyPro partner
    Given I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I act as newly created partner account
    When I add a new user:
      | # desktop licenses | desktop quota |
      | 1                  | 10            |
    Then New user should be created

  Scenario: Add a new user to MozyPro partner exceed quota limit
    Given I log in bus admin console as mozypro test account
    When I add a new user:
      | # desktop licenses | desktop quota |
      | 1                  | 1000          |
    Then New user created message should be Only 30 GB free(20 GB have been reserved for other users)




