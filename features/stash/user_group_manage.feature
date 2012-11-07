Feature: User group stash setting management

  As a Mozy customer admin
  I want to turn-on Stash for a new user group so that I can add Stash to the users within that group

  # Add new user group functionality
  @BSA.#2000 @TC.19001
  Scenario: Given stash is enabled for partner, I can add a default amount of stash storage for a new user group
    When I log in bus admin console as administrator
    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
    And I enable stash for the partner
    And I act as newly created partner account
    And I add a new user group:
      | stash |
      |  10   |
    Then newly created user group should have following information:
      | stash |
      |  10   |

  @BSA.#2000 @TC.19002
  Scenario: Given stash is enabled for partner, I can see help information in add new user group for Default Storage for Stash
    When I log in bus admin console as administrator
    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
    And I enable stash for the partner
    And I act as newly created partner account
    And I navigate to the new user group details section
    Then I can see help icon for stash
    And I click the help icon
    Then I can see popup with help message

  @BSA.#2000 @TC.19003
  Scenario: Given stash is DISABLED for partner, I should NOT see 'Default Storage for Stash' in add new user group page
    When I log in bus admin console as administrator
    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
    And I enable stash for the partner
    And I act as newly created partner account
    And I navigate to the new user group details section
    Then I should not see 'Default Storage for Stash'

  @BSA.#2000 @TC.19004
  Scenario: Given stash is enabled for a user group, I can add a new user in that group with a certain amount of stash storage
    When I log in bus admin console as administrator
    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
    And I enable stash for the partner
    And I act as newly created partner account
    And I add a new user group:
      | stash |
      |  10   |
    And I add a new user with default stash storage
    Then I should see a new user is created with stash enabled and storage is 10GB

  # Edit existing user group
  @BSA.#2010 @TC.19005
  Scenario: Given stash is DISABLED for partner, I should NOT see 'Enable Stash' settings in user group edit page
    When I log in bus admin console as administrator
    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
    And I act as newly created partner account
    And I navigate to the user group edit page
    Then I should not see 'Enable Stash' settings

  @BSA.#2010 @TC.19006
  Scenario: Given stash is DISABLED for partner, all existing user groups keep unchanged
    When I log in bus admin console as administrator
    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
    And I act as newly created partner account
    And I add a new user group:
    And I enable stash for the partner
      | stash |
      | 5     |
    And I act as the partner
    And I navigate to user group list page
    Then I can see user groups are not enabled with stash

  @BSA.#2010 @TC.19007
  Scenario: Given stash is enabled for a user group, I can modify default stash storage quota for a user group in user group edit page
    When I log in bus admin console as administrator
    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
    And I enable stash for the partner
      | stash |
      | 15    |
    And I act as newly created partner account
    And I navigate to user group list page
    And I change default stash storage quota to 20
    And I add a new user with default stash storage
    Then I should see a new user is created with stash enabled and storage is 20GB

  # Delete stash from existing user group
  @BSA.#2020 @TC.19008
  Scenario: Given stash is enabled for a user group, I can disable default stash storage quota for a user group in user group edit page
    When I log in bus admin console as administrator
    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
    And I enable stash for the partner
      | stash |
      | 15    |
    And I act as newly created partner account
    And I add a new user under the default group
    And I navigate to user group list page
    And I disable stash for the default group
    Then I should see a confirmation message telling me if I really want to delete it
    And I choose yes
    Then I should not see stash column for the newly created user
    And I should see unallocated storage increases 15GB

  @BSA.#2020 @TC.19009
  Scenario: Given stash is enabled for a user group, I can CANCEL disable stash action on the confirmation popup
    When I log in bus admin console as administrator
    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
    And I enable stash for the partner
      | stash |
      | 15    |
    And I act as newly created partner account
    And I add a new user under the default group
    And I navigate to user group list page
    And I disable stash for the default group
    Then I should see a confirmation message telling me if I really want to delete it
    And I choose no
    Then I should see stash column exists for the newly created user
    And I should see unallocated storage keeps the same

  @BSA.#2020 @TC.19010
  Scenario: Given stash is enabled for a user group, I disable stash and newly created user has no stash enabled
    When I log in bus admin console as administrator
    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
    And I enable stash for the partner
      | stash |
      | 15    |
    And I act as newly created partner account
    And I navigate to user group list page
    And I disable stash for the default group
    Then I should see a confirmation message telling me if I really want to delete it
    And I choose yes
    And I add a new user under default group
    Then the newly created user has no stash enabled

  @BSA.#2020 @TC.19020
  Scenario: Given 1 user is enabled stash, I delete the user group and users with storage resources are allocated to default user group
    When I log in bus admin console as administrator
    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
    And I enale stash for the partner
      | stash |
      | 15    |
    And I act as newly created partner account
    And I add a new user group:
    And I delete newly created user group
    Then the newly created user should be moved to default user group and storage should be moved to default group

  # Enable stash for all users
  @BSA.#2030 @TC.19011
  Scenario: Given stash is enabled for partner, I can enable stash for 0 user in the user group
    When I log in bus admin console as administrator
    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
    And I enable stash for the partner
      | stash |
      | 15    |
    And I act as newly created partner account
    And I navigate to user group list page
    And I enable stash for all users
    Then I should see confirmation message:
     | users | storage |
     | 0     | 0       |

  @BSA.#2030 @TC.19012
  Scenario: Given stash is enabled for partner and 1 user is enabled with stash, I can enable stash for other 2 users in the user group at once
    When I log in bus admin console as administrator
    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
    And I enable stash for the partner
      | stash |
      | 15    |
    And I act as newly created partner account
    And I add a new user under default group
    And I add a new user under default group
    And I add a new user under default group with stash enabled
    And I navigate to user group list page
    And I enable stash for all users
    Then I should see confirmation message:
      | users | storage |
      | 2     | 30      |
    And I click yes
    Then I should see user list with 3 users enabled with stash

  @BSA.#2030 @TC.19013
  Scenario: Given stash is enabled for partner but not enough storage for all users to enable stash I can choose buy more storage
    When I log in bus admin console as administrator
    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
    And I enable stash for the partner
      | stash |
      | 10000 |
    And I act as newly created partner account
    And I add a new user under default group
    And I navigate to user group list page
    And I enable stash for all users
    Then I should see error message that I have no enough storage
    And I click buy storage
    Then I should be navigated to buy storage page

  @BSA.#2030 @TC.19014
  Scenario: Given stash is enabled for partner but not enough storage for all users to enable stash I can choose allocate more storage
    When I log in bus admin console as administrator
    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
    And I enable stash for the partner
      | stash |
      | 10000 |
    And I act as newly created partner account
    And I add a new user under default group
    And I navigate to user group list page
    And I enable stash for all users
    Then I should see error message that I have no enough storage
    And I click allocate more storage
    Then I should be navigated to allocate storage page

    @BSA.#2030 @TC.19020
    Scenario: Given 1 user is enabled stash, I delete the user group and users with storage resources are allocated to default user group
    When I log in bus admin console as administrator
    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
    And I enale stash for the partner
      | stash |
      | 15    |
    And I act as newly created partner account
    And I add a new user group:
    And I delete newly created user group
    Then the newly created user should be moved to default user group and storage should be moved to default group

    @BSA.#2030 @TC.19018
    Scenario: Given 1 user is enabled stash, I delete the user group and users with storage resources are allocated to
default user group who has no stash enabled
    When I log in bus admin console as administrator
    And I add a new (MozyPro|MozyEnterprise|Reseller) partner:
    And I enale stash for the partner
      | stash |
      | 15    |
    And I act as newly created partner account
    And I add a new user group:
    And I delete newly created user group
    Then the newly created user should be moved to default user group and stash should be disabled for the user and
storage is returned
