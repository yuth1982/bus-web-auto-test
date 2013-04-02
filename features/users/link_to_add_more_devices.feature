Feature: Link to More Devices

  As an admin (without UG enabled),
  I want a path to purchase more devices (previously known as keys) if I'm running out,
  So that I have a easy way to manage my resource needs.

  Success Criteria:
  - Next to the available desktop and server devices the admin will have a link for "add More"
  - "add more" will redirect the admin to change plan page where they can add more devices to the account

  Background:

  @TC.19977
	Scenario: Mozy-19977:Bundled (1UG), Verify Add More Link in Add New User
	    Given I log in bus admin console as administrator
    	When I add a new MozyPro partner:
    		| period | base plan | server plan |
    		| 1      | 50 GB     | yes         |
    	Then New partner should be created
    	When I act as newly created partner account
    	And I navigate to Add New User section from bus admin console page
    	Then the Buy More link should be visible
    	And the Buy More link should open the Change Plan module
    	Then I stop masquerading
    	And I search and delete partner account by newly created partner company name
		
	@TC.19920
	Scenario: Mozy-19920:Bundled (1UG), Verify Add More Link in Add New User(Bundled w\ UGs)
	    Given I log in bus admin console as administrator
    	When I add a new MozyPro partner:
    		| period | base plan | server plan |
    		| 1      | 50 GB     | yes         |
    	Then New partner should be created
    	When I change root role to Bundle Pro Partner Root
    	When I act as newly created partner account
    	And I navigate to Add New User section from bus admin console page
    	And I choose (default user group) from Choose a Group
    	Then the Add More link should be visible
    	And the Add More link should open the Change Plan module
    	Then I stop masquerading
    	And I search and delete partner account by newly created partner company name
	
	@TC.19951
	Scenario: Mozy-19951:Metallic Reseller (1UG), Verify Add More Link in Add New User
	    Given I log in bus admin console as administrator
    	When I add a new Reseller partner:
      		| period | reseller type | reseller quota |
      		| 1      | Silver        | 10             |
     	Then New partner should be created
       	When I act as newly created partner account
        And I navigate to Add New User section from bus admin console page
        And I choose (default user group) from Choose a Group
    	Then the Add More link should be visible
    	And the Add More link should open the Change Plan module
    	Then I stop masquerading
    	And I search and delete partner account by newly created partner company name
	
	@TC.19949
	Scenario: Mozy-19949:MozyPro Itemized (2UG), Verify Add More Link in Add New User
	    Given I log in bus admin console as administrator
      	When I act as partner by:
      		| name                                         |
      		| qa1+TestMozyProItemizedMonthly92066@mozy.com |
        And I navigate to Add New User section from bus admin console page
        And I choose User Group 1 from Choose a Group
        Then the Add More link should be visible
    	And the Add More link should open the Manage Resources module
	
	
	@TC.19948
	Scenario: Mozy-19948:Enterprise (2UG), Verify Add More Link in Add New User
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
    	And I choose User Group 1 from Choose a Group
        Then the Add More link should be visible
    	And the Add More link should open the Manage Resources module
    	Then I stop masquerading
    	And I search and delete partner account by newly created partner company name
	
	@TC.19947
	Scenario: Mozy-19947:EMEA(1UG), Ireland, Bundled, Verify Add More Link in Add New User
		Given I log in bus admin console as administrator
    	When I add a new MozyPro partner:
      		| period | base plan | server plan | country | create under    |
      		| 1      | 50 GB     | yes         | Ireland | MozyPro Ireland |
    	Then New partner should be created
    	When I act as newly created partner account
    	And I navigate to Add New User section from bus admin console page
    	Then the Buy More link should be visible
    	And the Buy More link should open the Change Plan module
    	Then I stop masquerading
    	And I search and delete partner account by newly created partner company name	
	
	@TC.19946
	Scenario: Mozy-19946:EMEA(1UG), UK, Enterprise, Verify Add More Link in Add New User
	    Given I log in bus admin console as administrator
    	When I add a new MozyEnterprise partner:
      		| period | users | server plan | country        |
      		| 12     | 10    | 250 GB      | United Kingdom |
    	Then New partner should be created
    	When I act as newly created partner account
    	And I navigate to Add New User section from bus admin console page
    	And I choose (default user group) from Choose a Group
    	Then the Add More link should be visible
    	And the Add More link should open the Change Plan module
    	Then I stop masquerading
    	And I search and delete partner account by newly created partner company name
	
	@TC.19945
	Scenario: Mozy-19945:EMEA(1UG), France, Metallic Reseller, Verify Add More Link in Add New User
        Given I log in bus admin console as administrator
    	When I add a new Reseller partner:
      		| period | reseller type | reseller quota | country | create under   |
      		| 1      | Gold          | 10             | France  | MozyPro France |
     	Then New partner should be created
       	When I act as newly created partner account
        And I navigate to Add New User section from bus admin console page
        And I choose (default user group) from Choose a Group
    	Then the Add More link should be visible
    	And the Add More link should open the Change Plan module
    	Then I stop masquerading
    	And I search and delete partner account by newly created partner company name       	
	
	@TC.19952
	Scenario: Mozy-19952:EMEA(1UG), Germany, MozyPro Itemized, Verify Add More Link in Add New User
	  	Given I log in bus admin console as administrator
	  	When I act as partner by:
            | name                                    |
            | qa1+testDEMozyProItemized90211@mozy.com |
        And I navigate to Add New User section from bus admin console page
        And I choose (default user group) from Choose a Group
    	Then the Add More link should be visible
    	And the Add More link should open the Change Plan module
	