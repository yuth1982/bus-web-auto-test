# If you want to run these testcases in other environment other than QA5, You need to prepare these data
# To do: I will add a new feature to prepare these data automately
# AD server is needed in the environment
# (1). Add some partners with the following partner name and admin if not exist
# | partner name                      | admin                                    | usage                               |
# | Never Synced Test                 | user_sync_never_synced@auto.com          | the partner never synced            |
# | User Sync Automation              | user_sync_automation@auto.com            | general, mainly for the ui          |
# | Fed ID Partner                    | leongh+adi@mozy.com                      | users in this partner can login     |
# | Machine Migration for TC16273     | user_sync_add_delete@auto.com            | add/delete users in the AD          |
# | Partner that has subpartner       | usrsync@test.com                         | scheduled sync                      |
# (2). add 3 groups to each partner: dev, qa, pm
# (3). add 9 users to AD server:
# dev_test1/dev_test1@test.com, dev_test2, dev_test3,
# qa_test1/qa_test1@test.com, qa_test2, qa_test3
# pm_test1/pm_test1@test.com, pm_test2, pm_test3
# (4). Update the following files: db_helper.rb, ldap_helper.rb
# configure the db, ldap to match the specified environment

Feature: User sync

  As an Mozy administrator
  I want to sync users from AD
  So that the partner admin can manage their users easily

  Background:
    Given I log in bus admin console as administrator

  @TC.17518 @ui
  Scenario: Check the UI when the partner has never synced
    When I act as partner by:
      | email                           |
      | user_sync_never_synced@auto.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    Then The sync status result should be:
      | current status       | last sync | next sync |
      | Never synchronized   |           |           |

  @TC.17519 @ui
  Scenario: Sync Now
    When I act as partner by:
      | email                         |
      | user_sync_automation@auto.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Sync Rules tab
    And I click the sync now button
    And I wait for 70 seconds
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |

  @TC.17529 @ui
  Scenario: Check the Attribute mapping UI
    When I act as partner by:
      | email                         |
      | user_sync_automation@auto.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Attribute Mapping tab
    Then The layout of attribute should:
      | Mozy              | Username:      | Name:      |Fixed Attribute |
      | Directory Service | mail           |  cn        |                |
    When I save the changes
    Then Authentication Policy has been updated successfully

  @TC.17530 @ui
  Scenario: Local groups dropdown list check
    When I act as partner by:
      | email                         |
      | user_sync_automation@auto.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new provision rules:
      | rule         | group|
      | cn=dev_test* |      |
    Then There should be 4 provision items:
      | (default user group) | dev | pm | qa |

  @TC.17531 @ui
  Scenario: User provision - Rules ordering interaction
    When I act as partner by:
      | email                         |
      | user_sync_automation@auto.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 3 new provision rules:
      | rule         | group|
      | cn=dev_test* | dev  |
      | cn=pm_test*  | pm   |
      | cn=qa_test*  | qa   |
    Then The provision order icon should be correct
      | up hidden | down        | delete |
      | up        | down        | delete |
      | up        | down hidden | delete |
    When I change the provision order by the following rule:
      | 1 | down |
      | 2 |      |
      | 3 | up   |
    Then The new provision rules order should be:
      | rule         | group|
      | cn=pm_test*  | pm   |
      | cn=qa_test*  | qa   |
      | cn=dev_test* | dev  |
    When I save the changes
    Then Authentication Policy has been updated successfully

    And I delete 3 provision rules
    And I save the changes

  @TC.17532 @ui
  Scenario: User provision - Delete rules
    When I act as partner by:
      | email                         |
      | user_sync_automation@auto.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 3 new provision rules:
      | rule         | group|
      | cn=dev_test* | dev  |
      | cn=pm_test*  | dev  |
      | cn=qa_test*  | dev  |
    And I delete 1 provision rules
    And I save the changes
    Then The provision rule number is 2
    And Authentication Policy has been updated successfully
    When I delete 2 provision rules
    And I save the changes
    Then The provision rule number is 0
    And Authentication Policy has been updated successfully

  @TC.17534 @ui
  Scenario: UserDestruction - UI Components check
    When I act as partner by:
      | email                         |
      | user_sync_automation@auto.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule         | action |
      | cn=dev_test* |        |
    Then There should be 3 deprovision items:
      | Take no action | Suspend | Delete |
    And The selected deprovision option is Take no action

  @TC.17535 @ui
  Scenario: UserDestruction - Rules ordering interaction
    When I act as partner by:
      | email                         |
      | user_sync_automation@auto.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 3 new deprovision rules:
      | rule         | action  |
      | cn=dev_test* | Delete  |
      | cn=pm_test*  | Delete  |
      | cn=qa_test*  | Delete  |
    Then The deprovision order icon should be correct
      | up hidden | down        | delete |
      | up        | down        | delete |
      | up        | down hidden | delete |
    When I change the deprovision order by the following rule:
      | 1 | down |
      | 2 |      |
      | 3 | up   |
    Then The new deprovision rules order should be:
      | rule         | action  |
      | cn=pm_test*  | Delete  |
      | cn=qa_test*  | Delete  |
      | cn=dev_test* | Delete  |
    When I save the changes
    Then Authentication Policy has been updated successfully

    And I delete 3 deprovision rules
    And I save the changes

  @TC.17536 @ui
  Scenario: UserDestruction - Rules deletion
    When I act as partner by:
      | email                         |
      | user_sync_automation@auto.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 3 new deprovision rules:
      | rule         | action |
      | cn=dev_test* | Delete |
      | cn=pm_test*  | Delete |
      | cn=qa_test*  | Delete |
    And I delete 1 deprovision rules
    When I save the changes
    Then The deprovision rule number is 2
    And Authentication Policy has been updated successfully
    When I delete 2 deprovision rules
    And I save the changes
    Then The deprovision rule number is 0
    And Authentication Policy has been updated successfully

  @TC.17538 @TC.17551  @smoke @function
  Scenario: One Rule/Match All/Multiple Users
    When I act as partner by:
      | email                         |
      | user_sync_automation@auto.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Sync Rules tab
    And I add 1 new provision rules:
      | rule         | group |
      | cn=dev_test* | dev   |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    Then Synced users table should be:
      | User               |      Name     | User Group  |
      | dev_test3@test.com |   dev_test3   | dev         |
      | dev_test2@test.com |   dev_test2   | dev         |
      | dev_test1@test.com |   dev_test1   | dev         |
    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule         | action  |
      | cn=dev_test* | Delete  |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 1 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    Then The users table should be empty

  @TC.17540 @TC.17552 @function
  Scenario: One Rule/Multiple Rules
    When I act as partner by:
      | email                         |
      | user_sync_automation@auto.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Sync Rules tab
    And I add 1 new provision rules:
      | rule                                                                  | group |
      | (&(objectClass=user)(\|(\|(cn=dev_test*)(cn=pm_test*))(cn=qa_test*))) | dev   |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    Then Synced users table should be:
      | User               |      Name     | User Group  |
      | qa_test3@test.com  |   qa_test3    | dev         |
      | qa_test2@test.com  |   qa_test2    | dev         |
      | qa_test1@test.com  |   qa_test1    | dev         |
      | pm_test3@test.com  |   pm_test3    | dev         |
      | pm_test2@test.com  |   pm_test2    | dev         |
      | pm_test1@test.com  |   pm_test1    | dev         |
      | dev_test3@test.com |   dev_test3   | dev         |
      | dev_test2@test.com |   dev_test2   | dev         |
      | dev_test1@test.com |   dev_test1   | dev         |
    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule                                                                  | action  |
      | (&(objectClass=user)(\|(\|(cn=dev_test*)(cn=pm_test*))(cn=qa_test*))) | Delete  |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 1 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    Then The users table should be empty

  @TC.17542 @TC.17554 @function
  Scenario: Multiple Ruls/Multiple Users
    When I act as partner by:
      | email                         |
      | user_sync_automation@auto.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Sync Rules tab
    And I add 3 new provision rules:
      | rule         | group |
      | cn=dev_test* | dev   |
      | cn=pm_test*  | pm    |
      | cn=qa_test*  | qa    |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 3 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    Then Synced users table should be:
      | User               |      Name     | User Group  |
      | qa_test3@test.com  |   qa_test3    | qa          |
      | qa_test2@test.com  |   qa_test2    | qa          |
      | qa_test1@test.com  |   qa_test1    | qa          |
      | pm_test3@test.com  |   pm_test3    | pm          |
      | pm_test2@test.com  |   pm_test2    | pm          |
      | pm_test1@test.com  |   pm_test1    | pm          |
      | dev_test3@test.com |   dev_test3   | dev         |
      | dev_test2@test.com |   dev_test2   | dev         |
      | dev_test1@test.com |   dev_test1   | dev         |
    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 3 new deprovision rules:
      | rule         | action   |
      | cn=dev_test* | Delete   |
      | cn=pm_test*  | Delete   |
      | cn=qa_test*  | Delete   |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 3 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    Then The users table should be empty

  @TC.17543 @TC.17557 @TC.17558 @function
  Scenario: Multiple Ruls/Multiple Users/Rule order matters
    When I act as partner by:
      | email                         |
      | user_sync_automation@auto.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Sync Rules tab
    And I add 4 new provision rules:
      | rule                                                | group |
      | cn=dev_test*                                        | dev   |
      | cn=pm_test*                                         | dev   |
      | cn=pm_test*                                         | pm    |
      | cn=qa_test*                                         | qa    |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 4 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    Then Synced users table should be:
      | User               |      Name     | User Group  |
      | qa_test3@test.com  |   qa_test3    | qa          |
      | qa_test2@test.com  |   qa_test2    | qa          |
      | qa_test1@test.com  |   qa_test1    | qa          |
      | pm_test3@test.com  |   pm_test3    | dev         |
      | pm_test2@test.com  |   pm_test2    | dev         |
      | pm_test1@test.com  |   pm_test1    | dev         |
      | dev_test3@test.com |   dev_test3   | dev         |
      | dev_test2@test.com |   dev_test2   | dev         |
      | dev_test1@test.com |   dev_test1   | dev         |
    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 2 new deprovision rules:
      | rule         | action           |
      | cn=dev_test* | Take no action   |
      | cn=dev_test* | Delete           |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 2 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    Then Synced users table should be:
      | User               |      Name     | User Group  |
      | qa_test3@test.com  |   qa_test3    | qa          |
      | qa_test2@test.com  |   qa_test2    | qa          |
      | qa_test1@test.com  |   qa_test1    | qa          |
      | pm_test3@test.com  |   pm_test3    | dev         |
      | pm_test2@test.com  |   pm_test2    | dev         |
      | pm_test1@test.com  |   pm_test1    | dev         |
      | dev_test3@test.com |   dev_test3   | dev         |
      | dev_test2@test.com |   dev_test2   | dev         |
      | dev_test1@test.com |   dev_test1   | dev         |
    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 3 new deprovision rules:
      | rule         | action   |
      | cn=dev_test* | Delete   |
      | cn=pm_test*  | Delete   |
      | cn=qa_test*  | Delete   |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 3 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    Then The users table should be empty

  @TC.17544 @function
  Scenario: UserProvision - Multiple Ruls/Multiple Users/Change Rules
    When I act as partner by:
      | email                         |
      | user_sync_automation@auto.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Sync Rules tab
    And I add 3 new provision rules:
      | rule         | group |
      | cn=dev_test* | dev   |
      | cn=pm_test*  | pm    |
      | cn=qa_test*  | qa    |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 3 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    Then Synced users table should be:
      | User               |      Name     | User Group |
      | qa_test3@test.com  |   qa_test3    | qa         |
      | qa_test2@test.com  |   qa_test2    | qa         |
      | qa_test1@test.com  |   qa_test1    | qa         |
      | pm_test3@test.com  |   pm_test3    | pm         |
      | pm_test2@test.com  |   pm_test2    | pm         |
      | pm_test1@test.com  |   pm_test1    | pm         |
      | dev_test3@test.com |   dev_test3   | dev        |
      | dev_test2@test.com |   dev_test2   | dev        |
      | dev_test1@test.com |   dev_test1   | dev        |
    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 3 new provision rules:
      | rule         | group |
      | cn=dev_test* | (default user group)   |
      | cn=pm_test*  | (default user group)   |
      | cn=qa_test*  | (default user group)   |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 3 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    Then Synced users table should be:
      | User               |      Name     | User Group  |
      | qa_test3@test.com  |   qa_test3    | (default user group)        |
      | qa_test2@test.com  |   qa_test2    | (default user group)        |
      | qa_test1@test.com  |   qa_test1    | (default user group)        |
      | pm_test3@test.com  |   pm_test3    | (default user group)        |
      | pm_test2@test.com  |   pm_test2    | (default user group)        |
      | pm_test1@test.com  |   pm_test1    | (default user group)        |
      | dev_test3@test.com |   dev_test3   | (default user group)        |
      | dev_test2@test.com |   dev_test2   | (default user group)        |
      | dev_test1@test.com |   dev_test1   | (default user group)        |
    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 3 new deprovision rules:
      | rule         | action   |
      | cn=dev_test* | Delete   |
      | cn=pm_test*  | Delete   |
      | cn=qa_test*  | Delete   |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 3 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    Then The users table should be empty

  @TC.17559 @function
  Scenario: Empty rules will be filtered
    When I act as partner by:
      | email                         |
      | user_sync_automation@auto.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule         | action |
      |              |        |
    And I save the changes
    Then Authentication Policy has been updated successfully

  @TC.17560 @function
  Scenario: Unknown query string
    When I act as partner by:
      | email                         |
      | user_sync_automation@auto.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule         | action |
      | abcd         |        |
    And I save the changes
    Then The save error message should be:
      | Save failed                          |
      | abcd is not a valid value for query. |

  @TC.18738 @function
  Scenario: UserProvision-Delete a group, the users belong to this group will be moved to default group
    When I act as partner by:
      | email                         |
      | user_sync_automation@auto.com |
    And I navigate to Add New User Group section from bus admin console page
    And I add a new user group:
      | name        |
      | test_delete |
    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Sync Rules tab
    And I add 1 new provision rules:
      | rule         | group       |
      | cn=dev_test* | test_delete |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    Then Synced users table should be:
      | User               |      Name     | User Group  |
      | dev_test3@test.com |   dev_test3   | test_delete |
      | dev_test2@test.com |   dev_test2   | test_delete |
      | dev_test1@test.com |   dev_test1   | test_delete |
    And I search and delete test_delete user group
    And I refresh the search list user group page
    Then Synced users table should be:
      | User               |      Name     | User Group          |
      | dev_test1@test.com |   dev_test1   | (default user group)|
      | dev_test2@test.com |   dev_test2   | (default user group)|
      | dev_test3@test.com |   dev_test3   | (default user group)|
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule         | action  |
      | cn=dev_test* | Delete  |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 1 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    Then The users table should be empty

  @TC.17592 @firefox_profile @vpn
  Scenario: UserProvision - Deleted users in BUS can be resumed
    When I act as partner by:
      | email               |
      | leongh+adi@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Sync Rules tab
    And I add 1 new provision rules:
      | rule             | group |
      | cn=auto1         | dev   |
    And I click the sync now button
    And I wait for 100 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                   | filter |
      | auto1@client7.mozyqa.local | None   |
    Then Synced users table should be:
      | User                       | Name       | User Group  |
      | auto1@client7.mozyqa.local | auto1      | dev         |
    When I view user details by auto1@client7.mozyqa.local
    Then The user status should be Active
    When I login the subdomain qa5adtest05
    Then I will see the user account page

    When I log in bus admin console as administrator
    When I act as partner by:
      | email               |
      | leongh+adi@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule             | action |
      | cn=auto1         | Delete |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 1 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                   | filter |
      | auto1@client7.mozyqa.local | None   |
    Then The users table should be empty
    When I login the subdomain qa5adtest05
    Then I will see the Authentication Failed page

    When I log in bus admin console as administrator
    When I act as partner by:
      | email               |
      | leongh+adi@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new provision rules:
      | rule             | group |
      | cn=auto1         | dev   |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                   | filter |
      | auto1@client7.mozyqa.local | None   |
    Then Synced users table should be:
      | User                       | Name       | User Group  |
      | auto1@client7.mozyqa.local | auto1      | dev         |
    When I view user details by auto1@client7.mozyqa.local
    Then The user status should be Active
    When I login the subdomain qa5adtest05
    Then I will see the user account page

  @TC.17593 @firefox_profile @vpn
  Scenario: UserProvision - Suspended users in BUS can't be resumed
    When I act as partner by:
      | email               |
      | leongh+adi@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Sync Rules tab
    And I add 1 new provision rules:
      | rule             | group |
      | cn=auto1         | dev   |
    And I click the sync now button
    And I wait for 100 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                   | filter |
      | auto1@client7.mozyqa.local | None   |
    Then Synced users table should be:
      | User                       | Name       | User Group  |
      | auto1@client7.mozyqa.local | auto1      | dev         |
    When I view user details by auto1@client7.mozyqa.local
    Then The user status should be Active
    When I login the subdomain qa5adtest05
    Then I will see the user account page

    When I log in bus admin console as administrator
    And I act as partner by:
      | name          |
      |ADI 4 Autodesk |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule             | action  |
      | cn=auto1         | Suspend |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 1 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                   | filter |
      | auto1@client7.mozyqa.local | None   |
    Then Synced users table should be:
      | User                       | Name       | User Group  |
      | auto1@client7.mozyqa.local | auto1      | dev         |
    When I view user details by auto1@client7.mozyqa.local
    And The user status should be Suspended
    And I login the subdomain qa5adtest05
    Then I will see the Authentication Failed page

    When I log in bus admin console as administrator
    And I act as partner by:
      | name          |
      |ADI 4 Autodesk |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new provision rules:
      | rule             | group |
      | cn=auto1         | dev   |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                   | filter |
      | auto1@client7.mozyqa.local | None   |
    Then Synced users table should be:
      | User                       | Name       | User Group  |
      | auto1@client7.mozyqa.local | auto1      | dev         |
    When I view user details by auto1@client7.mozyqa.local
    Then The user status should be Suspended
    When I login the subdomain qa5adtest05
    Then I will see the Authentication Failed page

    And I log in bus admin console as administrator
    And I search user by:
      | keywords                   | filter |
      | auto1@client7.mozyqa.local | None   |
    And I view user details by auto1@client7.mozyqa.local
    And I active the user

  @TC.17594 @firefox_profile @vpn
  Scenario: UserProvision - Delete user after several days of not synced
    When I act as partner by:
      | email               |
      | leongh+adi@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Sync Rules tab
    And I add 1 new provision rules:
      | rule             | group |
      | cn=auto1         | dev   |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                   | filter |
      | auto1@client7.mozyqa.local | None   |
    Then Synced users table should be:
      | User                       | Name       | User Group  |
      | auto1@client7.mozyqa.local | auto1      | dev         |
    When I view user details by auto1@client7.mozyqa.local
    And I get the user id
    And I login the subdomain qa5adtest05
    Then I will see the user account page

    When I log in bus admin console as administrator
    And I act as partner by:
      | name          |
      |ADI 4 Autodesk |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I Choose to delete users if missing from LDAP for 90 days
    And I change the user last sync field in the db to be 90 days earlier
    And I click the sync now button
    And I wait for 80 seconds
    And I clear the user sync information
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                   | filter |
      | auto1@client7.mozyqa.local | None   |
    Then The users table should be empty
    When I login the subdomain qa5adtest05
    Then I will see the Authentication Failed page

  @TC.17595 @firefox_profile @vpn
  Scenario: UserProvision - Suspend user after several days of not synced
    When I act as partner by:
      | email               |
      | leongh+adi@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Sync Rules tab
    And I add 1 new provision rules:
      | rule             | group |
      | cn=auto1         | dev   |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                   | filter |
      | auto1@client7.mozyqa.local | None   |
    Then Synced users table should be:
      | User                       | Name       | User Group  |
      | auto1@client7.mozyqa.local | auto1      | dev         |
    When I view user details by auto1@client7.mozyqa.local
    And I get the user id
    And I login the subdomain qa5adtest05
    Then I will see the user account page

    When I log in bus admin console as administrator
    And I act as partner by:
      | name          |
      |ADI 4 Autodesk |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I Choose to suspend users if missing from LDAP for 90 days
    And I change the user last sync field in the db to be 90 days earlier
    And I click the sync now button
    And I wait for 90 seconds
    And I clear the user sync information
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                   | filter |
      | auto1@client7.mozyqa.local | None   |
    Then Synced users table should be:
      | User                       | Name       | User Group  |
      | auto1@client7.mozyqa.local | auto1      | dev         |
    When I view user details by auto1@client7.mozyqa.local
    Then The user status should be Suspended
    When I login the subdomain qa5adtest05
    Then I will see the Authentication Failed page

    And I log in bus admin console as administrator
    And I search user by:
      | keywords                   | filter |
      | auto1@client7.mozyqa.local | None   |
    And I view user details by auto1@client7.mozyqa.local
    And I active the user

  @TC.17546 @TC.17548 @TC.17549 @vpn
  Scenario: UserProvision/Sync - Add(Delete, Modify) a new user in AD
    When I act as partner by:
      | email                         |
      | user_sync_add_delete@auto.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Sync Rules tab
    And I add 1 new provision rules:
      | rule         | group |
      | cn=dev_user* | dev   |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    Then Synced users table should be:
      | User               |      Name     | User Group  |
      | dev_user3@test.com |   dev_user3   | dev         |
      | dev_user2@test.com |   dev_user2   | dev         |
      | dev_user1@test.com |   dev_user1   | dev         |
    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add a user dev_user4 to the AD
    And I add 1 new provision rules:
      | rule         | group |
      | cn=dev_user* | dev   |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    Then Synced users table should be:
      | User               |      Name     | User Group  |
      | dev_user4@test.com |   dev_user4   | dev         |
      | dev_user3@test.com |   dev_user3   | dev         |
      | dev_user2@test.com |   dev_user2   | dev         |
      | dev_user1@test.com |   dev_user1   | dev         |

    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I modify a user dev_user4 to dev_user44 in the AD:
    And I add 1 new provision rules:
      | rule         | group |
      | cn=dev_user* | dev   |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    Then Synced users table should be:
      | User               |      Name     | User Group  |
      | dev_user4@test.com |   dev_user44   | dev        |
      | dev_user3@test.com |   dev_user3   | dev         |
      | dev_user2@test.com |   dev_user2   | dev         |
      | dev_user1@test.com |   dev_user1   | dev         |

    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I delete a user dev_user44 in the AD
    And I add 1 new provision rules:
      | rule         | group |
      | cn=dev_user* | dev   |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    Then Synced users table should be:
      | User                |      Name     | User Group  |
      | dev_user4@test.com  |   dev_user44  | dev         |
      | dev_user3@test.com  |   dev_user3   | dev         |
      | dev_user2@test.com  |   dev_user2   | dev         |
      | dev_user1@test.com  |   dev_user1   | dev         |

    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add a user dev_user4 to the AD
    And I modify a user dev_user4 to dev_user44 in the AD:
    And I add 1 new deprovision rules:
      | rule         | action  |
      | cn=dev_user* | Delete  |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 1 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    Then The users table should be empty
  
    And I delete a user dev_user44 in the AD

  @TC.18273 @vpn
  Scenario: UserProvision-Fixed Attribute
    When I act as partner by:
      | email                         |
      | user_sync_add_delete@auto.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Attribute Mapping tab
    And I set the fixed attribute to uid
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Sync Rules tab
    And I add a user dev_user4 to the AD
    And I add 1 new provision rules:
      | rule         | group |
      | cn=dev_user* | dev   |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    Then Synced users table should be:
      | User               |      Name     | User Group  |
      | dev_user4@test.com |   dev_user4   | dev         |
      | dev_user3@test.com |   dev_user3   | dev         |
      | dev_user2@test.com |   dev_user2   | dev         |
      | dev_user1@test.com |   dev_user1   | dev         |

    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I update a user in the AD:
      | username  | attribute | value                        |
      | dev_user4 | mail       | dev_user44@test.com   |
    And I add 1 new provision rules:
      | rule         | group |
      | cn=dev_user* | dev   |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    Then Synced users table should be:
      | User                |      Name     | User Group  |
      | dev_user44@test.com |   dev_user4   | dev         |
      | dev_user3@test.com  |   dev_user3   | dev         |
      | dev_user2@test.com  |   dev_user2   | dev         |
      | dev_user1@test.com  |   dev_user1   | dev         |

    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule         | action  |
      | cn=dev_user* | Delete  |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 1 deprovision rules
    And I click Attribute Mapping tab
    And I clear the fixed attribute
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           |
      | Synchronized         |   @last_sync_time   |
    When I navigate to Search / List Users section from bus admin console page
    Then The users table should be empty

    And I delete a user dev_user4 in the AD


  @TC.17521 @TC.17522 @TC.17523 @scheduled_sync
  Scenario: Scheduled Sync (UI, cancel)
    When I act as partner by:
      | email            |
      | usrsync@test.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Sync Rules tab
    And I choose to daily sync at 0 GMT
    And I click the sync now button
    And I wait for 80 seconds
    Then The daily sync time should be 0 GMT
    When I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           | next sync       |
      | Synchronized         |   @last_sync_time   | 0               |
    And I click Sync Rules tab
    And I clear the daily sync information
    And I click the sync now button
    And I wait for 80 seconds
    Then The daily sync time should be empty
    When I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           | next sync       |
      | Synchronized         |   @last_sync_time   |                 |

  @TC.17520  @slow @scheduled_sync
  Scenario: Scheduled Sync
    When I act as partner by:
      | email            |
      | usrsync@test.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Sync Rules tab
    And I choose to sync daily at the nearest sharp time
    And I save the changes
    And I wait until the sharp time
    And I wait for 80 seconds
    And I click Connection Settings tab
    Then The sync status result should like:
      | current status       | last sync           | next sync       |
      | Synchronized         |   @last_sync_time   | @next_sync_time |