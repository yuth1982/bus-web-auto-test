Feature: BUS smoke test
  pre-condition
  update environment:
  option 1: TEST_ENV = ENV['BUS_ENV'] || 'qa6' in test_sites/configs/configs_helper.rb
  option 2: export BUS_ENV=<environment>

  Background:
    Given I log in bus admin console as administrator

  @bus_us @TC.125934
  Scenario: Test Case Mozy-125934: BUS US -- Log into BUS
    Given I log in bus admin console as administrator

  @bus_us @TC.125935
  Scenario: Test Case Mozy-125935: BUS US -- Create a new partner
    When I add a new MozyPro partner:
      | company name           | period | base plan | coupon                | net terms | server plan | root role               |
      | MozyPro BUS Smoke Test | 24     | 10 GB     | <%=QA_ENV['coupon']%> | yes       | yes         | Bundle Pro Partner Root |
    Then New partner should be created

  @bus_us @TC.125936
  Scenario: Test Case Mozy-125936: BUS US -- Partner Details - License Keys
    When I search partner by MozyPro BUS Smoke Test
    And I view partner details by MozyPro BUS Smoke Test
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 10        | 10       | 0    | Unlimited | Unlimited |

  @bus_us @TC.125937
  Scenario: Test Case Mozy-125937: BUS US -- Verify partner creation in Aria
    When I search partner by MozyPro BUS Smoke Test
    And I view partner details by MozyPro BUS Smoke Test
    And I get partner aria id
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |

  @bus_us @TC.125938
  Scenario: Test Case Mozy-125938: BUS US -- Activate partner in email
    When I add a new Reseller partner:
      | company name            | period | base plan | coupon                | net terms | server plan |
      | Reseller BUS Smoke Test | 1      | 50 GB     | <%=QA_ENV['coupon']%> | yes       | yes         |
    And New partner should be created
    And the standard partner has activated the admin account
    And I go to account
    Then I login as mozypro admin successfully

  @bus_us @TC.125939
  Scenario: Test Case Mozy-125939: BUS US -- Masquerade into the partner
    When I act as partner by:
      | name                   |
      | MozyPro BUS Smoke Test |

  @bus_us @TC.125940
  Scenario: Test Case Mozy-125940: BUS US -- Create a user group
    When I act as partner by:
      | name                   |
      | MozyPro BUS Smoke Test |
    And I add a new Bundled user group:
      | name  | storage_type |
      | alpha | Shared       |
    Then alpha user group should be created
    When I add a new Bundled user group:
      | name  | storage_type | limited_quota | enable_stash | server_support |
      | omega | Limited      | 5             | yes          | yes            |
    Then omega user group should be created

  @bus_us @TC.125941
  Scenario: Test Case Mozy-125941: BUS US -- Create a user
    When I act as partner by:
      | name                   |
      | MozyPro BUS Smoke Test |
    When I add new user(s):
      | name               | user_group | storage_type |  devices |
      | user without stash | alpha      | Desktop      |  1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by user without stash
    Then user details should be:
      | Name:                       |
      | user without stash (change) |

  @bus_us @TC.125942
  Scenario: Test Case Mozy-125942: BUS US -- Update a username & password
    When I act as partner by:
      | name                   |
      | MozyPro BUS Smoke Test |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by user without stash
    When edit user details:
      | email                  |
      | <%=create_user_email%> |
    Then I update the user password to Test1234

  @bus_us @TC.125943
  Scenario: Test Case Mozy-125943: BUS US -- Move the user from one user group to a different user group
    When I act as partner by:
      | name                   |
      | MozyPro BUS Smoke Test |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by user without stash
    But I reassign the user to user group omega
    Then the user's user group should be omega
    When I close user details section

  @bus_us @TC.125944
  Scenario: Test Case Mozy-125944: BUS US -- User Details - Send Keys
    When I act as partner by:
      | name                   |
      | MozyPro BUS Smoke Test |
    And I add new user(s):
      | name            | user_group | storage_type | storage_limit | devices | enable_stash |
      | user with stash | omega      | Desktop      | 2             | 3       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by user with stash
    Then user details should be:
      | Name:                    | Enable Sync:                |
      | user with stash (change) | Yes (Send Invitation Email) |
    And I view the user's product keys
    Then Number of Desktop activated keys should be 0
    And Number of Desktop unactivated keys should be 3
    When I click Send Keys button
    And I search emails by keywords:
      | content                |
      | <%=@unactivated_keys%> |
    Then I should see 1 email(s)

  @bus_us @TC.125945
  Scenario: Test Case Mozy-125945: BUS US -- User Details - Change Partners
    When I add a new OEM partner:
      | Company Name                     | Root role         | Security | Company Type     |
      | Internal Mozy OEM BUS Smoke Test | OEM Partner Admin | HIPAA    | Service Provider |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name         | Type          | Parent            |
      | new OEM role | Partner admin | OEM Partner Admin |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for OEM partner:
      | Name    | Company Type | Root Role    | Enabled | Public | Currency | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes | Desktop Price per key | Desktop Min keys | Desktop Price per gigabyte | Desktop Min gigabytes | Grandfathered Price per key | Grandfathered Min keys | Grandfathered Price per gigabyte | Grandfathered Min gigabytes |
      | subplan | business     | new OEM role | Yes     | No     |          | yearly  | 10             | test     | false            | 1                    | 1               | 1                         | 1                    | 1                     | 1                | 1                          | 1                     | 1                           | 1                      | 1                                | 1                           |
    And I add a new sub partner:
      | Company Name  | Pricing Plan | Admin Name |
      | subpartner1   | subplan      | subadmin1  |
    Then New partner should be created
    When I act as newly created subpartner account
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    Then Resources should be purchased
    And Current purchased resources should increase:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    And I add new itemized user(s):
      | name     | devices_server | quota_server | devices_desktop | quota_desktop |
      | oem user | 1              | 10           | 1               | 10            |
    And new itemized user should be created
    When I stop masquerading from subpartner
    And I add a new sub partner:
      | Company Name  | Pricing Plan | Admin Name |
      | subpartner2   | subplan      | subadmin2  |
    Then New partner should be created
    And I navigate to Search / List Users section from bus admin console page
    And I view user details by oem user
    When I reassign the user to partner subpartner2
    Then I stop masquerading as sub partner
    And I search partner by subpartner1
    And I view partner details by subpartner1
    And I delete partner account
    And I search partner by subpartner2
    And I view partner details by subpartner2
    And I delete partner account
    And I search partner by Internal Mozy OEM BUS Smoke Test
    And I view partner details by Internal Mozy OEM BUS Smoke Test
    And I delete partner account

  @bus_us @TC.125946
  Scenario: Test Case Mozy-125946: BUS US -- Create a machine, search list machine and view machine details
    When I act as partner by:
      | name                   |
      | MozyPro BUS Smoke Test |
    When I navigate to Search / List Machines section from bus admin console page
    Then Search list machines section is opened

  @bus_us @TC.125947
  Scenario: Test Case Mozy-125947: BUS US -- Create an admin
    When I act as partner by:
      | name                   |
      | MozyPro BUS Smoke Test |
    When I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name      | User Group           | Roles                   |
      | sub admin | (default user group) | Bundle Pro Partner Root |
    Then Add New Admin success message should be displayed

  @bus_us @TC.125948
  Scenario: Test Case Mozy-125948: BUS US -- Create a role
    When I act as partner by:
      | name                   |
      | MozyPro BUS Smoke Test |
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name     |
      | new role |
    And I check all the capabilities for the new role
    And I close the role details section
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name                | Roles    |
      | admin with new role | new role |
    Then Add New Admin success message should be displayed

  @bus_us @TC.125949
  Scenario: Test Case Mozy-125949: BUS US -- Create a client config
    When I act as partner by:
      | name                   |
      | MozyPro BUS Smoke Test |
    When I create a new client config:
      | name                 | type   |
      | deploy_client_config | Server |
    Then client configuration section message should be Your configuration was saved.

  @bus_us @TC.125950
  Scenario: Test Case Mozy-125950: BUS US -- Open all of the Resources header to open all of the modules
    When I act as partner by:
      | name                   |
      | MozyPro BUS Smoke Test |
    Given I navigate to Resource Summary section from bus admin console page
    When I navigate to User Group List section from bus admin console page
    Then I navigate to Change Plan section from bus admin console page
    And  I navigate to Billing Information section from bus admin console page
    But  I navigate to Billing History section from bus admin console page
    Then I navigate to Change Payment Information section from bus admin console page
    When I navigate to Download * Client section from bus admin console page

  @bus_us @TC.125951
  Scenario: Test Case Mozy-125951: BUS US -- Change plan for the partner
    When I search partner by MozyPro BUS Smoke Test
    And I view partner details by MozyPro BUS Smoke Test
    When I act as partner by:
      | name                   |
      | MozyPro BUS Smoke Test |
    And I change MozyPro account plan to:
      | base plan |
      | 50 GB     |
#    Then Change plan charge summary should be:
#      | Description                   | Amount   |
#      | Credit for remainder of plans | -$293.58 |
#      | Charge for upgraded plans     | $566.58  |
#      |                               |          |
#      | Total amount to be charged    | $273.00  |
    And the MozyPro account plan should be changed
    Then MozyPro new plan should be:
      | base plan | server plan |
      | 50 GB     | yes         |
    Then I stop masquerading
    And I search partner by MozyPro BUS Smoke Test
    And I view partner details by MozyPro BUS Smoke Test
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 50        | 50       | 0    | Unlimited | Unlimited |

  @bus_us @TC.125952
  Scenario: Test Case Mozy-125952: BUS US -- Run a report
    When I add a new MozyPro partner:
      | company name                  | period | base plan | coupon                | net terms |
      | MozyPro BUS Smoke Test Report | 12     | 10 GB     | <%=QA_ENV['coupon']%> | yes       |
    Then New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 10        | 10       | 0    | Unlimited | Unlimited |
    When I act as newly created partner account
    When I build a new report:
      | type            | name                |
      | Billing Detail  | billing detail test |
    Then Billing detail report should be created
    And Scheduled report list should be:
      | Name                | Type            | Schedule | Actions |
      | billing detail test | Billing Detail  | Daily    | Run     |
    When I download billing detail test scheduled report
    Then Scheduled Billing Detail report csv file details should be:
      | Column A | Column B              | Column C     | Column D           | Column E                    | Column F                    | Column G               | Column H              | Column I              | Column J                               | Column K                     | Column L                     | Column M                | Column N               | Column O               | Column P                                | Column Q                           | Column R                            | Column S               |
      | Partner  | User Group            | Billing Code | Total GB Purchased | Server GB Purchased         | Server Quota Allocated (GB) | Server Quota Used (GB) | Server Keys Purchased | Server Keys Activated | Server Keys Assigned But Not Activated | Desktop GB Purchased         | Desktop Quota Allocated (GB) | Desktop Quota Used (GB) | Desktop Keys Purchased | Desktop Keys Activated | Desktop Keys Assigned But Not Activated | Effective price per Server license | Effective price per Desktop license | Effective price per GB |
      | @name    | (default user group)  |              | Shared             | N/A                         | N/A                         | 0                      | 0                     | 0                     | 0                                      | N/A                          | N/A                          | 0                       | 0                      | 0                      | 0                                       |                                    |                                     | $1                  |
    When I delete billing detail test scheduled report
    Then I should see No results found in scheduled reports list
    When I download Credit Card Transactions (CSV) quick report
    Then Quick report Credit Card Transactions csv file details should be:
      | Column A | Column B | Column C | Column D  |
      | Date     | Amount   | Card #   | Card Type |
    When I stop masquerading
    Then I delete partner and verify pending delete

  @bus_us @TC.125953 @support @qa6
  Scenario: Test Case Mozy-125953: BUS US -- Check the support link
    When I act as partner by:
      | name               |
      | Rainbow MozyPro US |
    When I navigate to Contact section from bus admin console page
    And I click my support
    Then I login my support successfully

  @bus_us @TC.125953 @support @prod
  Scenario: Test Case Mozy-125953: BUS US -- Check the support link
    When I act as partner by:
      | name                   |
      | MozyPro BUS Smoke Test |
    When I navigate to Contact section from bus admin console page
    And I click my support
    Then I login my support successfully

  @bus_us @TC.125954 @qa
  Scenario: Test Case Mozy-125954: BUS US -- Order Data Shuttle
    When I add a new MozyPro partner:
      | company name                        | period | base plan | coupon                | net terms | server plan | root role               |
      | MozyPro BUS Smoke Test Data Shuttle | 24     | 10 GB     | <%=QA_ENV['coupon']%> | yes       | yes         | Bundle Pro Partner Root |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | name              | user_group           | storage_type | storage_limit | devices |
      | user with machine | (default user group) | Desktop      | 5             | 1       |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for MozyPro BUS Smoke Test Data Shuttle
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 5     |
    Then Data shuttle order should be created

  @bus_us @TC.125955 @qa
  Scenario: Test Case Mozy-125955: BUS US -- Update Data Shuttle
    When I search order in view data shuttle orders section by MozyPro BUS Smoke Test Data Shuttle
    And I view data shuttle order details
    And I add drive to data shuttle order
    Then Add drive to data shuttle order message should include Successfully added drive to order

  @bus_us @TC.125956
  Scenario: Test Case Mozy-125956: BUS US -- Delete test user
    When I act as partner by:
      | name                   |
      | MozyPro BUS Smoke Test |
    When I add new user(s):
      | name           | user_group | storage_type |  devices |
      | user to delete | omega      | Server       |  1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by user to delete
    Then user details should be:
      | Name:                   |
      | user to delete (change) |
    And I delete user

  @bus_us @TC.125957
  Scenario: Test Case Mozy-125957: BUS US -- Delete test user group
    When I act as partner by:
      | name                   |
      | MozyPro BUS Smoke Test |
    When I add a new Bundled user group:
      | name  | storage_type | assigned_quota | enable_stash | server_support |
      | gamma | Assigned     | 3              | yes          | yes            |
    Then gamma user group should be created
    When I navigate to User Group List section from bus admin console page
    And I delete user group details by name: gamma
    Then gamma user group should be deleted

  @bus_us @TC.125958
  Scenario: Test Case Mozy-125958: BUS US -- Delete test partner and validate they are in Pending Delete state
    And I search partner by MozyPro BUS Smoke Test
    And I view partner details by MozyPro BUS Smoke Test
    And I delete partner account

  @bus_us @TC.125959
  Scenario: Test Case Mozy-125959: BUS US -- Create a Pro partner and verify Partner creation in BUS and Aria
    When I add a new Reseller partner:
      | company name            | period | base plan | coupon                | net terms | server plan |
      | Reseller BUS Smoke Test | 1      | 50 GB     | <%=QA_ENV['coupon']%> | yes       | yes         |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |
    But I activate the partner

  @bus_us @TC.125960
  Scenario: Test Case Mozy-125960: BUS US -- Create a Enterprise partner and verify Partner creation in BUS and Aria
    When I add a new MozyEnterprise partner:
      | company name                  | period | users  | coupon                |  server plan | net terms |
      | MozyEnterprise BUS Smoke Test | 36     | 10     | <%=QA_ENV['coupon']%> |  100 GB      | yes       |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |
    But I activate the partner

  @bus_us @TC.125961
  Scenario: Test Case Mozy-125961: BUS US -- Create a new Fortress partner and verify Partner creation in BUS and Aria
    When I act as partner by:
      | name     | including sub-partners |
      | Fortress | no                     |
    And I add a new sub partner:
      | Company Name                          |
      | Internal Mozy Fortress BUS Smoke Test |
    Then New partner should be created
    When I stop masquerading

  @bus_emea @TC.125963
  Scenario: Test Case Mozy-125963: BUS EMEA -- Log into BUS
    Given I log in bus admin console as administrator

  @bus_emea @TC.125964
  Scenario: Test Case Mozy-125964: BUS EMEA -- Create a new partner (No VAT Number)
    When I add a new MozyPro partner:
      | company name                  | period  | base plan | create under   | server plan | net terms | country | coupon                |
      | MozyPro France BUS Smoke Test | 12      | 50 GB     | MozyPro France | yes         | yes       | France  | <%=QA_ENV['coupon']%> |
    And New partner should be created
    And I change root role to Business Root

  @bus_emea @TC.125965
  Scenario: Test Case Mozy-125965: BUS EMEA -- Verify partner creation in Aria
    When I search partner by MozyPro France BUS Smoke Test
    And I view partner details by MozyPro France BUS Smoke Test
    And I get partner aria id
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |

  @bus_emea @TC.125966
  Scenario: Test Case Mozy-125966: BUS EMEA -- Activate partner in email
    When I add a new Reseller partner:
      | company name                    | period | base plan | create under    | server plan | net terms | country | coupon                |
      | Reseller Ireland BUS Smoke Test | 12     | 10 GB     | MozyPro Ireland | yes         | yes       | Ireland | <%=QA_ENV['coupon']%> |
    And New partner should be created
    And the standard partner has activated the admin account
    And I go to account
    Then I login as mozypro admin successfully
    When I log in bus admin console as administrator
    Then I delete partner and verify pending delete

  @bus_emea @TC.125967
  Scenario: Test Case Mozy-125967: BUS EMEA -- Masquerade into the partner
    When I act as partner by:
      | name                          |
      | MozyPro France BUS Smoke Test |

  @bus_emea @TC.125968
  Scenario: Test Case Mozy-125968: BUS EMEA -- Create a user group
    When I act as partner by:
      | name                          |
      | MozyPro France BUS Smoke Test |
    When I add a new Bundled user group:
      | name         | storage_type |
      | test-group-1 | Shared       |
    Then test-group-1 user group should be created

  @bus_emea @TC.125969
  Scenario: Test Case Mozy-125969: BUS EMEA -- Create a user
    When I act as partner by:
      | name                          |
      | MozyPro France BUS Smoke Test |
    And I add new user(s):
      | name        | user_group   | storage_type  | storage_limit | devices |
      | EMEA-user-1 | test-group-1 | Desktop       | 10            | 1       |
    Then 1 new user should be created

  @bus_emea @TC.125970
  Scenario: Test Case Mozy-125970: BUS EMEA -- Move the user from one user group to a different user group
    When I act as partner by:
      | name                          |
      | MozyPro France BUS Smoke Test |
    And  I navigate to Search / List Users section from bus admin console page
    And I view user details by EMEA-user-1
    And I reassign the user to user group (default user group)
    Then the user's user group should be (default user group)

  @bus_emea @TC.125971
  Scenario: Test Case Mozy-125971: BUS EMEA -- Create a client config
    When I act as partner by:
      | name                          |
      | MozyPro France BUS Smoke Test |
    When I create a new client config:
      | name                | user group   | type   |
      | smoke_client_config | group-test-1 | Server |
    Then client configuration section message should be Your configuration was saved.

  @bus_emea @TC.125972
  Scenario: Test Case Mozy-125972: BUS EMEA -- Open all of the Resources header to open all of the modules
    When I act as partner by:
      | name                          |
      | MozyPro France BUS Smoke Test |
    Given I navigate to Resource Summary section from bus admin console page
    When I navigate to User Group List section from bus admin console page
    Then I navigate to Change Plan section from bus admin console page
    And  I navigate to Billing Information section from bus admin console page
    But  I navigate to Billing History section from bus admin console page
    Then I navigate to Change Payment Information section from bus admin console page
    When I navigate to Download * Client section from bus admin console page

  @bus_emea @TC.125973
  Scenario: Test Case Mozy-125973: BUS EMEA -- Run a report
    When I add a new MozyPro partner:
      | company name                  | period  | base plan | create under   | net terms | country | coupon                |
      | MozyPro France BUS Smoke Test | 12      | 50 GB     | MozyPro France | yes       | France  | <%=QA_ENV['coupon']%> |
    Then New partner should be created
    When I act as newly created partner account
    When I build a new report:
      | type            | name                |
      | Billing Detail  | billing detail test |
    Then Billing detail report should be created
    And Scheduled report list should be:
      | Name                | Type            | Schedule | Actions |
      | billing detail test | Billing Detail  | Daily    | Run     |
    When I download billing detail test scheduled report
    Then Scheduled Billing Detail report csv file details should be:
      | Column A | Column B              | Column C     | Column D           | Column E                    | Column F                    | Column G               | Column H              | Column I              | Column J                               | Column K                     | Column L                     | Column M                | Column N               | Column O               | Column P                                | Column Q                           | Column R                            | Column S               |
      | Partner  | User Group            | Billing Code | Total GB Purchased | Server GB Purchased         | Server Quota Allocated (GB) | Server Quota Used (GB) | Server Keys Purchased | Server Keys Activated | Server Keys Assigned But Not Activated | Desktop GB Purchased         | Desktop Quota Allocated (GB) | Desktop Quota Used (GB) | Desktop Keys Purchased | Desktop Keys Activated | Desktop Keys Assigned But Not Activated | Effective price per Server license | Effective price per Desktop license | Effective price per GB |
      | @name    | (default user group)  |              | Shared             | N/A                         | N/A                         | 0                      | 0                     | 0                     | 0                                      | N/A                          | N/A                          | 0                       | 0                      | 0                      | 0                                       |                                    |                                     | ?0.80                  |
    When I delete billing detail test scheduled report
    Then I should see No results found in scheduled reports list
    When I download Credit Card Transactions (CSV) quick report
    Then Quick report Credit Card Transactions csv file details should be:
      | Column A | Column B | Column C | Column D  |
      | Date     | Amount   | Card #   | Card Type |
    When I stop masquerading
    Then I delete partner and verify pending delete

  @bus_us @TC.125974 @support @qa6
  Scenario: Test Case Mozy-125974: BUS EMEA -- Check the support link
    When I act as partner by:
      | name                 |
      | Rainbow MozyPro EMEA |
    When I navigate to Contact section from bus admin console page
    And I click my support
    Then I login my support successfully

  @bus_us @TC.125974 @support @prod
  Scenario: Test Case Mozy-125974: BUS EMEA -- Check the support link
    When I act as partner by:
      | name                          |
      | MozyPro France BUS Smoke Test |
    When I navigate to Contact section from bus admin console page
    And I click my support
    Then I login my support successfully

  @bus_emea @TC.125975 @qa
  Scenario: Test Case Mozy-125975: BUS EMEA -- Order Data Shuttle
    When I add a new MozyPro partner:
      | company name                               | period  | base plan | create under   | server plan | net terms | country | coupon                |
      | MozyPro France BUS Smoke Test Data Shuttle | 12      | 50 GB     | MozyPro France | yes         | yes       | France  | <%=QA_ENV['coupon']%> |
    And New partner should be created
    And I change root role to Business Root
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type  | storage_limit | devices |
      | (default user group) | Desktop       | 10            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for MozyPro France BUS Smoke Test Data Shuttle
      | power adapter     | key from  | quota |
      | Data Shuttle EMEA | available | 10    |
    Then Data shuttle order should be created

  @bus_emea @TC.125976 @qa
  Scenario: Test Case Mozy-125976: BUS EMEA -- Update Data Shuttle
    When I search order in view data shuttle orders section by MozyPro France BUS Smoke Test Data Shuttle
    And I view data shuttle order details
    And I add drive to data shuttle order
    Then Add drive to data shuttle order message should include Successfully added drive to order
    And I search partner by MozyPro BUS Smoke Test
    And I view partner details by MozyPro BUS Smoke Test
    And I delete partner account

  @bus_emea @TC.125977
  Scenario: Test Case Mozy-125977: BUS EMEA -- Delete test user
    When I act as partner by:
      | name                          |
      | MozyPro France BUS Smoke Test |
    And  I navigate to Search / List Users section from bus admin console page
    And I view user details by EMEA-user-1
    And I delete user

  @bus_emea @TC.125978
  Scenario: Test Case Mozy-125978: BUS EMEA -- Delete test user group
    When I act as partner by:
      | name                          |
      | MozyPro France BUS Smoke Test |
    When I add a new Bundled user group:
      | name         | storage_type |
      | test-group-2 | Shared       |
    Then test-group-2 user group should be created
    When I delete user group details by name: test-group-2

  @bus_emea @TC.125979
  Scenario: Test Case Mozy-125979: BUS EMEA -- Delete test partner and validate they are in Pending Delete state
    And I search partner by MozyPro France BUS Smoke Test
    And I view partner details by MozyPro France BUS Smoke Test
    And I delete partner account

  @bus_emea @TC.125980
  Scenario: Test Case Mozy-125980: BUS EMEA -- Create a new partner (With VAT Number)
    When I add a new MozyPro partner:
      | period | base plan | create under | server plan | net terms | country        | coupon                | vat number  |
      | 1      | 10 GB     | MozyPro UK   | yes         | yes       | United Kingdom | <%=QA_ENV['coupon']%> | GB117223643 |
    And New partner should be created
    Then I delete partner and verify pending delete

  @bus_us @TC.125983
  Scenario: Test Case Mozy-125983: LDAP Pull
    When I search partner by:
      | name                          |
      | MozyEnterprise BUS Smoke Test |
    And I view partner details by MozyEnterprise BUS Smoke Test
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | dev  | Shared               | 5               | Shared              | 10             |
    Then dev user group should be created
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I input server connection settings
      | Server Host  | Protocol | SSL Cert | Port | Base DN                      | Bind Username             | Bind Password |
      | 10.29.99.120 | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local | admin@mtdev.mozypro.local | abc!@#123     |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed
    And I click Sync Rules tab
    And I add 1 new provision rules:
      | rule               | group |
      | cn=dev-17538-test* | dev   |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)  |
      | Sync Result | Users Provisioned: 3 succeeded, 0 failed \| Users Deprovisioned: 0 |
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by User desc
#    Then User search results should be:
#      | User                     | Name            | User Group |
#      | dev-17538-test3@test.com | dev-17538-test3 | dev        |
#      | dev-17538-test2@test.com | dev-17538-test2 | dev        |
#      | dev-17538-test1@test.com | dev-17538-test1 | dev        |
    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule               | action |
      | cn=dev-17538-test* | Delete |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 1 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)  |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 3 succeeded, 0 failed |
    When I navigate to Search / List Users section from bus admin console page
    Then The users table should be empty
    When I stop masquerading
    And I search partner by MozyEnterprise BUS Smoke Test
    And I view partner details by MozyEnterprise BUS Smoke Test
    And I delete partner account
