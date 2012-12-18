Feature: Manage resources

  Background:
    Given I log in bus admin console as administrator

  @reseller_manage_resources_example
  Scenario: Reseller partner manage resources example
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | storage add on |
      | 12     | Silver        | 100            | yes         | 2              |
    Then New partner should be created
    When I act as newly created partner account
    And I allocate 10 GB Desktop quota with (default user group) user group to Reseller partner
    Then Reseller resource quota should be changed
    # Bug 90676
#    And User group general information should be:
#      | Total Storage: | Desktop Storage: | Server Storage: | Server Enabled: | Total License Keys: | Desktop Licenses: | Server Licenses: |
#      | 10 GB          | 10 GB            | 0 GB            | Yes             | 0                   | 0                 | 0                |
    And User group resources details table should be:
      |         | Active    | Assigned | Unassigned       |
      | Desktop | 0 bytes   | 0 bytes  | 10 GB   Change   |
      | Server  | 0 bytes   | 0 bytes  | 0 bytes   Change |
    And User group license details table should be:
      |         | Active | Assigned | Unassigned |
      | Desktop | 0      | 0        | 0          |
      | Server  | 0      | 0        | 0          |
    When I create 5 new Desktop keys for Reseller partner
    And I batch assign Reseller partner Desktop keys to (default user group) user group without send emails:
      | email                                  | quota |
      | qa1+reseller+assign+key+test1@mozy.com | 5     |
      | qa1+reseller+assign+key+test2@mozy.com | 10    |
    And I refresh Manage Resources section
    # Bug 90676
#    Then Partner resources general information should be:
#      | Total Account Storage: | Unallocated Storage: | Desktop Storage: | Server Storage: | Server Enabled: | Total License Keys: | Desktop Licenses: | Server Licenses: |
#      | 140 GB                 | 130 GB               | 10 GB            | 0 GB            | Yes             | 0                   | 0                 | 0                |
    And Partner total resources details table should be:
      |         | Active    | Assigned | Unassigned | Allocated |
      | Desktop | 0 bytes   | 15 GB    | 0 byte     | 10 GB     |
      | Server  | 0 bytes   | 0 bytes  | 0 bytes    | 0 bytes   |
    And Partner total license details table should be:
      |         | Active | Assigned | Unassigned |
      | Desktop | 0      | 2        | 3          |
      | Server  | 0      | 0        | 0          |
    And Partner user groups table should be:
      | Name                  | Active Storage | Allocated Storage |
      | (default user group)  | 0 GB           | 10 GB             |

  @mozypro_manage_resources_example
  Scenario: MozyPro partner manage resources example
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 12     | 500 GB    | yes         |
    Then New partner should be created
    When I act as newly created partner account
    And I allocate 200 GB Server quota to MozyPro partner
    Then MozyPro resource quota should be changed
    And Partner resources general information should be:
      | Total Account Storage: | Unallocated Storage: | Server Enabled: |
      | 500 GB                 | 50 GB                | Yes             |
    #And Partner total resources details table should be:
    #  |         | Active    | Assigned | Unassigned | Allocated       |
    #  | Desktop | 0 bytes   | 0 bytes  | 250 GB     | 250 GB   Change |
    #  | Server  | 0 bytes   | 0 bytes  | 200 GB     | 200 GB   Change |
    And Partner total license details table should be:
      |         | Active | Assigned | Unassigned |
      | Desktop | 0      | 0        | 10         |
      | Server  | 0      | 0        | 10         |
    And I batch assign MozyPro partner Desktop keys with send emails:
      | email                                  | quota |
      | qa1+mozypro+assign+key+test1@mozy.com  | 5     |
      | qa1+mozypro+assign+key+test2@mozy.com  | 10    |
    When I refresh Manage Resources section
    And Partner total license details table should be:
      |         | Active | Assigned | Unassigned |
      | Desktop | 0      | 2        | 8          |
      | Server  | 0      | 0        | 10         |
    #And Partner total resources details table should be:
    #  |         | Active    | Assigned | Unassigned | Allocated       |
    #  | Desktop | 0 bytes   | 15 GB    | 235 GB     | 250 GB   Change |
    #  | Server  | 0 bytes   | 0 bytes  | 200 GB     | 200 GB   Change |

  @mozyenterprise_manage_resources_example
  Scenario: MozyEnterprise partner manage resources example
    When I add a new MozyEnterprise partner:
      | period | users | server plan  | server add on |
      | 12     | 50    | 1 TB         | 2             |
    Then New partner should be created
    When I act as newly created partner account
    And I batch assign MozyEnterprise partner Server keys to (default user group) user group without send emails:
      | email                                         | quota |
      | qa1+mozyenterprise+assign+key+test1@mozy.com  | 5     |
      | qa1+mozyenterprise+assign+key+test2@mozy.com  | 10    |
      | qa1+mozyenterprise+assign+key+test3@mozy.com  | 15    |
    And I refresh Manage User Group Resources section
    # Bug 90676
    #And User group general information should be:
    #| Total Storage: | Desktop Storage: | Server Storage: | Server Enabled: | Total License Keys: | Desktop Licenses: | Server Licenses: |
    #| 10 GB          | 10 GB            | 0 GB            | Yes             | 0                   | 0                 | 0                |
    And User group resources details table should be:
      |         | Active    | Assigned | Unassigned |
      | Desktop | 0 bytes   | 0 bytes  | 1.2 TB     |
      | Server  | 0 bytes   | 30 GB    | 1.5 TB     |
    And User group license details table should be:
      |         | Active | Assigned | Unassigned |
      | Desktop | 0      | 0        | 0          |
      | Server  | 0      | 3        | 0          |

  @TC.18735 @Bug.84691 @regression
  Scenario: 18735 Verify unallocated storage auto refreshed when allocated storage changed
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 500 GB    |
    Then New partner should be created
    When I act as newly created partner account
    And I allocate 200 GB Desktop quota to MozyPro partner
    Then MozyPro resource quota should be changed
    And Partner resources general information should be:
      | Total Account Storage: | Unallocated Storage: | Server Enabled: |
      | 500 GB                 | 300 GB               | No              |
    # Bug 90677
    #And Partner total resources details table should be:
    #  |         | Active    | Assigned | Unassigned | Allocated       |
    #  | Desktop | 0 bytes   | 0 bytes  | 300 GB     | 200 GB   Change |