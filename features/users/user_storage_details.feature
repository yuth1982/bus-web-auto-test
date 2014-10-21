Feature: User Resources

  As an admin,
  I can drill down to the user and see what storage he is using as well as his storage allocation
  so that I can quickly understand if I need to make a storage adjustment.

  @TC.19640 @bus @user_storage_details @bundled @desktop
  Scenario: Mozy-19640:Access Partner as Partner Admin
    Given I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    And I add new user(s):
      | storage_type | devices |
      | Desktop      | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    Then User search results should be:
      | User        | Name         | Machines | Storage | Storage Used | Created  | Backed Up |
      | @user_email | @user_name   | 0 	      | Shared  | None  	   | today    | never     |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                           |
      | <%=@users.first.name%> (change) |
    And user resources details rows should be:
      | Storage                  | Devices                             |
      | 0 Used / 50 GB Available | Desktop: 0 Used / 1 Available Edit  |
    And I log out bus admin console
    Then I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.19646 @bus @user_storage_details @metallic_resellers @desktop
Scenario: Mozy-19646:Access Partner as Bus Admin
  Given I log in bus admin console as administrator
  When I add a new Reseller partner:
    | period | reseller type | reseller quota |
    | 1      | Silver        | 10             |
  Then New partner should be created
  When I act as newly created partner account
  And I add new user(s):
    | user_group           | storage_type | devices |
    | (default user group) | Desktop      | 1       |
  Then 1 new user should be created
  When I search user by:
    | keywords   |
    | @user_name |
  Then User search results should be:
    | External ID | User        | Name       | User Group           | Machines | Storage | Storage Used | Created  | Backed Up |
    |             | @user_email | @user_name | (default user group) | 0        | Shared  | None         | today    | never     |
  When I view user details by newly created user email
  Then user details should be:
    | ID:        | External ID: | Name:                           |
    | @xxxxxxxxx | (change)     | <%=@users.first.name%> (change) |
  And user resources details rows should be:
    | Storage                  | Devices                             |
    | 0 Used / 10 GB Available | Desktop: 0 Used / 1 Available Edit  |
  When I stop masquerading
  Then I search and delete partner account by newly created partner company name

@TC.19839 @bus @user_storage_details @itemized @reseller @desktop @env_dependent
  Scenario: Mozy-19839:Access Reseller Itemized Partner as Partner Admin
    Given I navigate to bus admin console login page
    When I log in to legacy bus01 as administrator
    And I successfully add an itemized Reseller partner:
      | period | desktop licenses | desktop quota |
      | 12     | 2                | 2             |
    And I log in bus admin console as administrator
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And I view partner details by newly created partner company name
    And I get the partner_id
    And I migrate the partner to aria
    And I migrate the partner to pooled storage
    And I act as newly created partner
    And I add new user(s):
      | user_group           | storage_type | devices |
      | (default user group) | Desktop      | 1       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    Then User search results should be:
      | User        | Name         | User Group           | Machines  | Storage          | Storage Used  | Created  | Backed Up |
      | @user_email | @user_name   | (default user group) | 0         | Desktop: Shared  | Desktop: None | today    | never     |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                           |
      | <%=@users.first.name%> (change) |
    And user resources details rows should be:
      | Storage                          | Devices                            |
      | Desktop: 0 Used / 2 GB Available | Desktop: 0 Used / 1 Available Edit |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19841 @bus @user_storage_details @mozypro @itemized @desktop @env_dependent
  Scenario: Mozy-19841: Access an MozyPro Itemized Partner's User's details as Bus Admin
    When I log in to legacy bus01 as administrator
    And I successfully add an itemized MozyPro partner:
      | period | desktop licenses | desktop quota |
      | 12     | 2                | 2             |
    And I log in bus admin console as administrator
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And I view partner details by newly created partner company name
    And I get the partner_id
    And I migrate the partner to aria
    And I migrate the partner to pooled storage
    And I act as newly created partner
    And I add new user(s):
      | user_group           | storage_type | devices |
      | (default user group) | Desktop      | 1       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    Then User search results should be:
      | External ID | User        | Name         | User Group           | Machines | Storage         | Storage Used  | Created  | Backed Up |
      |             | @user_email | @user_name   | (default user group) | 0  	   | Desktop: Shared | Desktop: None | today    | never     |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                           |
      | <%=@users.first.name%> (change) |
    And user resources details rows should be:
      | Storage                          | Devices                            |
      | Desktop: 0 Used / 2 GB Available | Desktop: 0 Used / 1 Available Edit |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19844 @bus @user_storage_details @enterprise @server
Scenario: Mozy-19844: Access an Enterprise Partner's User's details as Partner Admin
  Given I log in bus admin console as administrator
  When I add a new MozyEnterprise partner:
    | period | users | server plan |
    | 12     | 2     | 10 GB       |
  Then New partner should be created
  And I activate new partner admin with default password
  And I log out bus admin console
  And I log in bus admin console as new partner admin
  And I add new user(s):
    | user_group           | storage_type | devices |
    | (default user group) | Server       | 1       |
  Then 1 new user should be created
  And I search user by:
    | keywords   |
    | @user_name |
  Then User search results should be:
    | User        | Name         | Machines | Storage        | Storage Used | Created  | Backed Up |
    | @user_email | @user_name   | 0 	    | Server: Shared | Server: None | today    | never     |
  When I view user details by newly created user email
  Then user details should be:
    | Name:                           |
    | <%=@users.first.name%> (change) |
  And user resources details rows should be:
    | Storage                          | Devices                            |
    | Server: 0 Used / 10 GB Available | Server: 0 Used / 1 Available Edit  |
  And I log out bus admin console
  Then I log in bus admin console as administrator
  And I search and delete partner account by newly created partner company name

@TC.19850 @bus @user_storage_details @emea @IE @bundled @server
Scenario: Mozy-19850: Access an Irish Partner's User's details as Partner Admin
  Given I log in bus admin console as administrator
  When I add a new MozyPro partner:
    | period | base plan | server plan | country | create under    |
    | 1      | 50 GB     | yes         | Ireland | MozyPro Ireland |
  Then New partner should be created
  And I activate new partner admin with default password
  And I log out bus admin console
  And I log in bus admin console as new partner admin
  And I add new user(s):
    | storage_type | devices |
    | Server       | 1       |
  Then 1 new user should be created
  And I search user by:
    | keywords   |
    | @user_name |
  Then User search results should be:
    | User        | Name         | Machines | Storage  | Storage Used | Created  | Backed Up |
    | @user_email | @user_name   | 0 	    | Shared   | None         | today    | never     |
  When I view user details by newly created user email
  Then user details should be:
    | Name:                           |
    | <%=@users.first.name%> (change) |
  And user resources details rows should be:
    | Storage                  | Devices                            |
    | 0 Used / 50 GB Available | Server: 0 Used / 1 Available Edit  |
  And I log out bus admin console
  Then I log in bus admin console as administrator
  And I search and delete partner account by newly created partner company name

@TC.19853 @bus @user_storage_details @emea @UK @enterprise @stash
Scenario: Mozy-19853: Access an United Kingdom Partner's User's details as Partner Admin
  Given I log in bus admin console as administrator
  When I add a new MozyEnterprise partner:
    | period | users | country        |
    | 12     | 2    | United Kingdom |
  Then New partner should be created
  And I enable stash for the partner
  And I activate new partner admin with default password
  And I log out bus admin console
  And I log in bus admin console as new partner admin
  And I add new user(s):
    | user_group           | storage_type | devices | enable_stash |
    | (default user group) | Desktop      | 1       | yes          |
  Then 1 new user should be created
  When I search user by:
    | keywords   |
    | @user_name |
  Then User search results should be:
    | User        | Name         | Machines | Storage         | Storage Used  | Created  | Backed Up |
    | @user_email | @user_name   | 0 	      | Desktop: Shared | Desktop: None | today    | never     |
  When I view user details by newly created user email
  Then user details should be:
    | Name:                           |
    | <%=@users.first.name%> (change) |
  And user resources details rows should be:
    | Storage                           | Devices                            |
    | Desktop: 0 Used / 50 GB Available | Desktop: 0 Used / 1 Available Edit |
  And I log out bus admin console
  Then I log in bus admin console as administrator
  And I search and delete partner account by newly created partner company name

@TC.19856 @bus @user_storage_details @emea @FR @metallic_reseller @server
  Scenario: Mozy-19856:Access French Reseller's User's details as Bus Admin
    Given I log in bus admin console as administrator
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |country | create under   |
      | 1      | Silver        | 10             | yes         | France | MozyPro France |
    Then New partner should be created
    And I enable stash for the partner
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | devices |
      | (default user group) | Server       | 1       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    Then User search results should be:
      | User        | Name         | Machines | Storage | Storage Used | Created  | Backed Up |
      | @user_email | @user_name   | 0 	      | Shared  | None  	   | today    | never     |
    When I view user details by newly created user email
    Then user details should be:
      | ID:        | External ID: | Name:                           |
      | @xxxxxxxxx | (change)     | <%=@users.first.name%> (change) |
  And user resources details rows should be:
    | Storage                  | Devices                           |
    | 0 Used / 10 GB Available | Server: 0 Used / 1 Available Edit |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19859 @bus @user_storage_details @emea @DE @mozypro @itemized @server @env_dependent
Scenario: Mozy-19859:Access German Partner's User's details as Bus Admin
  When I log in to legacy bus01 as administrator
  And I successfully add an itemized MozyPro partner:
    | period | server licenses | server quota |
    | 12     | 2               | 2            |
  And I log in bus admin console as administrator
  And I search partner by:
    | name          | filter |
    | @company_name | None   |
  And I view partner details by newly created partner company name
  And I get the partner_id
  And I migrate the partner to aria
  And I migrate the partner to pooled storage
  And I act as newly created partner
  And I add new user(s):
    | user_group          | storage_type | devices |
    | (default user group)| Server       | 1       |
  Then 1 new user should be created
  When I search user by:
    | keywords   |
    | @user_name |
  Then User search results should be:
    | External ID | User        | Name         | User Group           | Machines | Storage        | Storage Used | Created  | Backed Up |
    |             | @user_email | @user_name   | (default user group) | 0 	     | Server: Shared | Server: None | today    | never     |
  When I view user details by newly created user email
  Then user details should be:
    | ID:        | External ID: | Name:                           |
    | @xxxxxxxxx | (change)     | <%=@users.first.name%> (change) |
  And user resources details rows should be:
    | Storage                         | Devices                           |
    | Server: 0 Used / 2 GB Available | Server: 0 Used / 1 Available Edit |
  When I stop masquerading
  Then I search and delete partner account by newly created partner company name
