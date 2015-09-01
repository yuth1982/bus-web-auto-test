Feature: Sync Delete

  Background:
    Given I log in bus admin console as administrator

  @TC.19065 @bus @machines_sync @tasks_p1
  Scenario: 19065 Partner Delete Stash container using the Delete link (Custom User Group / Email)
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    When I act as newly created partner account
    And I add a new Bundled user group:
      | name       | storage_type | enable_stash |
      | sync_group | Shared       | yes          |
    Then sync_group user group should be created
    And I add new user(s):
      | name           | user_group | storage_type | devices | enable_stash |
      | TC.19065-user1 | sync_group | Desktop      | 1       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I click delete sync device icon for the user
    Then Popup window message should be Would you like to keep the data for this instance of Sync?
    And The button displayed on the pop up are Yes No Cancel
    And I click Cancel button on popup window
    Then The sync device should not be deleted
    When I click delete sync device icon for the user
    And I click Yes button on popup window
    Then The sync device should be deleted
    Then User search results should be:
      | User                   | Name           | Sync     | Machines | Storage | Storage Used | Created | Backed Up |
      | <%=@users.last.email%> | TC.19065-user1 | Disabled | 0        | Shared  | None         | today   | never     |
    When I refresh User Details section
    Then user details should be:
      | Name:                   | Enable Sync:  |
      | TC.19065-user1 (change) | No (Add Sync) |
    And I navigate to User Group List section from bus admin console page
    When I view user group details by clicking group name: sync_group
    Then User group users list details should be:
      | Name           | Sync     | Machines | Storage | Storage Used |
      | TC.19065-user1 | Disabled | 0        | Shared  | None         |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Sync Users:            | -1 |
      | Default Sync Storage:  |    |
    And Partner stash info should be:
      | Users:         | 0 |
      | Storage Usage: | 0 |
    And I delete partner account
