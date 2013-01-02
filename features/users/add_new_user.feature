Feature: Add a new user

  Background:

  @TC.19656
  Scenario: 19656 - Create new user under MozyPro as BUS Admin
    Given I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I act as newly created partner account
    When I add a new user to MozyPro partner:
      | desired_user_storage | device_count |
      | 10                   | 1            |
    Then New user should be created
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19814
  Scenario: 19814 - Create new user under Metallic Reseller as BUS Admin
    Given I log in bus admin console as administrator
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 100            |
    Then New partner should be created
    When I act as newly created partner account
    When I add a new user to Reseller partner:
      | desired_user_storage | device_count |
      | 10                   | 1            |
    Then New user should be created
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19658
  Scenario: 19658 - Create new user under Enterprise partner as BUS Admin
    Given I log in bus admin console as administrator
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    Then New partner should be created
    When I act as newly created partner account
    When I add a new user to MozyEnterprise partner:
      | desired_user_storage | device_count |
      | 10                   | 1            |
    Then New user should be created
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

#  Scenario: Add a new user to MozyPro partner exceed quota limit
#    Given I log in bus admin console as mozypro test account
#    When I add a new user:
#      | # desktop licenses | desktop quota |
#      | 1                  | 1000          |
#    Then New user created message should be Only 30 GB free(20 GB have been reserved for other users)




