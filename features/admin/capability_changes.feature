Feature: Manage admin capability change 

  As an Mozy administrator
  I can manage admin's capabilities 

  Background:
    Given I log in bus admin console as administrator

  @TC.700
  Scenario: Check partners list/view check to make sure you can't change the name
    When I navigate to Add New Role section from bus admin console page
    And I add a new role
    Then new role created message should be present 
    And I check capabilities for the new role:
      | Capabilities        |
      | Partners: list/view |
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
    # Multiple roles can be specified as role1, role2, role3 (separated by comma)
      | Roles     |
      | @new_role |
    Then new admin should be created
    And I act as admin by:
      | email      |
      | @new_admin |
    Then I should see capabilities in Admin Console panel
      | Capabilities |
      | Search / List Partners |
    And I navigate to Search / List Partners section from bus admin console page
    And I list partner details for a partner in partner list
    And I cannot change partner name
    And I log in bus admin console as administrator
    And I delete admin by:
      | email                 |
      | @new_admin |
    And I delete role @new_role


  @TC.699
  Scenario: Check Delete a partner with invalid password
    When I navigate to Add New Role section from bus admin console page
    And I add a new role
    Then new role created message should be present 
    And I check capabilities for the new role:
      | Capabilities        |
      | Partners: delete    |
      | Partners: list/view |
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
    # Multiple roles can be specified as role1, role2, role3 (separated by comma)
      | Roles     |
      | @new_role |
    Then new admin should be created
    And I act as admin by:
      | email      |
      | @new_admin |
    Then I should see capabilities in Admin Console panel
      | Capabilities |
      | Search / List Partners |
    And I navigate to Search / List Partners section from bus admin console page
    And I list partner details for a partner in partner list
    And I can delete partner
    And I delete partner account with password xxx
    And I log in bus admin console as administrator
    And I delete admin by:
      | email      |
      | @new_admin |
    And I delete role @new_role

  @TC.698
  Scenario: Check Delete a partner works
    When I navigate to Add New Role section from bus admin console page
    And I add a new role
    Then new role created message should be present 
    And I check capabilities for the new role:
      | Capabilities        |
      | Partners: delete    |
      | Partners: list/view |
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
    # Multiple roles can be specified as role1, role2, role3 (separated by comma)
      | Roles                 |
      | @new_role             |
    Then new admin should be created
    And I act as admin by:
      | email      |
      | @new_admin |
    Then I should see capabilities in Admin Console panel
      | Capabilities |
      | Search / List Partners |
    And I navigate to Search / List Partners section from bus admin console page
    And I list partner details for a partner in partner list
    And I can delete partner
    And I delete partner account
    And I log in bus admin console as administrator
    And I delete admin by:
      | email      |
      | @new_admin |
    And I delete role @new_role

  @TC.697
  Scenario: Check partners Delete, List/View capability
    When I navigate to Add New Role section from bus admin console page
    And I add a new role
    Then new role created message should be present 
    And I check capabilities for the new role:
      | Capabilities        |
      | Partners: delete    |
      | Partners: list/view |
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
    # Multiple roles can be specified as role1, role2, role3 (separated by comma)
      | Roles  |
      | @new_role |
    Then new admin should be created
    And I act as admin by:
      | email      |
      | @new_admin |
    Then I should see capabilities in Admin Console panel
      | Capabilities |
      | Search / List Partners |
    And I navigate to Search / List Partners section from bus admin console page
    And I list partner details for a partner in partner list
    And I can delete partner
    And I log in bus admin console as administrator
    And I delete admin by:
      | email      |
      | @new_admin |
    And I delete role @new_role

  @TC.696
  Scenario: Check partners Edit, List/View capability
    When I navigate to Add New Role section from bus admin console page
    And I add a new role
    Then new role created message should be present 
    And I check capabilities for the new role:
      | Capabilities        |
      | Partners: edit       |
      | Partners: list/view |
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
    # Multiple roles can be specified as role1, role2, role3 (separated by comma)
      | Roles  |
      | @new_role |
    Then new admin should be created
    And I act as admin by:
      | email      |
      | @new_admin |
    Then I should see capabilities in Admin Console panel
      | Capabilities |
      | Search / List Partners |
    And I navigate to Search / List Partners section from bus admin console page
    And I list partner details for a partner in partner list
    And I can change partner name
    And I can change fields:
      | fields      |
      | External ID: |
      | Root Role:   |
    Then I can edit partner details fields:
      | fields |
      | Phone:  |
      | Industry: |
      | # of employees: |
    And I log in bus admin console as administrator
    And I delete admin by:
      | email      |
      | @new_admin |
    And I delete role @new_role

  @TC.695
  Scenario: Check partners Add, List/View capability
    When I navigate to Add New Role section from bus admin console page
    And I add a new role
    Then new role created message should be present 
    And I check capabilities for the new role:
      | Capabilities        |
      | Partners: add       |
      | Partners: list/view |
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
    # Multiple roles can be specified as role1, role2, role3 (separated by comma)
      | Roles  |
      | @new_role |
    Then new admin should be created
    And I act as admin by:
      | email                  |
      | @new_admin |
    Then I should see capabilities in Admin Console panel
      | Capabilities |
      | Search / List Partners |
      | Add New Partner        |
    And I log in bus admin console as administrator
    And I delete admin by:
      | email      |
      | @new_admin |
    And I delete role @new_role
