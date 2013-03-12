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
    And I add a new user:
      | name           |
      | TC.18972 user  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
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
    And I add a new user:
      | name           |
      | TC.18973 user  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    Then User details should be:
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
    And I add a new user:
      | name           |
      | TC.18974 user  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I add stash for the user with:
      | stash quota | send email |
      | default     | no         |
    Then User details should be:
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
    And I add a new user:
      | name           |
      | TC.18976 user  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
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
    And I add a new user:
      | name           |
      | TC.18977 user  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
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
    And I add a new user:
      | name           |
      | TC.19015 user  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I add stash for the user with:
      | stash quota | send email |
      | 10 GB       | no         |
    Then User details should be:
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
    And I add a new user:
      | name           |
      | TC.19017 user  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I cancel add user stash
    Then User details should be:
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
    And I add a new user:
      | name           | enable stash |
      | TC.18981 user  | yes          |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    Then User details should be:
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
    And I add a new user:
      | name           | enable stash | stash quota |
      | TC.18982 user  | yes          | 99999999    |
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
    And I add a new user:
      | name           | enable stash | stash quota |
      | TC.18985 user  | yes          | 0           |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    Then User details should be:
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
    When I add a new user:
      | name           | enable stash | stash quota |
      | TC.19018 user  | yes          | 5           |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
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
    And I add a new user:
      | name           |
      | TC.19019 user  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    Then User details should be:
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
    And I add a new user:
      | name           | enable stash | stash quota | send stash invite |
      | TC.18988 user  | yes          | 5           | yes               |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I delete stash container for the user
    Then Popup window message should be Do you want to delete the user's stash? Note: Deleting a user's Stash removes all of the user's Stash files from the Web.
    When I click Cancel button on popup window
    And User details should be:
    | Enable Stash:               |
    | Yes (Send Invitation Email) |
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I delete stash container for the user
    And I click Continue button on popup window
    And I refresh User Details section
    Then User details should be:
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
    And I add a new user:
      | name           | enable stash | stash quota | send stash invite |
      | TC.18989 user  | yes          | 5           | yes               |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I delete stash container for the user
    Then Popup window message should be Do you want to delete the user's stash? Note: Deleting a user's Stash removes all of the user's Stash files from the Web.
    When I click Cancel button on popup window
    And User details should be:
      | Enable Stash:               |
      | Yes (Send Invitation Email) |
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I delete stash container for the user
    And I click Continue button on popup window
    And I refresh User Details section
    Then User details should be:
      | Enable Stash:  |
      | No (Add Stash) |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19478 @BSA.2060
  Scenario: 19478 MozyEnterprise partner delete stash container in user details section
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 1      | Gold          | 100            | yes       |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I allocate 10 GB Desktop quota with (default user group) user group to Reseller partner
    Then Reseller resource quota should be changed
    And I add a new user:
      | name           | enable stash | stash quota | send stash invite |
      | TC.19478 user  | yes          | 5           | yes               |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I delete stash container for the user
    Then Popup window message should be Do you want to delete the user's stash? Note: Deleting a user's Stash removes all of the user's Stash files from the Web.
    When I click Cancel button on popup window
    And User details should be:
      | Enable Stash:               |
      | Yes (Send Invitation Email) |
    And User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    When I delete stash container for the user
    And I click Continue button on popup window
    And I refresh User Details section
    Then User details should be:
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
    And I add a new user:
      | name           | enable stash |
      | TC.18990 user  | yes          |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I send stash invitation email
    Then I should see 1 email(s) when I search keywords:
      | to              | date    | subject               |
      | @new_user_email | today   | Welcome to Mozy Stash |
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
    And I add a new user:
      | name           |
      | TC.19121 user  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I add stash for the user with:
      | stash quota | send email |
      | 10 GB       | yes        |
    Then User details should be:
      | Name:                  | Enable Stash:               |
      | TC.19121 user (change) | Yes (Send Invitation Email) |
    And User backup details table should be:
      | Computer | Encryption | Storage Used             | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 10 GB (change) | N/A         |             | delete  |
    Then I should see 1 email(s) when I search keywords:
      | to              | date    | subject               |
      | @new_user_email | today   | Welcome to Mozy Stash |
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
    And I add a new user:
      | name           | enable stash | stash quota | send stash invite |
      | TC.19122 user  | yes          | 5           | yes               |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    Then User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions |
      | Stash    | Default    | 0 bytes / 5 GB (change) | N/A         |             | delete  |
    And I should see 1 email(s) when I search keywords:
      | to              | date    | subject               |
      | @new_user_email | today   | Welcome to Mozy Stash |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18995 @BSA.3030
  Scenario: 18995 [Search/List Users View][P]"Stash" column shows and has valid value
    When I act as partner by:
      | email                        |
      | test3010_3030_3040@auto.com  |
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                   | Name           | User Group           | Stash    |
      | backup@test.com        | backup         | backup               | Disabled |
      | stash19045@test.com    | stash19045     | (default user group) | Enabled  |
      | backup19045@test.com   | backup19045    | (default user group) | Disabled |
      | stash@test.com         | stash          | stash                | Enabled  |

  @TC.18996 @BSA.3030
  Scenario: 18996 [Search/List Users View][P]"Storage" and "Storage Used" column includes backup and stash
    When I act as partner by:
      | email                       |
      | test3010_3030_3040@auto.com |
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                   | Name           | User Group           | Stash    | Machines | Storage | Storage Used |
      | backup@test.com        | backup         | backup               | Disabled | 1        | 1 GB    | 10 MB        |
      | stash19045@test.com    | stash19045     | (default user group) | Enabled  | 0        | 2 GB    | 20 MB        |
      | backup19045@test.com   | backup19045    | (default user group) | Disabled | 1        | 1 GB    | 10 MB        |
      | stash@test.com         | stash          | stash                | Enabled  | 0        | 2 GB    | 20 MB        |

  @TC.19114 @BSA.3040
  Scenario: 19114 Enterprise Partner View Stash status
    When I act as partner by:
      | email                       |
      | test3010_3030_3040@auto.com |
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                   | Name           | User Group           | Stash    | Machines | Storage | Storage Used |
      | backup@test.com        | backup         | backup               | Disabled | 1        | 1 GB    | 10 MB        |
      | stash19045@test.com    | stash19045     | (default user group) | Enabled  | 0        | 2 GB    | 20 MB        |
      | backup19045@test.com   | backup19045    | (default user group) | Disabled | 1        | 1 GB    | 10 MB        |
      | stash@test.com         | stash          | stash                | Enabled  | 0        | 2 GB    | 20 MB        |
    When I view user details by stash19045@test.com
    Then User details should be:
      | Name:               | Enable Stash:               |
      | stash19045 (change) | Yes (Send Invitation Email) |

  @TC.19115 @BSA.3040
  Scenario: 19115 Enterprise Partner View User storage usage
    When I act as partner by:
      | email                       |
      | test3010_3030_3040@auto.com |
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                   | Name           | User Group           | Stash    | Machines | Storage | Storage Used |
      | backup@test.com        | backup         | backup               | Disabled | 1        | 1 GB    | 10 MB        |
      | stash19045@test.com    | stash19045     | (default user group) | Enabled  | 0        | 2 GB    | 20 MB        |
      | backup19045@test.com   | backup19045    | (default user group) | Disabled | 1        | 1 GB    | 10 MB        |
      | stash@test.com         | stash          | stash                | Enabled  | 0        | 2 GB    | 20 MB        |
    When I view user details by stash19045@test.com
    Then User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions               |
      | Stash    | Default    | 20 MB / 2 GB (change)   | N/A         |             | Access Files delete   |

  @TC.19116 @BSA.3040
  Scenario: 19116 Mozypro Partner View Stash status
    When I act as partner by:
      | email                  |
      | test_bsa3040@auto.com  |
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | External ID | User                   | Name           | Stash    | Machines | Storage | Storage Used |
      |             | backup19057@test.com   | backup19057    | Disabled | 1        | 1 GB    | 10 MB        |
      |             | stash19057@test.com    | stash19057     | Enabled  | 0        | 2 GB    | 5 MB         |
    When I view user details by stash19057@test.com
    Then User details should be:
      | Name:                  | Enable Stash:               |
      | stash19057 (change)    | Yes (Send Invitation Email) |

  @TC.19117 @BSA.3040
  Scenario: 19117 MozyPro Partner View user storage usage
    When I act as partner by:
      | email                 |
      | test_bsa3040@auto.com |
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                   | Name           | Stash    | Machines | Storage | Storage Used |
      | backup19057@test.com   | backup19057    | Disabled | 1        | 1 GB    | 10 MB        |
      | stash19057@test.com    | stash19057     | Enabled  | 0        | 2 GB    | 5 MB         |
    When I view user details by stash19057@test.com
    Then User backup details table should be:
      | Computer | Encryption | Storage Used            | Last Update | License Key | Actions               |
      | Stash    | Default    | 5 MB / 2 GB (change)    | N/A         |             | Access Files delete   |






