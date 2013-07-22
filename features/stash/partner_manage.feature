Feature:

  As partner administrator
  I want to view a MozyPro or MozyEnterprise customers plan details
  so that I can find out how many users have Stash and how much quota has been Activated and Used by Stash

  Background:
    Given I log in bus admin console as administrator

  @TC.19045 @BSA.3000 @bus @stash @partner_manage
  Scenario: 19045 MozyEnterprise admin view stash details in list users section
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Stash: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | devices | enable_stash |
      | TC.19045 user1 | (default user group) | Desktop      | 1       | yes          |
      | TC.19045 user2 | (default user group) | Desktop      | 1       | yes          |
    Then 2 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                     | Name           | Stash   | Machines | Storage         | Storage Used  | Created | Backed Up |
      | <%=@new_users[1].email%> | TC.19045 user2 | Enabled | 0        | Desktop: Shared | Desktop: None | today   | never     |
      | <%=@new_users[0].email%> | TC.19045 user1 | Enabled | 0        | Desktop: Shared | Desktop: None | today   | never     |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19057 @BSA.3000 @bus @stash @partner_manage
  Scenario: 19057 MozyPro admin view stash details in list users section
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 100 GB    | yes       |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Stash: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name            | storage_type | devices | enable_stash |
      | TC.19057.1-user | Desktop      | 1       | yes          |
      | TC.19057.2-user | Desktop      | 1       | yes          |
    Then 2 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                     | Name            | Stash   | Machines | Storage | Storage Used | Created | Backed Up |
      | <%=@new_users[1].email%> | TC.19057.2-user | Enabled | 0        | Shared  | None         | today   | never     |
      | <%=@new_users[0].email%> | TC.19057.1-user | Enabled | 0        | Shared  | None         | today   | never     |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19738 @BSA.3000 @bus @stash @partner_manage
  Scenario: 19738 MozyEnterprise admin view stash details in partner details section
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Stash: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add a new user to a MozyEnterprise partner:
      | name           | enable stash | stash quota |
      | TC.19738 user1 | yes          | 10          |
    Then New user should be created
    And I add a new user to a MozyEnterprise partner:
      | name           | enable stash | stash quota |
      | TC.19738 user2 | yes          | 15          |
    Then New user should be created
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 5         |
    And Partner stash info should be:
      | Stash Users:         | 2               |
      | Stash Storage Usage: | 0 bytes / 25 GB |
    And I delete partner account

  @TC.19739 @BSA.3000 @bus @stash @partner_manage
  Scenario: 19739 MozyPro admin view stash details in partner details section
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 100 GB    | yes       |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Stash: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add a new user to a MozyPro partner:
      | name           | enable stash | stash quota |
      | TC.19739 user1 | yes          | 15          |
    Then New user should be created
    And I add a new user to a MozyPro partner:
      | name           | enable stash | stash quota |
      | TC.19739 user2 | yes          | 20          |
    Then New user should be created
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And Partner account attributes should be:
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 10        |
    And Partner stash info should be:
      | Stash Users:         | 2               |
      | Stash Storage Usage: | 0 bytes / 35 GB |
    And I delete partner account

  @TC.19740 @BSA.3000 @bus @stash @partner_manage
  Scenario: 19740 Reseller admin view stash details in partner details section
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Stash: |
      | Yes (change)  |
    When I act as newly created partner account
    And I allocate 50 GB Desktop quota with (default user group) user group to Reseller partner
    Then Reseller resource quota should be changed
    When I add a new user to a Reseller partner:
      | name           | enable stash | stash quota |
      | TC.19740 user1 | yes          | 15          |
    Then New user should be created
    When I add a new user to a Reseller partner:
      | name           | enable stash | stash quota |
      | TC.19740 user2 | yes          | 20          |
    Then New user should be created
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And Partner account attributes should be:
      | Stash Users:            | -1        |
      | Default Stash Storage:  | 10        |
    And Partner stash info should be:
      | Stash Users:         | 2               |
      | Stash Storage Usage: | 0 bytes / 35 GB |
    And I delete partner account

  @TC.19169 @BSA.3050 @bus @stash @partner_manage
  Scenario: 19169 MozyPro admin view stash details in manage resources section
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 100 GB    | yes       |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Stash: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add a new user to a MozyPro partner:
      | name           | enable stash | stash quota |
      | TC.19169 user1 | yes          | 30          |
    Then New user should be created
    When I navigate to Manage Resources section from bus admin console page
    And Partner resources general information should be:
      | Stash Users: | Stash Storage Usage: |
      | 1            | 0 bytes / 30 GB      |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19056 @BSA.4000 @bus @stash @partner_manage
  Scenario: 19056 MozyEnterprise admin disable stash in user group view
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Stash: |
      | Yes (change)  |
    When I act as newly created partner account
    When I navigate to List User Groups section from bus admin console page
    And I view (default user group) * user group details
    And I disable stash for the user group
    Then User group details should be:
      | Enable Stash: |
      | No (change)   |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19123 @BSA.4000 @bus @stash @partner_manage
  Scenario: 19123 MozyEnterprise admin change default stash quota in user group view
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Stash: |
      | Yes (change)  |
    When I act as newly created partner account
    When I navigate to List User Groups section from bus admin console page
    And I view (default user group) * user group details
    And I enable stash for the user group
    Then User group details should be:
      | Enable Stash: |
      | Yes (change)  |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.18913 @BSA.6000 @bus @stash @partner_manage
  Scenario: 18913 Root admin disable Stash for a new MozyPro partner
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 100 GB    |
    Then New partner should be created
    When I enable stash for the partner
    Then Partner general information should be:
      | Enable Stash: |
      | Yes (change)  |
    When I disable stash for the partner
    Then Partner general information should be:
      | Enable Stash: |
      | No (change)   |
    When I delete partner account
