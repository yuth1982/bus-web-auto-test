Feature: Add new user, user group device details

  As an admin,
  when I provision a user,
  I can see how many devices are available to assign to a user after I select the User Group
  so that I can make a decision if I need to purchase more or not.

  Success Criteria:
  I can see how many desktop devices are available
  I can see how many server devices are available
  If MP direct and no UGs available (only 1 UG), the available devices are automatically shown

  Background:
    Given I log in bus admin console as administrator

  @TC.19932 @bus @2.5 @user_centric_storage @add_new_user @devices
  Scenario: 19932 Devices Add New User (Single UG) Bundled
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 50 GB     | yes         | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    Then User group storage details table should be:
      | Storage(GB) | 50 |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19978 @bus @2.5 @user_centric_storage @add_new_user @devices
  Scenario: 19978 Devices Add New User (Mult UG) Bundled
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 50 GB     | yes         | yes       |
    Then New partner should be created
    When I change root role to Bundle Pro Partner Root
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then User group storage details table should be:
      | Storage(GB) | 50 |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19934 @bus @2.5 @user_centric_storage @add_new_user @devices @metallic
  Scenario: 19934 Devices Add New User (Single UG) Metallic Reseller
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 1      | Silver        | 10             | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then User group storage details table should be:
      | Storage(GB) | 10 |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

#    @TC.19944 This is duplicated with 20716
#    Scenario: Mozy-19944:Devices Add New User (Mult UG) Metallic Reseller
#      Given I log in bus admin console as administrator
#      When I add a new Reseller partner:
#        | period | reseller type | reseller quota | server plan |
#        | 1      | Silver        | 10             | yes         |
#      Then New partner should be created
#      When I act as newly created partner account
#      And I add a new user group:
#        | name         |
#        | User Group 1 |
#      Then New user group should be created
#      And I navigate to Add New User section from bus admin console page
#      And I choose User Group 1 from Choose a Group
#      Then desktop and server devices should not be displayed in Add New User module
#      And I stop masquerading
#      And I search and delete partner account by newly created partner company name

# Non storage pooled partner, move to 2.4
#    @TC.19935
#    Scenario: Mozy-19935:Devices Add New User (Single UG) Reseller Itemized
#      Given I log in bus admin console as administrator
#      When I act as partner by:
#        | name                               |
#        | qa1+test82143Itemizedcreseller@mozy.com |
#      And I navigate to Add New User section from bus admin console page
#      Then desktop and server devices should be displayed in Add New User module
#      And the user groups should not be visible in the Add New User module
#      When I note the desktop and server amounts in Add New User module for user group (default user group)
#      And I change Itemized account plan to:
#        | desktop licenses | server licenses |
#        | 2                | 2               |
#      Then the Itemized account plan should be changed
#      And I navigate to Add New User section from bus admin console page
#      Then I note the desktop and server amounts in Add New User module for user group (default user group)

# Non storage pooled partner, move to 2.4
#    @TC.19958
#    Scenario: Mozy-19958:Devices Add New User (Mult UG) Reseller Itemized
#    Given I log in bus admin console as administrator
#      	When I act as partner by:
#      		| name                               |
#      		| qa1+testResellerItem90211@mozy.com |
#        And I navigate to Add New User section from bus admin console page
#    	Then desktop and server devices should be displayed in Add New User module
#    	When I note the desktop and server amounts in Add New User module for user group User Group 1
#    	And go to transfer resources and change the number of devices:
#    		| desktop_device | server_device | target_group |
#    		| 2              | 2             | User Group 1 |
#        And I navigate to Add New User section from bus admin console page
#    	Then I note the desktop and server amounts in Add New User module for user group User Group 1

# Non storage pooled partner, move to 2.4
#  @TC.19936
#    Scenario: Mozy-19936:Devices Add New User (Single UG) MozyPro Itemized
#    Given I navigate to bus admin console login page
#    	And I log in bus admin console with user name qa1+TestMozyProItemizedBiennual92066@mozy.com and password test1234
#    	And I navigate to Add New User section from bus admin console page
#    	Then desktop and server devices should be displayed in Add New User module
#    	And the user groups should not be visible in the Add New User module
#    	When I note the desktop and server amounts in Add New User module for user group (default user group)
#    	And I change Itemized account plan to:
#    		| desktop licenses | server licenses |
#    		| 2                | 2               |
#        Then the Itemized account plan should be changed
#        And I navigate to Add New User section from bus admin console page
#    	Then I note the desktop and server amounts in Add New User module for user group (default user group)

# Non storage pooled partner, move to 2.4
#  @TC.19959
#    Scenario: Mozy-19959:Devices Add New User (Mult UG) MozyPro Itemized
#    Given I navigate to bus admin console login page
#    	And I log in bus admin console with user name qa1+TestMozyProItemizedMonthly92066@mozy.com and password test1234
#    	And I navigate to Add New User section from bus admin console page
#    	Then desktop and server devices should be displayed in Add New User module
#    	When I note the desktop and server amounts in Add New User module for user group User Group 1
#    	And go to transfer resources and change the number of devices:
#    		| desktop_device | server_device | target_group |
#    		| 2              | 2             | User Group 1 |
#        And I navigate to Add New User section from bus admin console page
#    	Then I note the desktop and server amounts in Add New User module for user group User Group 1

  @TC.19937 @bus @2.5 @user_centric_storage @add_new_user @devices @enterprise
  Scenario: 19937 Devices Add New User (Single UG) Enterprise
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then User group storage details table should be:
      | Desktop Storage (GB) | 250  |
      | Server Storage (GB)  | 100  |
      | Desktop Devices      | 10   |
      | Server Devices       | 200  |
    When I change MozyEnterprise account plan to:
      | users | server plan |
      | 15    | 250 GB      |
    Then the MozyEnterprise account plan should be changed
    And I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then User group storage details table should be:
      | Desktop Storage (GB) | 375  |
      | Server Storage (GB)  | 250  |
      | Desktop Devices      | 15   |
      | Server Devices       | 200  |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

# Non storage pooled partner
#  @TC.19960
#  Scenario: 19960 Devices Add New User (Multiple UG) Enterprise
#    When I add a new MozyEnterprise partner:
#      | period | users | server plan | net terms |
#      | 12     | 10    | 100 GB      | yes       |
#    Then New partner should be created
#    When I act as newly created partner account
#    And I add a new Itemized user group:
#      | name            | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
#      | TC.19960-Shared | Shared               | 2               | Shared              | 2              |
#    Then TC.19960-Shared user group should be created
#    When I navigate to Add New User section from bus admin console page
#    And I choose TC.19960-Shared from Choose a Group
#    Then User group storage details table should be:
#      | Desktop Storage (GB) | 250  |
#      | Server Storage (GB)  | 100  |
#      | Desktop Devices      | 2    |
#      | Server Devices       | 2    |
#    When I transfer resources from (default user group) to TC.19960-Shared with:
#      | server_licenses | desktop_licenses |
#      | 2               | 2                |
#    Then Resources should be transferred
#    When I navigate to Add New User section from bus admin console page
#    And I choose TC.19960-Shared from Choose a Group
#    Then User group storage details table should be:
#      | Desktop Storage (GB) | 250  |
#      | Server Storage (GB)  | 100  |
#      | Desktop Devices      | 4    |
#      | Server Devices       | 4    |
#    And I stop masquerading
#    And I search and delete partner account by newly created partner company name

  @TC.19938 @bus @2.5 @user_centric_storage @add_new_user @devices @IE @bundled @emea
  Scenario: 19938 Devices Add New User (Single UG) Bundled Ireland
    When I add a new MozyPro partner:
      | period | base plan | server plan | country | create under    | net terms |
      | 1      | 50 GB     | yes         | Ireland | MozyPro Ireland | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    Then User group storage details table should be:
      | Storage(GB) | 50 |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19939 @bus @2.5 @user_centric_storage @add_new_user @devices @UK @emea @enterprise
  Scenario: 19939 Change Plan after Add New User (Single UG) Enterprise UK
    When I add a new MozyEnterprise partner:
      | period | users | server plan | country        | net terms |
      | 12     | 10    | 100 GB      | United Kingdom | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then User group storage details table should be:
      | Desktop Storage (GB) | 250  |
      | Server Storage (GB)  | 100  |
      | Desktop Devices      | 10   |
      | Server Devices       | 200  |
    When I change MozyEnterprise account plan to:
      | users | server plan |
      | 15    | 250 GB      |
    Then the MozyEnterprise account plan should be changed
    And I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then User group storage details table should be:
      | Desktop Storage (GB) | 375  |
      | Server Storage (GB)  | 250  |
      | Desktop Devices      | 15   |
      | Server Devices       | 200  |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

# Non storage pooled partner, move to 2.4
#  @TC.19961
#  Scenario: 19961 Transfer Resources after Add New User (Multiple UG) Enterprise German
#    Given I log in bus admin console as administrator
#    When I add a new MozyEnterprise partner:
#        | period | users | server plan | country  | create under    | net terms |
#        | 12     | 10    | 250 GB      | German   | MozyPro Germany | yes       |
#    Then New partner should be created
#    When I act as newly created partner account
#    And I add a new Itemized user group:
#      | name            | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
#      | TC.19960-Shared | Shared               | 2               | Shared              | 2              |
#    Then TC.19960-Shared user group should be created
#    When I navigate to Add New User section from bus admin console page
#    And I choose TC.19960-Shared from Choose a Group
#    Then User group storage details table should be:
#      | Desktop Storage (GB) | 250  |
#      | Server Storage (GB)  | 100  |
#      | Desktop Devices      | 2    |
#      | Server Devices       | 2    |
#    When I transfer resources from (default user group) to TC.19960-Shared with:
#      | server_licenses | desktop_licenses |
#      | 2               | 2                |
#    Then Resources should be transferred
#    When I navigate to Add New User section from bus admin console page
#    And I choose TC.19960-Shared from Choose a Group
#    Then User group storage details table should be:
#      | Desktop Storage (GB) | 250  |
#      | Server Storage (GB)  | 100  |
#      | Desktop Devices      | 4    |
#      | Server Devices       | 4    |
#    And I stop masquerading
#    And I search and delete partner account by newly created partner company name

# Already tested with Ireland
#    @TC.19940
#    Scenario: Mozy-19940: Devices Add New User (Single UG) French Reseller
#        Given I log in bus admin console as administrator
#    	When I add a new Reseller partner:
#      		| period | reseller type | reseller quota | country | create under   |
#      		| 1      | Gold          | 10             | France  | MozyPro France |
#     	Then New partner should be created
#       	When I act as newly created partner account
#        And I navigate to Add New User section from bus admin console page
#    	Then desktop and server devices should not be displayed in Add New User module
#    	And I stop masquerading
#    	And I search and delete partner account by newly created partner company name

  @TC.19962 @bus @2.5 @user_centric_storage @add_new_user @devices @emea @FR @metallic
  Scenario: 19962 Change Plan after Add New User (Multiple UG) French Reseller
    Given I log in bus admin console as administrator
    When I add a new Reseller partner:
        | period | reseller type | reseller quota | server plan | country | create under   |
        | 1      | Silver        | 100            | yes         | France  | MozyPro France |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then User group storage details table should be:
      | Storage(GB) | 100 |
    When I change Reseller account plan to:
      | storage add-on |
      | 10             |
    And the Reseller account plan should be changed
    And I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then User group storage details table should be:
      | Storage(GB) | 300  |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

# Non storage pooled partner, move to 2.4
#    @TC.19941
#    Scenario: Mozy-19941: Devices Add New User (Single UG) German MozyPro Itemized
#	Given I navigate to bus admin console login page
#    	And I log in bus admin console with user name qa1+TestMozyProItemizedBiennual92066@mozy.com and password test1234
#    	And I navigate to Add New User section from bus admin console page
#    	Then desktop and server devices should be displayed in Add New User module
#    	And the user groups should not be visible in the Add New User module
#    	When I note the desktop and server amounts in Add New User module for user group (default user group)
#    	And I change Itemized account plan to:
#    		| desktop licenses | server licenses |
#    		| 2                | 2               |
#        Then the Itemized account plan should be changed
#        And I navigate to Add New User section from bus admin console page
#    	Then I note the desktop and server amounts in Add New User module for user group (default user group)
#
# Non storage pooled partner, move to 2.4
#    @TC.19963
#    Scenario: Mozy-19941: Devices Add New User (Mult UG) German MozyPro Itemized
#    Given I navigate to bus admin console login page
#    	And I log in bus admin console with user name qa1+TestMozyProItemizedMonthly92066@mozy.com and password test1234
#    	And I navigate to Add New User section from bus admin console page
#    	Then desktop and server devices should be displayed in Add New User module
#    	When I note the desktop and server amounts in Add New User module for user group User Group 1
#    	And go to transfer resources and change the number of devices:
#    		| desktop_device | server_device | target_group |
#    		| 2              | 2             | User Group 1 |
#        And I navigate to Add New User section from bus admin console page
#    	Then I note the desktop and server amounts in Add New User module for user group User Group 1