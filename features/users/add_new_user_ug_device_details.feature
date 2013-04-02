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

  @TC.19932
  Scenario: Mozy-19932:Devices Add New User (Single UG) Bundled
    Given I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 1      | 50 GB     | yes         |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    Then desktop and server devices should not be displayed in Add New User module
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

    @TC.19978
    Scenario: Mozy-19978:Devices Add New User (Mult UG) Bundled
      Given I log in bus admin console as administrator
      When I add a new MozyPro partner:
        | period | base plan | server plan |
        | 1      | 50 GB     | yes         |
      Then New partner should be created
      When I change root role to Bundle Pro Partner Root
      When I act as newly created partner account
      And I navigate to Add New User section from bus admin console page
      And I choose (default user group) from Choose a Group
      Then desktop and server devices should not be displayed in Add New User module
      And I stop masquerading
      And I search and delete partner account by newly created partner company name

    @TC.19934
    Scenario: Mozy-19934:Devices Add New User (Single UG) Metallic Reseller
      Given I log in bus admin console as administrator
      When I add a new Reseller partner:
        | period | reseller type | reseller quota |
        | 1      | Silver        | 10             |
      Then New partner should be created
      When I act as newly created partner account
      And I navigate to Add New User section from bus admin console page
      And I choose (default user group) from Choose a Group
      Then desktop and server devices should not be displayed in Add New User module
      And I stop masquerading
      And I search and delete partner account by newly created partner company name

    @TC.19944
    Scenario: Mozy-19944:Devices Add New User (Mult UG) Metallic Reseller
      Given I log in bus admin console as administrator
      When I add a new Reseller partner:
        | period | reseller type | reseller quota | server plan |
        | 1      | Silver        | 10             | yes         |
      Then New partner should be created
      When I act as newly created partner account
      And I add a new user group:
        | name         |
        | User Group 1 |
      Then New user group should be created
      And I navigate to Add New User section from bus admin console page
      And I choose User Group 1 from Choose a Group
      Then desktop and server devices should not be displayed in Add New User module
      And I stop masquerading
      And I search and delete partner account by newly created partner company name

    @TC.19935
    Scenario: Mozy-19935:Devices Add New User (Single UG) Reseller Itemized
      Given I log in bus admin console as administrator
      When I act as partner by:
        | name                               |
        | qa1+test82143Itemizedcreseller@mozy.com |
      And I navigate to Add New User section from bus admin console page
      Then desktop and server devices should be displayed in Add New User module
      And the user groups should not be visible in the Add New User module
      When I note the desktop and server amounts in Add New User module for user group (default user group)
      And I change Itemized account plan to:
        | desktop licenses | server licenses |
        | 2                | 2               |
      Then the Itemized account plan should be changed
      And I navigate to Add New User section from bus admin console page
      Then I note the desktop and server amounts in Add New User module for user group (default user group)

    @TC.19958
    Scenario: Mozy-19958:Devices Add New User (Mult UG) Reseller Itemized
    Given I log in bus admin console as administrator
      	When I act as partner by:
      		| name                               |
      		| qa1+testResellerItem90211@mozy.com |
        And I navigate to Add New User section from bus admin console page
    	Then desktop and server devices should be displayed in Add New User module
    	When I note the desktop and server amounts in Add New User module for user group User Group 1
    	And go to transfer resources and change the number of devices:
    		| desktop_device | server_device | target_group |
    		| 2              | 2             | User Group 1 |
        And I navigate to Add New User section from bus admin console page
    	Then I note the desktop and server amounts in Add New User module for user group User Group 1
    	
    @TC.19936
    Scenario: Mozy-19936:Devices Add New User (Single UG) MozyPro Itemized
    Given I navigate to bus admin console login page
    	And I log in bus admin console with user name qa1+TestMozyProItemizedBiennual92066@mozy.com and password test1234
    	And I navigate to Add New User section from bus admin console page
    	Then desktop and server devices should be displayed in Add New User module
    	And the user groups should not be visible in the Add New User module
    	When I note the desktop and server amounts in Add New User module for user group (default user group)
    	And I change Itemized account plan to:
    		| desktop licenses | server licenses | 
    		| 2                | 2               | 
        Then the Itemized account plan should be changed
        And I navigate to Add New User section from bus admin console page
    	Then I note the desktop and server amounts in Add New User module for user group (default user group)
    	
    @TC.19959
    Scenario: Mozy-19959:Devices Add New User (Mult UG) MozyPro Itemized
    Given I navigate to bus admin console login page
    	And I log in bus admin console with user name qa1+TestMozyProItemizedMonthly92066@mozy.com and password test1234
    	And I navigate to Add New User section from bus admin console page
    	Then desktop and server devices should be displayed in Add New User module
    	When I note the desktop and server amounts in Add New User module for user group User Group 1
    	And go to transfer resources and change the number of devices:
    		| desktop_device | server_device | target_group |
    		| 2              | 2             | User Group 1 |
        And I navigate to Add New User section from bus admin console page
    	Then I note the desktop and server amounts in Add New User module for user group User Group 1
    	
    @TC.19937
    Scenario: Mozy-19937:Devices Add New User (Single UG) Enterprise
    Given I log in bus admin console as administrator
    	When I add a new MozyEnterprise partner:
      		| period | users | server plan |
      		| 12     | 10    | 250 GB      |
    	Then New partner should be created
    	When I act as newly created partner account
    	And I navigate to Add New User section from bus admin console page
    	Then desktop and server devices should be displayed in Add New User module
    	When I note the desktop and server amounts in Add New User module for user group (default user group)
    	And I change MozyEnterprise account plan to:
    		| users | 
    		| 15    | 
        Then the Itemized account plan should be changed
        And I navigate to Add New User section from bus admin console page
    	Then I note the desktop and server amounts in Add New User module for user group (default user group)
    	And I stop masquerading
    	And I search and delete partner account by newly created partner company name
    	
	@TC.19960
	Scenario: Mozy-19960:Devices Add New User (Multiple UG) Enterprise
	Given I log in bus admin console as administrator
    	When I add a new MozyEnterprise partner:
      		| period | users | server plan |
      		| 12     | 10    | 250 GB      |
    	Then New partner should be created
    	And I activate new partner admin with default password
    	And I log out bus admin console
    	And I log in bus admin console as new partner admin
    	And I add a new user group:
      		| name         | 
      		| User Group 1 |
      	Then New user group should be created
      	And I navigate to Add New User section from bus admin console page
      	Then desktop and server devices should be displayed in Add New User module
      	When I note the desktop and server amounts in Add New User module for user group User Group 1
    	And go to transfer resources and change the number of devices:
    		| desktop_device | server_device | target_group |
    		| 2              | 2             | User Group 1 |
        And I navigate to Add New User section from bus admin console page
    	Then I note the desktop and server amounts in Add New User module for user group User Group 1
    	And I stop masquerading
    	And I search and delete partner account by newly created partner company name    	

    @TC.19938
    Scenario: Mozy-19938:Devices Add New User (Single UG) Bundled Irish
	    Given I log in bus admin console as administrator
    	When I add a new MozyPro partner:
      		| period | base plan | server plan | country | create under    |
      		| 1      | 50 GB     | yes         | Ireland | MozyPro Ireland |
    	Then New partner should be created
    	When I act as newly created partner account
    	And I navigate to Add New User section from bus admin console page
    	Then desktop and server devices should not be displayed in Add New User module
    	And I stop masquerading
    	And I search and delete partner account by newly created partner company name
    	    	
    @TC.19939
    Scenario: Mozy-19939: Devices Add New User (Single UG) Enterprise UK
        Given I log in bus admin console as administrator
    	When I add a new MozyEnterprise partner:
      		| period | users | server plan | country        |
      		| 12     | 10    | 250 GB      | United Kingdom |
    	Then New partner should be created
    	When I act as newly created partner account
    	And I navigate to Add New User section from bus admin console page
    	Then desktop and server devices should be displayed in Add New User module
    	When I note the desktop and server amounts in Add New User module for user group (default user group)
    	And I change MozyEnterprise account plan to:
    		| users | 
    		| 15    | 
        Then the Itemized account plan should be changed
        And I navigate to Add New User section from bus admin console page
    	Then I note the desktop and server amounts in Add New User module for user group (default user group)
    	And I stop masquerading
    	And I search and delete partner account by newly created partner company name
    	    	
    @TC.19961
    Scenario: Mozy-19961: Devices Add New User (Multiple UG) Enterprise UK
    	Given I log in bus admin console as administrator
    	When I add a new MozyEnterprise partner:
      		| period | users | server plan | country        |
      		| 12     | 10    | 250 GB      | United Kingdom |
    	Then New partner should be created
    	And I activate new partner admin with default password
    	And I log out bus admin console
    	And I log in bus admin console as new partner admin
    	And I add a new user group:
      		| name         | 
      		| User Group 1 |
      	Then New user group should be created
      	And I navigate to Add New User section from bus admin console page
      	Then desktop and server devices should be displayed in Add New User module
      	When I note the desktop and server amounts in Add New User module for user group User Group 1
    	And go to transfer resources and change the number of devices:
    		| desktop_device | server_device | target_group |
    		| 2              | 2             | User Group 1 |
        And I navigate to Add New User section from bus admin console page
    	Then I note the desktop and server amounts in Add New User module for user group User Group 1
    	And I stop masquerading
    	And I search and delete partner account by newly created partner company name
    	    
    @TC.19940
    Scenario: Mozy-19940: Devices Add New User (Single UG) French Reseller
        Given I log in bus admin console as administrator
    	When I add a new Reseller partner:
      		| period | reseller type | reseller quota | country | create under   |
      		| 1      | Gold          | 10             | France  | MozyPro France |
     	Then New partner should be created
       	When I act as newly created partner account
        And I navigate to Add New User section from bus admin console page
    	Then desktop and server devices should not be displayed in Add New User module
    	And I stop masquerading
    	And I search and delete partner account by newly created partner company name
    	    	
    @TC.19962
    Scenario: Mozy-19962: Devices Add New User (Multiple UG) French Reseller
        Given I log in bus admin console as administrator
    	When I add a new Reseller partner:
      		| period | reseller type | reseller quota | server plan | country | create under   |
      		| 1      | Silver        | 10             | yes         | France  | MozyPro France |
    	Then New partner should be created
    	And I activate new partner admin with default password
    	And I log out bus admin console
    	And I log in bus admin console as new partner admin
      	And I add a new user group:
      		| name         | 
      		| User Group 1 |
      	Then New user group should be created
      	And I navigate to Add New User section from bus admin console page
      	And I choose User Group 1 from Choose a Group
    	Then desktop and server devices should not be displayed in Add New User module
    	And I stop masquerading
    	And I search and delete partner account by newly created partner company name
    	    	
    @TC.19941
    Scenario: Mozy-19941: Devices Add New User (Single UG) German MozyPro Itemized
	Given I navigate to bus admin console login page
    	And I log in bus admin console with user name qa1+TestMozyProItemizedBiennual92066@mozy.com and password test1234
    	And I navigate to Add New User section from bus admin console page
    	Then desktop and server devices should be displayed in Add New User module
    	And the user groups should not be visible in the Add New User module
    	When I note the desktop and server amounts in Add New User module for user group (default user group)
    	And I change Itemized account plan to:
    		| desktop licenses | server licenses | 
    		| 2                | 2               | 
        Then the Itemized account plan should be changed
        And I navigate to Add New User section from bus admin console page
    	Then I note the desktop and server amounts in Add New User module for user group (default user group)
    	
    @TC.19963
    Scenario: Mozy-19941: Devices Add New User (Mult UG) German MozyPro Itemized
    Given I navigate to bus admin console login page
    	And I log in bus admin console with user name qa1+TestMozyProItemizedMonthly92066@mozy.com and password test1234
    	And I navigate to Add New User section from bus admin console page
    	Then desktop and server devices should be displayed in Add New User module
    	When I note the desktop and server amounts in Add New User module for user group User Group 1
    	And go to transfer resources and change the number of devices:
    		| desktop_device | server_device | target_group |
    		| 2              | 2             | User Group 1 |
        And I navigate to Add New User section from bus admin console page
    	Then I note the desktop and server amounts in Add New User module for user group User Group 1    			