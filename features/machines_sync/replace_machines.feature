Feature: Replace Machines

  Background:
   Given I log in bus admin console as administrator

  @TC.868 @bus @machines_sync @tasks_p1
  Scenario: 868 Replace a machine
    When I add a new MozyPro partner:
      | period | base plan | root role               |
      | 24     | 1 TB      | Bundle Pro Partner Root |
    Then New partner should be created
    And I change root role to FedID role
    When I act as newly created partner account
    And I add new user(s):
      | name         | user_group           | storage_type | storage_limit | devices |
      | TC.868.User1 | (default user group) | Desktop      | 100           | 10      |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name | user_name                   | machine_type |
      | Machine1_868 | <%=@new_users.first.email%> | Desktop      |
    And I update newly created machine encryption value to Default
    Then I use keyless activation to activate devices
      | machine_name | user_name                   | machine_type |
      | Machine2_868 | <%=@new_users.first.email%> | Desktop      |
    And I update newly created machine encryption value to Default
    And I navigate to Search / List Machines section from bus admin console page
    And I view machine details for Machine1_868
    And I click on the replace machine link
    And I select Machine2_868 to be replaced
    And I navigate to Search / List Machines section from bus admin console page
    Then replace machine message should be Replace operation was successful.
    And I search machine by:
      | machine_name |
      | Machine2_868 |
    Then I should not search out machine record
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

