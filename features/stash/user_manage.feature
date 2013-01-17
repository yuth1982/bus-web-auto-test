Feature: User stash setting management

  As a Mozy customer admin
  I want to add Stash to a new user with a stash storage
  so that users can start using Stash immediately

  Background:
    Given I log in bus admin console as administrator

  @TC.18972 @BSA.2040
  Scenario: 18972 Add Stash link is not available in user view when stash is not enabled for the user
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 50 GB     |
    Then New partner should be created
    When I act as newly created partner account
    And I add a new user to a MozyPro partner:
      | name           | email                        |
      | TC.18972 user  | qa1+tc+18972+user1@mozy.com  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by qa1+tc+18972+user1@mozy.com
    Then I should not see Enable Stash setting on user details section

  @TC.18973 @BSA.2040
  Scenario: 18973 Add Stash link is available in user view when stash is enabled for the user
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a MozyEnterprise partner:
      | name           | email                        |
      | TC.18973 user  | qa1+tc+18973+user1@mozy.com  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by qa1+tc+18973+user1@mozy.com
    Then user details should be:
      | Name:                  | Enable Stash:  |
      | TC.18973 user (change) | No (Add Stash) |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18974 @BSA.2040
  Scenario: 18974 Click Add Stash link in user details section to enable stash
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 50 GB     |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a MozyPro partner:
      | name           | email                        |
      | TC.18974 user  | qa1+tc+18974+user1@mozy.com  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by qa1+tc+18974+user1@mozy.com
    And I add stash for the user with:
      | stash quota | send email |
      | default     | no         |
    Then user details should be:
      | Name:                  | Enable Stash:               |
      | TC.18974 user (change) | Yes (Send Invitation Email) |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18976 @BSA.2040
  Scenario: 18976 Enable stash by click Add Stash link but not enough storage then I can choose Allocate More Storage
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 50 GB     |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a MozyPro partner:
      | name           | email                        |
      | TC.18976 user  | qa1+tc+18976+user1@mozy.com  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by qa1+tc+18976+user1@mozy.com
    And I add stash for the user with:
      | stash quota | send email |
      | 9999999     | no         |
    Then Popup window message should be You do not have enough storage available for the default storage entered. Use the Manage Resources panel to increase the amount of storage allocated or to purchase more storage.
    When I click Allocate button on popup window
    Then Manage Resources section should be visible
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18977 @BSA.2040
  Scenario: 18977 Enable stash by click Add Stash link but not enough storage then I can choose Buy More Storage
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a MozyEnterprise partner:
      | name           | email                        |
      | TC.18977 user  | qa1+tc+18977+user1@mozy.com  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by qa1+tc+18977+user1@mozy.com
    And I add stash for the user with:
      | stash quota | send email |
      | 9999999     | no         |
    Then Popup window message should be There is not enough storage available to add the default storage amount.
    When I click Buy More button on popup window
    Then Change Plan section should be visible
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19015 @BSA.2040
  Scenario: 19015 Admin can assign a different amount for the user when add stash
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 50 GB     |
    Then New partner should be created
    When I enable stash for the partner with 5 GB stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 5 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a MozyPro partner:
      | name           | email                        |
      | TC.19015 user  | qa1+tc+19015+user1@mozy.com  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by qa1+tc+19015+user1@mozy.com
    And I add stash for the user with:
      | stash quota | send email |
      | 10 GB       | no         |
    Then user details should be:
      | Name:                  | Enable Stash:               |
      | TC.19015 user (change) | Yes (Send Invitation Email) |
    And User backup details table should be:
      | Computer | Encryption | Storage Used             | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 10 GB (change) | N/A         |             | delete  |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19017 @BSA.2040
  Scenario: 19017 User click Cancel will not enable stash
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 50 GB     |
    Then New partner should be created
    When I enable stash for the partner with 5 GB stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 5 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a MozyPro partner:
      | name           | email                        |
      | TC.19017 user  | qa1+tc+19017+user1@mozy.com  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by qa1+tc+19017+user1@mozy.com
    And I cancel add user stash
    Then user details should be:
      | Name:                  | Enable Stash:  |
      | TC.19017 user (change) | No (Add Stash) |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18978 @BSA.2050
  Scenario: 18978 Stash options are not available in Add New User view when Stash is disabled
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    Then I should not see stash options
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18979 @BSA.2050
  Scenario: 18979 Stash options are available in Add New User view when Stash is enabled
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner with 5 GB stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 5 GB (change)          |
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    Then I should see stash options
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18981 @BSA.2050
  Scenario: 18981 Add a new user with stash enabled
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a MozyEnterprise partner:
      | name           | email                       | enable stash |
      | TC.18981 user  | qa1+tc+18981+user1@mozy.com | yes          |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by qa1+tc+18981+user1@mozy.com
    Then user details should be:
      | Name:                  | Enable Stash:               |
      | TC.18981 user (change) | Yes (Send Invitation Email) |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18982 @BSA.2050
  Scenario: 18982 Add new user with a stash quota large than available quota
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 50 GB     |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a MozyPro partner:
      | name           | email                       | enable stash | stash quota |
      | TC.18982 user  | qa1+tc+18982+user1@mozy.com | yes          | 99999999    |
    Then New user created message should be Only 50 Desktop GB free
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18985 @BSA.2050
  Scenario: 18985 Add new user with 0 stash quota will not enable stash
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a Reseller partner:
      | name           | email                       | enable stash | stash quota |
      | TC.18985 user  | qa1+tc+18985+user1@mozy.com | yes          | 0           |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by qa1+tc+18985+user1@mozy.com
    Then user details should be:
      | Name:                  | Enable Stash:  |
      | TC.18985 user (change) | No (Add Stash) |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19018 @BSA.2050
  Scenario: 19018 Add new user with custom Desired Storage for Stash
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Gold          | 100            |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I allocate 10 GB Desktop quota with (default user group) user group to Reseller partner
    Then Reseller resource quota should be changed
    When I add a new user to a Reseller partner:
      | name           | email                       | enable stash | stash quota |
      | TC.19018 user  | qa1+tc+19018+user1@mozy.com | yes          | 5           |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by qa1+tc+19018+user1@mozy.com
    Then User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19019 @BSA.2050
  Scenario: 19019 Add new user with stash not enabled
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a MozyPro partner:
      | name           | email                       |
      | TC.19019 user  | qa1+tc+19019+user1@mozy.com |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by qa1+tc+19019+user1@mozy.com
    Then user details should be:
      | Name:                  | Enable Stash:  |
      | TC.19019 user (change) | No (Add Stash) |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18988 @BSA.2060
  Scenario: 18988 MozyPro partner delete stash container in user details section
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a MozyPro partner:
      | name           | email                       | enable stash | stash quota | send stash invite |
      | TC.18988 user  | qa1+tc+18988+user1@mozy.com | yes          | 5           | yes               |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by qa1+tc+18988+user1@mozy.com
    And I delete stash container for the user
    Then Popup window message should be Do you want to delete the user's stash? Note: Deleting a user's Stash removes all of the user's Stash files from the Web.
    When I click Cancel button on popup window
    And user details should be:
    | Enable Stash:               |
    | Yes (Send Invitation Email) |
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I delete stash container for the user
    And I click Continue button on popup window
    And I refresh User Details section
    Then user details should be:
      | Enable Stash:  |
      | No (Add Stash) |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18989 @BSA.2060
  Scenario: 18989 MozyEnterprise partner delete stash container in user details section
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a MozyEnterprise partner:
      | name           | email                       | enable stash | stash quota | send stash invite |
      | TC.18989 user  | qa1+tc+18989+user1@mozy.com | yes          | 5           | yes               |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by qa1+tc+18989+user1@mozy.com
    And I delete stash container for the user
    Then Popup window message should be Do you want to delete the user's stash? Note: Deleting a user's Stash removes all of the user's Stash files from the Web.
    When I click Cancel button on popup window
    And user details should be:
      | Enable Stash:               |
      | Yes (Send Invitation Email) |
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I delete stash container for the user
    And I click Continue button on popup window
    And I refresh User Details section
    Then user details should be:
      | Enable Stash:  |
      | No (Add Stash) |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19478 @BSA.2060
  Scenario: 19478 MozyEnterprise partner delete stash container in user details section
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Gold          | 100            |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I allocate 10 GB Desktop quota with (default user group) user group to Reseller partner
    Then Reseller resource quota should be changed
    And I add a new user to a Reseller partner:
      | name           | email                       | enable stash | stash quota | send stash invite |
      | TC.19478 user  | qa1+tc+19478+user1@mozy.com | yes          | 5           | yes               |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by qa1+tc+19478+user1@mozy.com
    And I delete stash container for the user
    Then Popup window message should be Do you want to delete the user's stash? Note: Deleting a user's Stash removes all of the user's Stash files from the Web.
    When I click Cancel button on popup window
    And user details should be:
      | Enable Stash:               |
      | Yes (Send Invitation Email) |
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I delete stash container for the user
    And I click Continue button on popup window
    And I refresh User Details section
    Then user details should be:
      | Enable Stash:  |
      | No (Add Stash) |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18990 @BSA.2070
  Scenario: 18990 Send stash invitation email in user details section
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 50 GB     |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a MozyPro partner:
      | name           | email                        | enable stash |
      | TC.18990 user  | qa1+tc+18990+user1@mozy.com  | yes          |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by qa1+tc+18990+user1@mozy.com
    And I send stash invitation email
    Then I should see 1 email(s) when I search keywords:
      | to                          | date    | subject               |
      | qa1+tc+18990+user1@mozy.com | today   | Welcome to Mozy Stash |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19121 @BSA.2070
  Scenario: 19121 Click Add Stash link with default quota and send email
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a MozyEnterprise partner:
      | name           | email                        |
      | TC.19121 user  | qa1+tc+19121+user1@mozy.com  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by qa1+tc+19121+user1@mozy.com
    And I add stash for the user with:
      | stash quota | send email |
      | 10 GB       | yes        |
    Then user details should be:
      | Name:                  | Enable Stash:               |
      | TC.19121 user (change) | Yes (Send Invitation Email) |
    And User backup details table should be:
      | Computer | Encryption | Storage Used             | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 10 GB (change) | N/A         |             | delete  |
    Then I should see 1 email(s) when I search keywords:
      | to                          | date    | subject               |
      | qa1+tc+19121+user1@mozy.com | today   | Welcome to Mozy Stash |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19122 @BSA.2070
  Scenario: 19122 Add new user with stash enabled and send stash invite email
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user to a MozyEnterprise partner:
      | name           | email                       | enable stash | stash quota | send stash invite |
      | TC.19122 user  | qa1+tc+19122+user1@mozy.com | yes          | 5           | yes               |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by qa1+tc+19122+user1@mozy.com
    Then User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    And I should see 1 email(s) when I search keywords:
      | to                          | date    | subject               |
      | qa1+tc+19122+user1@mozy.com | today   | Welcome to Mozy Stash |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name
