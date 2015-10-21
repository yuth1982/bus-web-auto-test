Feature: Transfer Resources

  Background:
    Given I log in bus admin console as administrator

  @TC.428 @tasks_p1 @resuorces @bus
  Scenario: 428 Transfer Resources
    When I add a new OEM partner:
      | Root role      | Company Type     |
      | OEM Root Trial | Service Provider |
    Then New partner should be created
    When I act as newly created partner account
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 10              | 10            | 10             | 10           |
    And I add a new user group for an itemized partner:
      | name      | server_assigned_quota | desktop_assigned_quota |
      | oem_group | 2                     | 2                     |
    Then Itemized partner user group oem_group should be created
    When I transfer resources from user group (default user group) to partner the same partner and user group oem_group with:
      | server_licenses | server_storage | desktop_licenses | desktop_storage |
      | 2               | 3              | 2                | 3               |
    Then Resources should be transferred
    And I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Server Keys | Server Quota            | Desktop Keys | Desktop Quota           |
      | (default user group) * | 0     | 1      | 0 / 8       | 0.0 (0.0 active) / 7.0  | 0 / 8        | 0.0 (0.0 active) / 7.0  |
      | oem_group              | 0     | 1      | 0 / 2       | 0.0 (0.0 active) / 3.0  | 0 / 2        | 0.0 (0.0 active) / 3.0  |
    And I stop masquerading as sub partner
    And I search and delete partner account by newly created subpartner company name

  @TC.13085 @tasks_p1 @resuorces @bus
  Scenario: 13085 Transfer Resources Test
    When I add a new OEM partner:
      | company name      | Root role      | Company Type     |
      | TC.13085_partner  | OEM Root Trial | Service Provider |
    Then New partner should be created
    And I act as newly created partner account
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 99              | 99            | 99             | 99           |
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent         |
      | subrole | Partner admin | OEM Root Trial |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for OEM partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes | Desktop Price per key | Desktop Min keys | Desktop Price per gigabyte | Desktop Min gigabytes | Grandfathered Price per key | Grandfathered Min keys | Grandfathered Price per gigabyte | Grandfathered Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                    | 1               | 1                         | 1                    | 1                     | 1                | 1                          | 1                     | 1                           | 1                      | 1                                | 1                           |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name          | Pricing Plan | Admin Name |
      | TC.13085_sub_partner  | subplan      | subadmin   |
    Then New partner should be created
    And I transfer resources from user group (default user group) to partner TC.13085_sub_partner and user group (default user group) with:
      | server_licenses | server_storage | desktop_licenses | desktop_storage |
      | 9               | 9              | 9                | 9               |
    Then Resources should be transferred
    And I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Server Keys | Server Quota            | Desktop Keys | Desktop Quota           |
      | (default user group) * | 0     | 1      | 0 / 90      | 0.0 (0.0 active) / 90.0 | 0 / 90       | 0.0 (0.0 active) / 90.0 |
    And I act as partner by:
      | name                   |
      | TC.13085_sub_partner   |
    And I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Server Keys | Server Quota            | Desktop Keys | Desktop Quota           |
      | (default user group) * | 0     | 1      | 0 / 9       | 0.0 (0.0 active) / 9.0  | 0 / 9        | 0.0 (0.0 active) / 9.0  |
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.13085_sub_partner
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.13085_partner






