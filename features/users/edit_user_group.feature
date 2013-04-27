Feature: Edit existing user group

  Background:
    Given I log in bus admin console as administrator

  @TC.20894
  Scenario: 20894 [Bundled] Edit User Group
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms | company name              |
      | 12     | Silver        | 100            | yes         | yes       | [Bundled] Edit User Group |
    Then New partner should be created
    And I enable stash for the partner with default stash storage
    And I act as newly created partner
    When I edit (default user group) Bundled user group:
      | storage_type  |
      | None          |
    Then (default user group) user group should be updated
    When I edit (default user group) Bundled user group:
      | storage_type    | max_quota | enable_stash | server_support |
      | Shared with Max | 100       | yes          | yes            |
    Then (default user group) user group should be updated
    When I edit (default user group) Bundled user group:
      | storage_type | assigned_quota | enable_stash | server_support |
      | Assigned     | 50             | yes          | no             |
    Then (default user group) user group should be updated
    Then I close edit user group section
    And I add a new Bundled user group:
      | name        | storage_type |
      | TC.20894 UG | Shared       |
    Then TC.20894 UG user group should be created
    When I edit TC.20894 UG Bundled user group:
      | name        | storage_type  |
      | TC.20894 UG | None          |
    Then TC.20894 UG user group should be updated
    When I edit TC.20894 UG Bundled user group:
      | name        | storage_type | assigned_quota | enable_stash | server_support |
      | TC.20894 UG | Assigned     | 50             | yes          | yes            |
    Then TC.20894 UG user group should be updated
    When I edit TC.20894 UG Bundled user group:
      | name        | storage_type    | max_quota | enable_stash | server_support |
      | TC.20894 UG | Shared with Max | 100       | no           | yes            |
    Then TC.20894 UG user group should be updated
    When I edit TC.20894 UG Bundled user group:
      | name            |
      | TC.20894 UG New |
    Then TC.20894 UG New user group should be updated
    When I navigate to User Group List section from bus admin console page
  # User group table has an irregular headers, therefore headers verification will be ignored.
    And Bundled user groups table should be:
      | Group Name            | Stash | Server | Storage Type    | Type Value | Storage Used | Devices Used |
      | (default user group)  | true  | false  | Assigned        | 50 GB      | 0 bytes      | 0            |
      | TC.20894 UG New       | false | true   | Shared with max | 100 GB     | 0 bytes      | 0            |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20818
  Scenario: 20818 [Itemized] Edit User Group
#    When I add a new MozyEnterprise partner:
#      | period | users | server plan | net terms | company name               |
#      | 12     | 10    | 100 GB      | yes       | [Itemized] Edit User Group |
#    Then New partner should be created
#    And I enable stash for the partner with default stash storage
#    And I act as newly created partner
    When I act as partner by:
    | email |
    | qa1+donald+fowler+1753@decho.com |
    When I edit (default user group) Itemized user group:
      | desktop_storage_type | server_storage_type |
      | None                 | None                |
    Then (default user group) user group should be updated
    When I edit (default user group) Itemized user group:
      | desktop_storage_type | desktop_max_quota | enable_stash | server_storage_type | server_max_quota |
      | Shared with Max      | 250               | yes          | Shared with Max     | 100              |
    Then (default user group) user group should be updated
    When I edit (default user group) Itemized user group:
      | desktop_storage_type | desktop_assigned_quota | enable_stash | server_storage_type | server_assigned_quota |
      | Assigned             | 150                    | no           | Assigned            | 50                    |
    Then (default user group) user group should be updated
    Then I close edit user group section
    And I add a new Itemized user group:
      | name        | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | TC.20818 UG | Assigned             | 5                      | 4               | Assigned            | 10                    | 4              |
    Then TC.20818 UG user group should be created
    When I edit TC.20818 UG Itemized user group:
      | name        | desktop_storage_type | server_storage_type |
      | TC.20818 UG | None                 | None                |
    Then TC.20818 UG user group should be updated
    When I edit TC.20818 UG Itemized user group:
      | name        | desktop_storage_type | desktop_max_quota | desktop_devices | server_storage_type | server_max_quota | server_devices |
      | TC.20818 UG | Shared with Max      | 250               | 4               | Shared with Max     | 100              | 4              |
    Then TC.20818 UG user group should be updated
    When I edit TC.20818 UG Itemized user group:
      | name        | desktop_storage_type | desktop_assigned_quota | desktop_devices | enable_stash | server_storage_type | server_assigned_quota | server_devices |
      | TC.20818 UG | Assigned             | 50                     | 4               | no           | Assigned            | 50                    | 4              |
    Then TC.20818 UG user group should be updated
    When I edit TC.20818 UG Itemized user group:
      | name            |
      | TC.20818 UG New |
    Then TC.20818 UG New user group should be updated
    When I navigate to User Group List section from bus admin console page
    # User group table has an irregular headers, therefore headers verification will be ignored.
    And Itemized user groups table should be:
      | Group Name           | Stash | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total | Server Storage Type | Server Type Value | Server Storage Used | Server Devices Used | Server Devices Total |
      | (default user group) | true  | Assigned             | 150 GB             | 0 bytes              | 6                    | 4                     | Assigned            | 50 GB             | 0 bytes             | 0                   | 196                  |
      | TC.20818 UG New      | false | Assigned             | 50 GB              | 0 bytes              | 4                    | 1                     | Assigned            | 50 GB             | 0 bytes             | 0                   | 4                    |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

