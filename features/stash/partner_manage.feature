Feature:

  As partner administrator
  I want to view a MozyPro or MozyEnterprise customers plan details
  so that I can find out how many users have Stash and how much quota has been Activated and Used by Stash

  Background:
    Given I log in bus admin console as administrator

  @TC.19045 @BSA.3000
  Scenario: 19045 View MozyEnterprise users with stash enabled
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner with 5 GB stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 5 GB (change)          |
    When I act as newly created partner account
    And I add a new user:
      | name           | email                       | enable stash | stash quota |
      | TC.19045 user1 | qa1+tc+19045+user1@mozy.com | yes          | 10          |
    Then New user should be created
    And I add a new user:
      | name           | email                       | enable stash | stash quota |
      | TC.19045 user2 | qa1+tc+19045+user2@mozy.com | yes          | 15          |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | External ID | User                          | Name           | User Group           | Stash   | Machines | Storage | Storage Used | Created | Backed Up |
      |             | qa1+tc+19045+user2@mozy.com   | TC.19045 user2 | (default user group) | Enabled | 0        | 15 GB   | none         | today   | never     |
      |             | qa1+tc+19045+user1@mozy.com   | TC.19045 user1 | (default user group) | Enabled | 0        | 10 GB   | none         | today   | never     |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19057 @BSA.3000
  Scenario: 19057 View MozyPro users with stash enabled
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 100 GB    |
    Then New partner should be created
    When I enable stash for the partner with 5 GB stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 5 GB (change)          |
    When I act as newly created partner account
    And I add a new user:
      | name           | email                       | enable stash | stash quota |
      | TC.19057 user1 | qa1+tc+19057+user1@mozy.com | yes          | 10          |
    Then New user should be created
    And I add a new user:
      | name           | email                       | enable stash | stash quota |
      | TC.19057 user2 | qa1+tc+19057+user2@mozy.com | yes          | 15          |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | External ID | User                          | Name           | Stash   | Machines | Storage | Storage Used | Created | Backed Up |
      |             | qa1+tc+19057+user2@mozy.com   | TC.19057 user2 | Enabled | 0        | 15 GB   | none         | today   | never     |
      |             | qa1+tc+19057+user1@mozy.com   | TC.19057 user1 | Enabled | 0        | 10 GB   | none         | today   | never     |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19165 @BSA.3010
  Scenario: 19165 US Pro admin can see stash details in manage resources
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 100 GB    |
    Then New partner should be created
    When I enable stash for the partner with 5 GB stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 5 GB (change)          |
    And Partner account attributes should be:
      | Backup Licenses         | 200       |
      | Backup License Soft Cap | Enabled   |
      | Server Enabled          | Disabled  |
      | Cloud Storage (GB)      | 100       |
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 5         |
    And Partner stash info should be:
    | Stash Users:         | 0                 |
    | Stash Storage Usage: | 0 bytes / 0 bytes |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19169 @BSA.3050
  Scenario: 19165 US Pro admin can see stash details in manage resources
  When I add a new MozyPro partner:
    | period | base plan |
    | 12     | 100 GB    |
  Then New partner should be created
  When I enable stash for the partner with 5 GB stash storage
  Then Partner general information should be:
    | Enable Stash: | Default Stash Storage: |
    | Yes           | 5 GB (change)          |
  When I act as newly created partner account
  And I add a new user:
    | name           | email                       | enable stash | stash quota |
    | TC.19165 user1 | qa1+tc+19165+user1@mozy.com | yes          | 10          |
  Then New user should be created
  And I add a new user:
    | name           | email                       | enable stash | stash quota |
    | TC.19165 user2 | qa1+tc+19165+user2@mozy.com | yes          | 15          |
  Then New user should be created
  When I navigate to Manage Resources section from bus admin console page
  And Partner resources general information should be:
    | Total Account Storage: | Unallocated Storage: | Server Enabled: | Stash Users: | Stash Storage Usage: |
    | 100 GB                 | 0 GB                 | No              | 2            | 0 bytes / 25 GB      |
  When I stop masquerading
  And I search and delete partner account by newly created partner company name
