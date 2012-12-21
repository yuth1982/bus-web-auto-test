Feature: Sub partners can purchase resources

  # Limitations:
  #  Test accounts have been created on QA6 only for existing partners cases
  #
  Background:
    Given I log in bus admin console as administrator

  @TC.19864
  Scenario: 19864 Existing OEM partner with sub partners whose sub partners can purchase resources
    When I act as partner by:
      | email                                | filter |
      | qa1+oem+subpartner+reserved@mozy.com | OEMs   |
    And I navigate to Assign Keys section from bus admin console page
    Then Partner resources general information should be:
      | Total Account Storage: | Desktop Storage: | Server Storage: | Server Enabled: | Total License Keys: | Desktop Licenses: | Server Licenses: |
      | 381 GB                 | 198 GB           | 183 GB          | Yes             | 36                  | 19                | 17               |
    When I add a new sub partner:
      | name                 | admin name      | admin email                  |
      | TC.19864 sub partner | TC.19864 admin  | qa1+tc+19864+admin1@mozy.com |
    Then New partner should be created
    When I act as newly created sub partner account
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 1               | 10            | 1              | 5            |
    Then Resources should be purchased
    When I stop masquerading
    When I search partner by:
      | email                        |
      | qa1+tc+19864+admin1@mozy.com |
    Then Partner search results should be:
      | External ID | Partner              | Created | Root Admin                   | Type     | Users    | Licenses | Quota |
      |             | TC.19864 sub partner | today   | qa1+tc+19864+admin1@mozy.com | business | 0        | 2        | 15 GB |
    When I navigate to Assign Keys section from bus admin console page
    Then Partner resources general information should be:
      | Total Account Storage: | Desktop Storage: | Server Storage: | Server Enabled: | Total License Keys: | Desktop Licenses: | Server Licenses: |
      | 396 GB                 | 208 GB           | 188 GB          | Yes             | 38                  | 20                | 18               |
    And I search and delete partner account by TC.19864 sub partner

  @TC.19865
  Scenario: 19865 Existing OEM partner with sub partners whose OEM partner can purchase resources
    When I act as partner by:
      | email                                | filter |
      | qa1+oem+subpartner+reserved@mozy.com | OEMs   |
    And I navigate to Assign Keys section from bus admin console page
    Then Partner resources general information should be:
      | Total Account Storage: | Desktop Storage: | Server Storage: | Server Enabled: | Total License Keys: | Desktop Licenses: | Server Licenses: |
      | 381 GB                 | 198 GB           | 183 GB          | Yes             | 36                  | 19                | 17               |
    When I navigate to Purchase Resources section from bus admin console page
    And I purchase resources:
      | user group         | desktop license | desktop quota | server license | server quota |
      | default user group | 1               | 10            | 1              | 5            |
    Then Resources should be purchased
    When I navigate to Assign Keys section from bus admin console page
    Then Partner resources general information should be:
      | Total Account Storage: | Desktop Storage: | Server Storage: | Server Enabled: | Total License Keys: | Desktop Licenses: | Server Licenses: |
      | 396 GB                 | 208 GB           | 188 GB          | Yes             | 38                  | 20                | 18               |
    When I navigate to Return Unused Resources section from bus admin console page
    And I return resources:
      | user group         | desktop license | desktop quota | server license | server quota |
      | default user group | 1               | 10            | 1              | 5            |
    Then Resources should be returned
    When I refresh Assign Keys section
    Then Partner resources general information should be:
      | Total Account Storage: | Desktop Storage: | Server Storage: | Server Enabled: | Total License Keys: | Desktop Licenses: | Server Licenses: |
      | 381 GB                 | 198 GB           | 183 GB          | Yes             | 36                  | 19                | 17               |

  @TC.19869
  Scenario: 19869 New MozyPro bundle partner without sub partner can purchase resource
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 100 GB    |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 500 GB    | yes         |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19870
  Scenario: 19870 New Reseller Metallic partner without sub partner can purchase resources
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 100            |
    Then New partner should be created
    When I act as newly created partner account
    When I change Reseller account plan to:
      | server plan | storage add-on |
      | yes         | 2              |
    And the Reseller account plan should be changed
    And MozyPro new plan should be:
      | server plan | storage add-on |
      | yes         | 2              |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19873
  Scenario: 19873 New Enterprise partner without subpartner can purchase resources
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan | server add-on |
      | 15    | 100 GB      | 5             |
    Then the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan | server add-on |
      | 15    | 100 GB      | 5             |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19953
  Scenario: 19953 Existing MozyPro bundle partner without sub partner can purchase resource
    When I act as partner by:
      | email                          |
      | qa1+tc+19953+reserved@mozy.com |
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 100 GB    | yes         |
    Then the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | yes         |
    When I refresh Change Plan section
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 50 GB     | no          |
    Then the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 50 GB     | no          |


