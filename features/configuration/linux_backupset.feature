Feature: Linux BackupSet


  Background:
    Given I log in bus admin console as administrator

  @TC.126287 @client_configuration @bus
  Scenario: 126287 view/edit a new created linux backupset records
    When I add a new MozyEnterprise partner:
      | company name      | period | users | server plan |
      | TC.126287_partner | 24     | 2     | 250 GB      |
    Then New partner should be created
    And I get the partner_id
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) |  Server      |  1            |  1      |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    When I create a new client config:
      | name                    | type   |
      | TC.126287_client_config | Server |
    And I edit the new created config TC.126287_client_config
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name | name includes | name excludes | type includes   | type excludes |
      | 126287_backupset      | test1         | test2         | autotest1       | autotest2     |
    And I click done to save linux backup sets
    And I click edit link of linux backup set 126287_backupset
    Then the linux backup set should be:
      | name includes | name excludes | type includes   | type excludes |
      | test1         | test2         | autotest1       | autotest2     |
    And I edit Linux Backup Set:
      | name includes | name excludes | type includes   | type excludes |
      | auto1         | auto2         | *txt*           | *xlsx*        |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And activate the user's Server device without a key and with the default password
    And I get backup sets rule through API
    Then the backup set rules from API should be:
      | filenames | exclude_filenames | filetypes | exclude_filetypes |
      | auto1     | auto2             | *txt*     | *xlsx*            |
    And I edit the new created config TC.126287_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 126287_backupset
    Then the linux backup set should be:
      | name includes | name excludes | type includes   | type excludes |
      | auto1         | auto2         | *txt*           | *xlsx*        |
    And I edit Linux Backup Set:
      | name includes | name excludes | type includes   | type excludes |
      |               |               |                 |               |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126287_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 126287_backupset
    Then the linux backup set should be:
      | name includes | name excludes | type includes   | type excludes |
      |               |               |                 |               |
    And I stop masquerading
    And I search and delete partner account by TC.126287_partner

  @TC.126252 @client_configuration @bus
  Scenario: 126252 #131235 BUS shows client config parent&sub-partner with same linux backup set name
    When I add a new MozyEnterprise partner:
      | company name         | period | users | server plan | net terms | root role  |
      | TC.126252_partner    | 12     | 18    | 100 GB      | yes       | FedID role |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name          |
      | TC.126252_sub_partner |
    Then New partner should be created
    When I act as newly created partner account
    And I create a new client config:
      | name                        | type   |
      | TC.126252_sub_client_config | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126252_sub_client_config
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name |
      | TestA                 |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I stop masquerading as sub partner
    And I create a new client config:
      | name                    | type   |
      | TC.126252_client_config | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126252_client_config
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name |
      | TestA                 |
    And I click done to save linux backup sets
    And I cascade linux backup set TestA
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    When I act as partner by:
      | name                  |
      | TC.126252_sub_partner |
    And I navigate to Client Configuration section from bus admin console page
    And I edit the new created config TC.126252_sub_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set TestA_(1)
    Then linux backup set TestA_(1) should be opened
    And I stop masquerading as sub partner
    And I stop masquerading
    And I search and delete partner account by TC.126252_sub_partner
    And I search and delete partner account by TC.126252_partner





