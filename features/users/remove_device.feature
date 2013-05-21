Feature: Remove a user

  Background:
    Given I log in bus admin console as administrator

  @TC.21070
  Scenario: 21070 [Bundled][Reseller] Delete device
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 100            | yes         |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21070-1 | (default user group) | Desktop      | 25            | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then Number of activated keys should be 0
    And Number of unactivated keys should be 2
    When I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I refresh User Details section
    Then device table in user details should be:
      | Used/Available |
      | 5 GB / 20 GB   |
    When I view the user's product keys
    Then Number of activated keys should be 1
    And Number of unactivated keys should be 1
    When I delete device by name: AUTOTEST
    And I refresh User Details section
    And I view the user's product keys
    Then Number of activated keys should be 0
    And Number of unactivated keys should be 2
