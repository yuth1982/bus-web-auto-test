Feature: Set Remove Max at User Group

  Background:
    Given I log in bus admin console as administrator

  @TC.21002 @bus @2.5 @manage_storage @bundled @reseller
  Scenario: 21002 [Bundled][Reseller] Change Group Share with Max value less than used quota
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms |
      | 12     | Silver        | 100            | yes         | yes       |
    Then New partner should be created
    And I act as newly created partner
    And I add a new Bundled user group:
      | name        | storage_type | assigned_quota | server_support |
      | TC.21002 UG | Assigned     | 50             | yes            |
    Then TC.21002 UG user group should be created
    And I add new user(s):
      | name       | user_group  | storage_type | devices |
      | TC.21002-1 | TC.21002 UG | Desktop      | 1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | TEST_M1      | Desktop      | @partner_name |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 40 GB
    When I edit TC.21002 UG Bundled user group:
      | name        | storage_type | assigned_quota |
      | TC.21002 UG | Assigned     | 30             |
    Then Edit user group error messages should be:
      """
      storage can only be assigned between 40 and 100 GB.
      """
    When I edit TC.21002 UG Bundled user group:
      | name        | storage_type | limited_quota |
      | TC.21002 UG | Limited      | 30            |
    Then TC.21002 UG user group should be updated
    And I stop masquerading
    And I search and delete partner account by newly created partner company name
