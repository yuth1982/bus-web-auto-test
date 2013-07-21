Feature: User Resources

  As an admin, 
  I can drill down to the user and see what storage he is using as well as his storage allocation 
  so that I can quickly understand if I need to make a storage adjustment.

#  user details page changed, so these cases were invalid
#  @TC.19640 @bus @user_storage_details @bundled
#  Scenario: Mozy-19640:Access Partner as Partner Admin
#    Given I log in bus admin console as administrator
#    When I add a new MozyPro partner:
#      | period | base plan |
#      | 1      | 50 GB     |
#    Then New partner should be created
#  	And I activate new partner admin with default password
#    And I log out bus admin console
#    And I log in bus admin console as new partner admin
#    When I add a new user to a MozyPro partner:
#      | desired_user_storage | device_count | user type           |
#      | 10                   | 1            | Desktop Backup Only |
#    Then New user should be created	 
#    And I search user by:
#      | keywords   |
#      | @user_name |
#    Then user search results should be:
#      | User        | Name         | Machines | Storage | Storage Used | Created  | Backed Up |
#      | @user_email | @user_name   | 0 	      | 10 GB   | none  	   | today    | never     |
#    When I view user details by @user_email
#    Then user details should be:
#	  | Name:          | 
#      | @user (change) |
#    And user resources details headers should be:
#      || Storage Used / Assigned | Devices Activated | View License Keys  |
#	And user resources details rows should be:
#	  | Storage Used / Assigned | Devices Activated | View License Keys  |
#      | 0 / 10 GB (change)      | 0 / 1 (change)    | Reassign Device(s) |
#    And I log out bus admin console
#    Then I log in bus admin console as administrator
#    And I search and delete partner account by newly created partner name
#
#  @TC.19646 @bus @user_storage_details @metallic_resellers
#Scenario: Mozy-19646:Access Partner as Bus Admin
#    Given I log in bus admin console as administrator
#    When I add a new Reseller partner:
#      | period | reseller type | reseller quota |
#      | 1      | Silver        | 10             |
#    Then New partner should be created
#    When I act as newly created partner account
#    And I add a new user to a Reseller partner:
#      | desired_user_storage | device_count | user group           | user type           |
#      | 5                    | 1            | (default user group) | Desktop Backup Only |
#    Then New user should be created
#    When I search user by:
#      | keywords   |
#      | @user_name |
#    Then user search results should be:
#      | External ID | User        | Name       | User Group           | Machines | Storage | Storage Used | Created  | Backed Up |
#      |             | @user_email | @user_name | (default user group) | 0        | 5 GB    | none         | today    | never     |
#    When I view user details by @user_email
#    Then user details should be:
#      | ID:       | External ID: | Name:          | 
#      | @xxxxxxxx | (change)     | @user (change) | 
#    And user resources details headers should be:
#      || Storage Used / Assigned | Devices Activated | View License Keys  | 
#    And user resources details rows should be:
#      | Storage Used / Assigned | Devices Activated | View License Keys  |
#      | 0 / 5 GB (change)       | 0 / 1 (change)    | Reassign Device(s) |
#    When I stop masquerading
#    Then I search and delete partner account by newly created partner company name
#
#  @TC.19839 @bus @user_storage_details @itemized @reseller
#Scenario: Mozy-19839:Access Reseller Itemized Partner as Partner Admin
#	Given I navigate to bus admin console login page
#    And I log in bus admin console with user name qa1+testResellerItem90211@mozy.com and password test1234
#    When I add a new user to a Itemized partner:
#      | desired_user_storage | desktop licenses | user group           | user type           |
#      | 2                    | 1                | (default user group) | Desktop Backup Only |
#    Then New user should be created
#    When I search user by:
#      | keywords      | user type                                |
#      | @user_name    | qa1+testResellerItem90211@mozy.com Users |
#    Then user search results should be:
#      | User        | Name         | User Group           | Machines  | Storage | Storage Used | Created  | Backed Up |
#      | @user_email | @user_name   | (default user group) | 0         | 2 GB    | none         | today    | never     |
#    When I view user details by @user_email
#    Then user details should be:
#      | Name:          | 
#      | @user (change) | 
#    And user resources details headers should be:
#      || Storage Used / Assigned | Devices Activated | View License Keys  |
#    And user resources details rows should be:
#	  | Storage Used / Assigned | Devices Activated | View License Keys  |
#      | 0 / 2 GB (change)       | 0 / 1 (change)    | Reassign Device(s) |
#
#  @TC.19841 @bus @user_storage_details @mozypro @itemized
#Scenario: Mozy-19841: Access an MozyPro Itemized Partner's User's details as Bus Admin
#	Given I log in bus admin console as administrator
#  	When I act as partner by:
#      | name                              |
#      | qa1+testProItemized90211@mozy.com |
#    And I add a new user to a Itemized partner:
#      | desired_user_storage | desktop licenses | user group           | user type           |
#      | 2                    | 1                | (default user group) | Desktop Backup Only |
#    Then New user should be created
#        When I search user by:
#      | keywords   |
#      | @user_name |
#    Then user search results should be:
#      | External ID | User        | Name         | User Group           | Stash    | Machines | Storage | Storage Used | Created  | Backed Up |
#      |             | @user_email | @user_name   | (default user group) | Disabled | 0 	      | 2 GB    | none  	   | today    | never     |
#    When I view user details by @user_email
#    Then user details should be:
#      | ID:       | External ID: | Name:          | 
#      | @xxxxxxxx | (change)     | @user (change) | 
#    And user resources details headers should be:
#      || Storage Used / Assigned | Devices Activated | View License Keys  | 
#    And user resources details rows should be:
#      | Storage Used / Assigned | Devices Activated | View License Keys  |
#      | 0 / 2 GB (change)       | 0 / 1 (change)    | Reassign Device(s) |      
#       
#  @TC.19844 @bus @user_storage_details @enterprise
#Scenario: Mozy-19844: Access an Enterprise Partner's User's details as Partner Admin
#    Given I log in bus admin console as administrator
#    When I add a new MozyEnterprise partner:
#      | period | users | 
#      | 12     | 10    | 
#    Then New partner should be created
#  	And I activate new partner admin with default password
#    And I log out bus admin console
#    And I log in bus admin console as new partner admin
#    When I add a new user to a MozyEnterprise partner:
#      | desired_user_storage | desktop licenses | user group           | user type           |
#      | 10                   | 1                | (default user group) | Desktop Backup Only |
#    Then New user should be created	 
#    And I search user by:
#      | keywords   |
#      | @user_name |
#    Then user search results should be:
#      | User        | Name         | User Group           | Machines | Storage | Storage Used | Created  | Backed Up |
#      | @user_email | @user_name   | (default user group) | 0 	      | 10 GB   | none  	   | today    | never     |
#    When I view user details by @user_email
#    Then user details should be:
#	  | Name:          | 
#      | @user (change) |
#    And user resources details headers should be:
#      || Storage Used / Assigned | Devices Activated | View License Keys  |
#	And user resources details rows should be:
#	  | Storage Used / Assigned | Devices Activated | View License Keys  |
#      | 0 / 10 GB (change)      | 0 / 1 (change)    | Reassign Device(s) |
#    And I log out bus admin console
#    Then I log in bus admin console as administrator
#    And I search and delete partner account by newly created partner name
#      
#  @TC.19850 @bus @user_storage_details @emea @IE @bundled
#Scenario: Mozy-19850: Access an Irish Partner's User's details as Partner Admin
#    Given I log in bus admin console as administrator
#    When I add a new MozyPro partner:
#      | period | base plan | country | create under    |
#      | 1      | 50 GB     | Ireland | MozyPro Ireland |
#    Then New partner should be created
#  	And I activate new partner admin with default password
#    And I log out bus admin console
#    And I log in bus admin console as new partner admin
#    When I add a new user to a MozyPro partner:
#      | desired_user_storage | device_count | user type           |
#      | 10                   | 1            | Desktop Backup Only |    
#    Then New user should be created	 
#    And I search user by:
#      | keywords   |
#      | @user_name |
#    Then user search results should be:
#      | User        | Name         | Machines | Storage | Storage Used | Created  | Backed Up |
#      | @user_email | @user_name   | 0 	      | 10 GB   | none  	   | today    | never     |
#    When I view user details by @user_email
#    Then user details should be:
#	  | Name:          | 
#      | @user (change) |
#    And user resources details headers should be:
#      || Storage Used / Assigned | Devices Activated | View License Keys  |
#	And user resources details rows should be:
#	  | Storage Used / Assigned | Devices Activated | View License Keys  |
#      | 0 / 10 GB (change)      | 0 / 1 (change)    | Reassign Device(s) |
#    And I log out bus admin console
#    Then I log in bus admin console as administrator
#    And I search and delete partner account by newly created partner name  
#    
#  @TC.19853 @bus @user_storage_details @emea @UK @enterprise
#Scenario: Mozy-19853: Access an United Kingdom Partner's User's details as Partner Admin
#    Given I log in bus admin console as administrator
#    When I add a new MozyEnterprise partner:
#      | period | users | country        | 
#      | 12     | 10    | United Kingdom |
#    Then New partner should be created
#  	And I activate new partner admin with default password
#    And I log out bus admin console
#    And I log in bus admin console as new partner admin
#    When I add a new user to a MozyEnterprise partner:
#      | desired_user_storage | desktop licenses | user group           | user type           |
#      | 10                   | 1                | (default user group) | Desktop Backup Only |    
#    Then New user should be created	 
#    And I search user by:
#      | keywords   |
#      | @user_name |
#    Then user search results should be:
#      | User        | Name         | Machines | Storage | Storage Used | Created  | Backed Up |
#      | @user_email | @user_name   | 0 	      | 10 GB   | none  	   | today    | never     |
#    When I view user details by @user_email
#    Then user details should be:
#	  | Name:          | 
#      | @user (change) |
#    And user resources details headers should be:
#      || Storage Used / Assigned | Devices Activated | View License Keys  |
#	And user resources details rows should be:
#	  | Storage Used / Assigned | Devices Activated | View License Keys  |
#      | 0 / 10 GB (change)      | 0 / 1 (change)    | Reassign Device(s) |
#          And I log out bus admin console
#    Then I log in bus admin console as administrator
#    And I search and delete partner account by newly created partner name    
#
#  @TC.19856 @bus @user_storage_details @emea @FR @metallic_reseller
#Scenario: Mozy-19856:Access French Reseller's User's details as Bus Admin
#    Given I log in bus admin console as administrator
#    When I add a new Reseller partner:
#      | period | reseller type | reseller quota | country | create under   |
#      | 1      | Silver        | 10             | France  | MozyPro France |
#    Then New partner should be created
#    When I act as newly created partner account
#    And I add a new user to a Reseller partner:
#      | desired_user_storage | device_count | user group           | user type           |
#      | 5                    | 1            | (default user group) | Desktop Backup Only |    
#    Then New user should be created
#    When I search user by:
#      | keywords   |
#      | @user_name |
#    Then user search results should be:
#      | User        | Name         | Machines | Storage | Storage Used | Created  | Backed Up |
#      | @user_email | @user_name   | 0 	      | 10 GB   | none  	   | today    | never     |
#    When I view user details by @user_email
#    Then user details should be:
#      | ID:       | External ID: | Name:          | 
#      | @xxxxxxxx | (change)     | @user (change) | 
#    And user resources details headers should be:
#      || Storage Used / Assigned | Devices Activated | View License Keys  | 
#    And user resources details rows should be:
#      | Storage Used / Assigned | Devices Activated | View License Keys  |
#      | 0 / 10 GB (change)      | 0 / 1 (change)    | Reassign Device(s) |
#    When I stop masquerading
#    Then I search and delete partner account by newly created partner company name
#    
#  @TC.19859 @bus @user_storage_details @emea @DE @mozypro @itemized
#Scenario: Mozy-19859:Access German Partner's User's details as Bus Admin
#  	Given I log in bus admin console as administrator
#  	When I act as partner by:
#      | name                                    |
#      | qa1+testDEMozyProItemized90211@mozy.com |
#    And I add a new user to a Itemized partner:
#      | desired_user_storage | desktop licenses | user group           | user type           |
#      | 2                    | 1                | (default user group) | Desktop Backup Only |    
#    Then New user should be created
#        When I search user by:
#      | keywords   |
#      | @user_name |
#    Then user search results should be:
#      | External ID | User        | Name         | User Group           | Stash    | Machines | Storage | Storage Used | Created  | Backed Up |
#      |             | @user_email | @user_name   | (default user group) | Disabled | 0 	      | 2 GB    | none  	     | today    | never     |
#    When I view user details by @user_email
#    Then user details should be:
#      | ID:       | External ID: | Name:          | 
#      | @xxxxxxxx | (change)     | @user (change) | 
#    And user resources details headers should be:
#      || Storage Used / Assigned | Devices Activated | View License Keys  | 
#    And user resources details rows should be:
#      | Storage Used / Assigned | Devices Activated | View License Keys  |
#      | 0 / 2 GB (change)      | 0 / 1 (change)    | Reassign Device(s) |      
