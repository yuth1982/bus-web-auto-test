Feature: Adjustable retention at the partner and user group level

  As a Mozy Administrator
  I want the ability to set the data retention time at the partner and/or user group level
  so that Sales can offer extended retention to customers.

  Background:
    Given I log in bus admin console as administrator

  @TC.143307_1 @bus @data_retention
  Scenario: click Data Retention, go to Data Retention section, check default info here. example test cases
    When I add a new MozyEnterprise partner:
      | period | users |
      | 24     | 100   |
    And New partner should be created
    When I get the partner_id
    When I act as newly created partner account
    When I add a new Itemized user group:
      | name          | desktop_storage_type | desktop_devices |
      | qa-test-group | Shared               | 1               |
    Then Itemized user group should be created
    And I navigate to Data Retention section from bus admin console page
    Then partner adr policy should be None
    And user group adr policy should be:
      | Name                 | Policy |
      | (default user group) | None   |
      | qa-test-group        | None   |
    And I should see No results found. in sub partner adr policy list
    When I click partner adr policy
    And I set adr policy to 1 Year (monthly)
    Then Change ADR Policy section message should be Update Adr policy successfully.
    And partner adr policy should be 1 Year (monthly)
    And user group adr policy should be:
      | Name                 | Policy           |
      | (default user group) | 1 Year (monthly) |
      | qa-test-group        | 1 Year (monthly) |
    And I should see No results found. in sub partner adr policy list
    Then ADR policy in DB for partner is Mozy1Year_monthly
    And ADR policy in DB for user groups are Mozy1Year_monthly

  @TC.143307_2 @bus @data_retention
  Scenario: create data retention for partner
    When I act as partner by:
      | email                                  |
      | mozyautotest+matthew+reed+1739@emc.com |
    And I navigate to Data Retention section from bus admin console page
    When I click partner adr policy
    And I set adr policy to 1 Year (monthly)
    Then Change ADR Policy section message should be Update Adr policy successfully.
    And partner adr policy should be 1 Year (monthly)
    And user group adr policy should be:
      | Name                 | Policy           |
      | (default user group) | 1 Year (monthly) |
    And I should see No results found. in sub partner adr policy list

  @TC.143307_3 @bus @data_retention
  Scenario: create many machines here, to be done, refer to features/users/adhoc_tasks/add_multiple_machines.feature
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Server       | 10            | 0       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then I can see Send Keys button is disable
    Then I close user details section
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Server       | 10            | 3       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then Number of Server activated keys should be 0
    And Number of Server unactivated keys should be 3
    When I click Send Keys button
    And I wait for 15 seconds
    And I search emails by keywords:
      | content                |
      | <%=@unactivated_keys%> |
    Then I should see 1 email(s)
    And I cannot find any Activated license key(s) from the mail
    And I can find 3 Unactivated Server license key(s) from the mail
    When I update the user password to default password
    And activate the user's Server device without a key and with the default password







