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

  # Error messages are not final version, they will be change in the future
  @TC.20881
  Scenario: 20881 [Bundled][Negative] Edit User Group
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms | company name                        |
      | 12     | Silver        | 100            | yes         | yes       | [Bundled][Negative] Edit User Group |
    Then New partner should be created
    When I act as newly created partner
    And I add a new Bundled user group:
      | name        | storage_type |
      | TC.20881 UG | Shared       |
    Then TC.20881 UG user group should be created
    When I edit TC.20881 UG Bundled user group:
      | name        | storage_type | assigned_quota |
      | TC.20881 UG | Assigned     | 101            |
    Then Edit user group error messages should be:
      """
      Generic assigned storage cannot exceed its ProPartner's effective storage quota
      """
    When I edit TC.20881 UG Bundled user group:
      | name        | storage_type | assigned_quota |
      | TC.20881 UG | Assigned     | 0              |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Generic assigned storage
      """
    When I edit TC.20881 UG Bundled user group:
      | name        | storage_type | assigned_quota |
      | TC.20881 UG | Assigned     |                |
    Then Edit user group error messages should be:
      """
      Generic assigned storage required
      """
    When I edit TC.20881 UG Bundled user group:
      | name        | storage_type | assigned_quota |
      | TC.20881 UG | Assigned     | -1             |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Generic assigned storage
      """
    When I edit TC.20881 UG Bundled user group:
      | name        | storage_type | assigned_quota |
      | TC.20881 UG | Assigned     | 1.5            |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Generic assigned storage
      """
    When I edit TC.20881 UG Bundled user group:
      | name        | storage_type | assigned_quota |
      | TC.20881 UG | Assigned     | hello          |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Generic assigned storage
      """
    When I edit TC.20881 UG Bundled user group:
      | name        | storage_type    | max_quota |
      | TC.20881 UG | Shared with Max | 101       |
    Then Edit user group error messages should be:
      """
      Use between 1 to 100 GB for Generic shared with max storage
      """
    When I edit TC.20881 UG Bundled user group:
      | name        | storage_type    | max_quota |
      | TC.20881 UG | Shared with Max | 0         |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Generic shared with max storage
      """
    When I edit TC.20881 UG Bundled user group:
      | name        | storage_type    | max_quota |
      | TC.20881 UG | Shared with Max |           |
    Then Edit user group error messages should be:
      """
      Generic shared with max storage required
      """
    When I edit TC.20881 UG Bundled user group:
      | name        | storage_type    | max_quota |
      | TC.20881 UG | Shared with Max | -1        |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Generic shared with max storage
      """
    When I edit TC.20881 UG Bundled user group:
      | name        | storage_type    | max_quota |
      | TC.20881 UG | Shared with Max | 1.5       |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Generic shared with max storage
      """
    When I edit TC.20881 UG Bundled user group:
      | name        | storage_type    | max_quota |
      | TC.20881 UG | Shared with Max | hello     |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Generic shared with max storage
      """
    When I edit TC.20881 UG Bundled user group:
      | name | storage_type    |
      |      | Shared with Max |
    Then Edit user group error messages should be:
      """
      Please enter a name
      """
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  # Error messages are not final version, they will be change in the future
  @TC.20829
  Scenario: 20829 [Itemized][Negative] Edit User Group
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name                       |
      | 12     | 10    | 100 GB      | yes       | [Itemized][Negative] Add New Group |
    Then New partner should be created
    When I act as newly created partner
    And I add a new Itemized user group:
      | name        | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | TC.20829 UG | Shared               | 2               | Shared              | 2             |
    Then TC.20829 UG  user group should be created
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | TC.20829 UG | Shared               | 11              | Shared              | 201            |
    Then Edit user group error messages should be:
      """
      Not enough Desktop devices available
      Not enough Server devices available
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | TC.20829 UG | Shared               | 0               | Shared              | 0              |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | TC.20829 UG | Shared               |                 | Shared              |                |
    Then Edit user group error messages should be:
      """
      Desktop device count required
      Server device count required
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | TC.20829 UG | Shared               | -1              | Shared              | -1             |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | TC.20829 UG | Shared               | hello           | Shared              | hello          |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | TC.20829 UG | Shared               | 1.5             | Shared              | 1.5            |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_max_quota | desktop_devices | server_storage_type | server_max_quota | server_devices |
      | TC.20829 UG | Shared with Max      | 251               | 11              | Shared with Max     | 101              | 201            |
    Then Edit user group error messages should be:
      """
      Use between 1 to 100 GB for Server shared with max storage
      Use between 1 to 250 GB for Desktop shared with max storage
      Not enough Desktop devices available
      Not enough Server devices available
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_max_quota | desktop_devices | server_storage_type | server_max_quota | server_devices |
      | TC.20818 UG | Shared with Max      | 0                 | 0               | Shared with Max     | 0                | 0              |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Server shared with max storage
      Whole positive integer required for Desktop shared with max storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_max_quota | desktop_devices | server_storage_type | server_max_quota | server_devices |
      | TC.20818 UG | Shared with Max      |                   |                 | Shared with Max     |                  |                |
    Then Edit user group error messages should be:
      """
      Server shared with max storage required
      Desktop shared with max storage required
      Desktop device count required
      Server device count required
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_max_quota | desktop_devices | server_storage_type | server_max_quota | server_devices |
      | TC.20818 UG | Shared with Max      | -1                | -1              | Shared with Max     | -1               | -1             |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Server shared with max storage
      Whole positive integer required for Desktop shared with max storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_max_quota | desktop_devices | server_storage_type | server_max_quota | server_devices |
      | TC.20818 UG | Shared with Max      | hello             | hello           | Shared with Max     | hello            | hello          |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Server shared with max storage
      Whole positive integer required for Desktop shared with max storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_max_quota | desktop_devices | server_storage_type | server_max_quota | server_devices |
      | TC.20818 UG | Shared with Max      | 1.5               | 1.5             | Shared with Max     | 1.5              | 1.5            |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Server shared with max storage
      Whole positive integer required for Desktop shared with max storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | TC.20818 UG | Assigned             | 251                    | 11              | Assigned            | 101                   | 201            |
    Then Edit user group error messages should be:
      """
      Server assigned storage cannot exceed its ProPartner's effective storage quota
      Desktop assigned storage cannot exceed its ProPartner's effective storage quota
      Not enough Desktop devices available
      Not enough Server devices available
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | TC.20818 UG | Assigned             | 0                      | 0               | Assigned            | 0                     | 0              |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Server assigned storage
      Whole positive integer required for Desktop assigned storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | TC.20818 UG | Assigned             |                        |                 | Assigned            |                       |                |
    Then Edit user group error messages should be:
      """
      Server assigned storage required
      Desktop assigned storage required
      Desktop device count required
      Server device count required
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | TC.20818 UG | Assigned             | -1                     | -1              | Assigned            | -1                    | -1             |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Server assigned storage
      Whole positive integer required for Desktop assigned storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | TC.20818 UG | Assigned             | hello                  | hello           | Assigned            | hello                 | hello          |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Server assigned storage
      Whole positive integer required for Desktop assigned storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | TC.20818 UG | Assigned             | 1.5                    | 1.5             | Assigned            | 1.5                   | 1.5            |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Server assigned storage
      Whole positive integer required for Desktop assigned storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I edit TC.20829 UG Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      |      | Shared               | 1               | Shared              | 1              |
    Then Edit user group error messages should be:
      """
      Please enter a name
      """
    When I stop masquerading
    And I search and delete partner account by newly created partner company name
