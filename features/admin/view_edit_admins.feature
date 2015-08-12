Feature: View edit admins

  Background:
    Given I log in bus admin console as administrator

###############################################################################

  # Change Password

################################################################################
  @TC.12435  @bus @admin
  Scenario: 12435 Standard Login admin change sub-admin's password successfully
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 12     | 1     | 1 TB        | FedID role |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name        | Roles      | User Group           |
      | Admin_12435 | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    And the partner has activated the sub-admin account with default password
    And the partner has activated the admin account with default password
    And I go to account
    Then I login as mozypro admin successfully
    And I view admin details by:
      | name        |
      | Admin_12435 |
    And I change admin password to Standard password
    Then I can change admin password successfully
    And I log out bus admin console
    And I log in bus admin console with user name <%=@admin.email%> and password Standard password
    Then I login as Admin_12435 admin successfully
    And I log out bus admin console
    And I log into phoenix with username <%=@admin.email%> and password Standard password
    Then I login as Admin_12435 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name


  ##############################################################################################################

  # Admin : Account details

  ##############################################################################################################
  @TC.1989 @bus @admin
  Scenario: 1989 Edit an admin's name
    When I add a new MozyPro partner:
      | period | base plan | country | cc number         |
      | 1      | 50 GB     | France  | 4485393141463880  |
    Then New partner should be created
    And I act as newly created partner account
    And I click admin name on the top right
    When I change the display name to admin.new.name
    Then display name changed success message should be displayed
    And I stop masquerading
    And I search and delete partner account by newly created partner company name