Feature: Add a new user group

  Background:
    Given I log in bus admin console as administrator

#  @TC.849 @bus2.4
#  Scenario: 849 Add a new user group
#    When I add a new MozyEnterprise partner:
#      | period | users |
#      | 12     | 100   |
#    Then New partner should be created
#    When I act as newly created partner
#    And I add a new itemized user group:
#      | desktop_storage_type | desktop device | server_storage_type | server device |
#      | Shared               | 1               | Shared             | 1             |
#    Then Bundled user group should be created
#    And I search and delete newly created user group name user group
#
#  @TC.848 @bus2.4
#  Scenario: 848 Delete a user group
#    When I act as partner by:
#      | email                                    |
#      | qa1+users+features+test+account@mozy.com |
#    When I add a new user group:
#      | desktop licenses | desktop quota |
#      | 1                | 10            |
#    Then New user group should be created
#    When I view newly created user group name user group details
#    And I delete the user group
#    And I navigate to List User Group section from bus admin console page

  @TC.20716 @bus @2.5 @manage_storage @add_user_group @bundled
  Scenario: 20716 [Bundled] Add New Group
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms | company name            |
      | 12     | Silver        | 100            | yes         | yes       | [Bundled] Add New Group |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    And I act as newly created partner
    And I add a new Bundled user group:
      | name            | storage_type |
      | TC.20716-Shared | Shared       |
    Then TC.20716-Shared user group should be created
    When I add a new Bundled user group:
      | name             | storage_type | limited_quota |
      | TC.20716-Limited | Limited      | 50            |
    Then TC.20716-Limited user group should be created
    When I add a new Bundled user group:
      | name              | storage_type | assigned_quota |
      | TC.20716-Assigned | Assigned     | 50             |
    Then TC.20716-Assigned user group should be created
    When I add a new Bundled user group:
      | name          | storage_type |
      | TC.20716-None | None         |
    Then TC.20716-None user group should be created
    When I add a new Bundled user group:
      | name              | storage_type | enable_stash | server_support |
      | TC.20716-Shared-1 | Shared       | yes          | yes            |
    Then TC.20716-Shared-1 user group should be created
    When I add a new Bundled user group:
      | name               | storage_type | limited_quota | enable_stash | server_support |
      | TC.20716-Limited-1 | Limited      | 50            | yes          | yes            |
    Then TC.20716-Limited-1 user group should be created
    When I add a new Bundled user group:
      | name                | storage_type | assigned_quota | enable_stash | server_support |
      | TC.20716-Assigned-1 | Assigned     | 50             | yes          | yes            |
    Then TC.20716-Assigned-1 user group should be created
    When I add a new Bundled user group:
      | name               | storage_type |
      | TC.20716%^^&&&%$$# | None         |
    Then TC.20716%^^&&&%$$# user group should be created
    When I navigate to User Group List section from bus admin console page
    # User group table has an irregular headers, therefore headers verification will be ignored.
    And Bundled user groups table should be:
    | Group Name           | Stash | Server | Storage Type | Type Value | Storage Used | Devices Used |
    | (default user group) | true  | true   | Shared       |            | 0            | 0            |
    | TC.20716%^^&&&%$$#   | false | false  | None         |            | 0            | 0            |
    | TC.20716-Assigned    | false | false  | Assigned     | 50 GB      | 0            | 0            |
    | TC.20716-Assigned-1  | true  | true   | Assigned     | 50 GB      | 0            | 0            |
    | TC.20716-Limited     | false | false  | Limited      | 50 GB      | 0            | 0            |
    | TC.20716-Limited-1   | true  | true   | Limited      | 50 GB      | 0            | 0            |
    | TC.20716-None        | false | false  | None         |            | 0            | 0            |
    | TC.20716-Shared      | false | false  | Shared       |            | 0            | 0            |
    | TC.20716-Shared-1    | true  | true   | Shared       |            | 0            | 0            |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20899  @bus @2.5 @manage_storage @add_user_group @itemized
  Scenario: 20899 [Itemized] Add New Group
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name             |
      | 12     | 10    | 100 GB      | yes       | [Itemized] Add New Group |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    And I act as newly created partner
    When I add a new Itemized user group:
      | name            | desktop_storage_type | desktop_devices | enable_stash | server_storage_type |
      | TC.20899-Shared | Shared               | 1               | yes          | None                |
    Then TC.20899-Shared user group should be created
    When I add a new Itemized user group:
      | name             | desktop_storage_type | desktop_limited_quota | desktop_devices | enable_stash | server_storage_type |
      | TC.20899-Limited | Limited              | 5                     | 1               | yes          | None                |
    Then TC.20899-Limited user group should be created
    When I add a new Itemized user group:
      | name              | desktop_storage_type | desktop_assigned_quota | desktop_devices | enable_stash | server_storage_type |
      | TC.20899-Assigned | Assigned             | 5                      | 1               | yes          | None                |
    Then TC.20899-Assigned user group should be created
    When I add a new Itemized user group:
      | name          | desktop_storage_type | server_storage_type |
      | TC.20899-None | None                 | None                |
    Then TC.20899-None user group should be created
    When I add a new Itemized user group:
      | name              | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | TC.20899-Shared-1 | Shared               | 1               | Shared              | 2              |
    Then TC.20899-Shared-1 user group should be created
    When I add a new Itemized user group:
      | name               | desktop_storage_type | desktop_limited_quota | desktop_devices | server_storage_type | server_limited_quota | server_devices |
      | TC.20899-Limited-1 | Limited              | 5                     | 1               | Limited             | 10                   | 2              |
    Then TC.20899-Limited-1 user group should be created
    When I add a new Itemized user group:
      | name                | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | TC.20899-Assigned-1 | Assigned             | 5                      | 1               | Assigned            | 10                    | 2              |
    Then TC.20899-Assigned-1 user group should be created
    When I navigate to User Group List section from bus admin console page
    # User group table has an irregular headers, therefore headers verification will be ignored.
    And Itemized user groups table should be:
      | Group Name           | Stash | Server Storage Type | Server Type Value | Server Storage Used | Server Devices Used | Server Devices Total | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total |
      | (default user group) | true  | Shared              |                   | 0                   | 0                   | 194                  | Shared               |                    | 0                    | 0                    | 4                     |
      | TC.20899-Assigned    | true  | None                |                   | 0                   | 0                   | 0                    | Assigned             | 5 GB               | 0                    | 0                    | 1                     |
      | TC.20899-Assigned-1  | false | Assigned            | 10 GB             | 0                   | 0                   | 2                    | Assigned             | 5 GB               | 0                    | 0                    | 1                     |
      | TC.20899-Limited     | true  | None                |                   | 0                   | 0                   | 0                    | Limited              | 5 GB               | 0                    | 0                    | 1                     |
      | TC.20899-Limited-1   | false | Limited             | 10 GB             | 0                   | 0                   | 2                    | Limited              | 5 GB               | 0                    | 0                    | 1                     |
      | TC.20899-None        | false | None                |                   | 0                   | 0                   | 0                    | None                 |                    | 0                    | 0                    | 0                     |
      | TC.20899-Shared      | true  | None                |                   | 0                   | 0                   | 0                    | Shared               |                    | 0                    | 0                    | 1                     |
      | TC.20899-Shared-1    | false | Shared              |                   | 0                   | 0                   | 2                    | Shared               |                    | 0                    | 0                    | 1                     |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  # Error messages are not final version, they will be change in the future
  @TC.20898 @BUG.100010  @bus @2.5 @manage_storage @add_user_group
  Scenario: 20898 [Bundled][Negative] Add New Group
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms | company name                      |
      | 12     | Silver        | 100            | yes         | yes       | [Bundled][Negative] Add New Group |
    Then New partner should be created
    When I act as newly created partner
    And I add a new Bundled user group:
      | storage_type | assigned_quota |
      | Assigned     | 101            |
    Then Add user group error messages should be:
      """
      storage can only be assigned between 0 and 100 GB.
      """
    When I add a new Bundled user group:
      | storage_type | assigned_quota |
      | Assigned     |                |
    Then Add user group error messages should be:
      """
      Assigned Storage Required
      """
    When I add a new Bundled user group:
      | storage_type | assigned_quota |
      | Assigned     | -1             |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Assigned Storage
      """
    When I add a new Bundled user group:
      | storage_type | assigned_quota |
      | Assigned     | 1.5            |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Assigned Storage
      """
    When I add a new Bundled user group:
      | storage_type | assigned_quota |
      | Assigned     | hello          |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Assigned Storage
      """
    When I add a new Bundled user group:
      | storage_type | limited_quota |
      | Limited      | 101           |
    Then Add user group error messages should be:
      """
      Use between 0 and 100 GB for limited storage.
      """
    When I add a new Bundled user group:
      | storage_type | limited_quota |
      | Limited      |               |
    Then Add user group error messages should be:
      """
      Limited Storage required
      """
    When I add a new Bundled user group:
      | storage_type | limited_quota |
      | Limited      | -1            |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Limited Storage
      """
    When I add a new Bundled user group:
      | storage_type | limited_quota |
      | Limited      | 1.5           |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Limited Storage
      """
    When I add a new Bundled user group:
      | storage_type | limited_quota |
      | Limited      | hello         |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Limited Storage
      """
    When I add a new Bundled user group:
      | name | storage_type |
      |      | Limited      |
    Then Add user group error messages should be:
      """
      Please enter a name
      """
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  # Error messages are not final version, they will be change in the future
  @TC.20900 @bus @2.5 @manage_storage @add_user_group
  Scenario: 20900 [Itemized][Negative] Add New Group
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name                       |
      | 12     | 10    | 100 GB      | yes       | [Itemized][Negative] Add New Group |
    Then New partner should be created
    When I act as newly created partner
    And I add a new Itemized user group:
      | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | Shared               | 11              | Shared              | 201            |
    Then Add user group error messages should be:
      """
      Not enough Desktop devices available
      Not enough Server devices available
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | Shared               |                 | Shared              |                |
    Then Add user group error messages should be:
      """
      Desktop device count required
      Server device count required
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | Shared               | -1              | Shared              | -1             |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | Shared               | hello           | Shared              | hello          |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | Shared               | 1.5             | Shared              | 1.5            |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_limited_quota | desktop_devices | server_storage_type | server_limited_quota | server_devices |
      | Limited              | 251                   | 11              | Limited             | 101                  | 201            |
    Then Add user group error messages should be:
      """
      Use between 0 and 100 GB for Server limited storage.
      Use between 0 and 250 GB for Desktop limited storage.
      Not enough Desktop devices available
      Not enough Server devices available
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_limited_quota | desktop_devices | server_storage_type | server_limited_quota | server_devices |
      | Limited              |                       |                 | Limited             |                      |                |
    Then Add user group error messages should be:
      """
      Server Limited Storage required
      Desktop Limited Storage required
      Desktop device count required
      Server device count required
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_limited_quota | desktop_devices | server_storage_type | server_limited_quota | server_devices |
      | Limited              | -1                    | -1              | Limited             | -1                   | -1             |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Server Limited Storage
      Whole positive integer required for Desktop Limited Storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_limited_quota | desktop_devices | server_storage_type | server_limited_quota | server_devices |
      | Limited              | hello                 | hello           | Limited             | hello                | hello          |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Server Limited Storage
      Whole positive integer required for Desktop Limited Storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_limited_quota | desktop_devices | server_storage_type | server_limited_quota | server_devices |
      | Limited              | 1.5                   | 1.5             | Limited             | 1.5                  | 1.5            |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Server Limited Storage
      Whole positive integer required for Desktop Limited Storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | Assigned             | 251                    | 11              | Assigned            | 101                   | 201            |
    Then Add user group error messages should be:
      """
      Server storage can only be assigned between 0 and 100 GB.
      Desktop storage can only be assigned between 0 and 250 GB.
      Not enough Desktop devices available
      Not enough Server devices available
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | Assigned             |                        |                 | Assigned            |                       |                |
    Then Add user group error messages should be:
      """
      Server Assigned Storage Required
      Desktop Assigned Storage Required
      Desktop device count required
      Server device count required
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | Assigned             | -1                     | -1              | Assigned            | -1                    | -1             |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Server Assigned Storage
      Whole positive integer required for Desktop Assigned Storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | Assigned             | hello                  | hello           | Assigned            | hello                 | hello          |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Server Assigned Storage
      Whole positive integer required for Desktop Assigned Storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | Assigned             | 1.5                    | 1.5             | Assigned            | 1.5                   | 1.5            |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Server Assigned Storage
      Whole positive integer required for Desktop Assigned Storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      |      | Shared               | 1               | Shared              | 1              |
    Then Add user group error messages should be:
      """
      Please enter a name
      """
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20713 @bus @2.5 @manage_storage @add_user_group
  Scenario: 20713 [Bundled] Verify Add New Group UI
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms | company name                      |
      | 12     | Silver        | 100            | yes       | [Bundled] Verify Add New Group UI |
    Then New partner should be created
    When I act as newly created partner
    And I navigate to Add User Group section
    Then I should see correct UI for Bundled user group with:
      | storage_type | enable_stash | server_support |
      | Shared       | no           | no             |
    Then I should see correct UI for Bundled user group with:
      | storage_type | enable_stash | server_support |
      | Limited      | no           | no             |
    Then I should see correct UI for Bundled user group with:
      | storage_type | enable_stash | server_support |
      | Assigned     | no           | no             |
    Then I should see correct UI for Bundled user group with:
      | storage_type | enable_stash | server_support |
      | None         | no           | no             |
    When I change Reseller account plan to:
      | server plan |
      | yes         |
    And the Reseller account plan should be changed
    And I navigate to Add User Group section
    Then I should see correct UI for Bundled user group with:
      | storage_type | enable_stash | server_support |
      | Shared       | no           | yes            |
    Then I should see correct UI for Bundled user group with:
      | storage_type | enable_stash | server_support |
      | Limited      | no           | yes            |
    Then I should see correct UI for Bundled user group with:
      | storage_type | enable_stash | server_support |
      | Assigned     | no           | yes            |
    When I stop masquerading
    And I view partner details by newly created partner company name
    And I enable stash for the partner with default stash storage
    And I act as newly created partner
    And I navigate to Add User Group section
    Then I should see correct UI for Bundled user group with:
      | storage_type | enable_stash | server_support |
      | Shared       | yes          | yes            |
    Then I should see correct UI for Bundled user group with:
      | storage_type | enable_stash | server_support |
      | Limited      | yes          | yes            |
    Then I should see correct UI for Bundled user group with:
      | storage_type | enable_stash | server_support |
      | Assigned     | yes          | yes            |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20896 @bus @2.5 @manage_storage @add_user_group
  Scenario: 20896 [Itemized] Verify Add New Group UI
    When I add a new MozyEnterprise partner:
      | period | users | net terms | company name                       |
      | 12     | 10    | yes       | [Itemized] Verify Add New Group UI |
    Then New partner should be created
    When I act as newly created partner
    And I navigate to Add User Group section
    Then I should see correct UI for Itemized user group with:
      | storage_type | enable_stash | server_support |
      | Shared       | no           | no             |
    Then I should see correct UI for Itemized user group with:
      | storage_type | enable_stash | server_support |
      | Limited      | no           | no             |
    Then I should see correct UI for Itemized user group with:
      | storage_type | enable_stash | server_support |
      | Assigned     | no           | no             |
    Then I should see correct UI for Itemized user group with:
      | storage_type | enable_stash | server_support |
      | None         | no           | no             |
    When I change MozyEnterprise account plan to:
      | server plan |
      | 100 GB      |
    And the MozyEnterprise account plan should be changed
    And I navigate to Add User Group section
    Then I should see correct UI for Itemized user group with:
      | storage_type | enable_stash | server_support |
      | Shared       | no           | yes            |
    Then I should see correct UI for Itemized user group with:
      | storage_type | enable_stash | server_support |
      | Limited      | no           | yes            |
    Then I should see correct UI for Itemized user group with:
      | storage_type | enable_stash | server_support |
      | Assigned     | no           | yes            |
    When I stop masquerading
    And I view partner details by newly created partner company name
    And I enable stash for the partner with default stash storage
    And I act as newly created partner
    And I navigate to Add User Group section
    Then I should see correct UI for Itemized user group with:
      | storage_type | enable_stash | server_support |
      | Shared       | yes          | yes            |
    Then I should see correct UI for Itemized user group with:
      | storage_type | enable_stash | server_support |
      | Limited      | yes          | yes            |
    Then I should see correct UI for Itemized user group with:
      | storage_type | enable_stash | server_support |
      | Assigned     | yes          | yes            |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name



