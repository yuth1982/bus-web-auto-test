Feature: User Has Unique Username

  As an admin,
  I want to be told when I create a new user if the name already exists,
  So that I can choose a unique one.

  As an admin,
  when I change a user email address (username) across MH, MP, ME, MEO, MCI want to be told if the name already exists,
  So that I can choose a unique one.

  As a user,
  I want to be told when I edit a user's username if the name already exists,
  So that I can choose a unique one.

  As a user,
  I want to be told when I create an account if the name already exists,
  So that I can choose a unique one.

  Success Criteria:
  - admin username's are able to be used as user username's
  - suspended user's usernames cannot be used in account creation or added to an exhisting user
  - deleted user's usernames can be used in account creation or added to an exhisting user
  - Newly entered emails (usernames) must be unique across MozyHome, MozyPro, MozyEnterprise, MozyEnterpriseOld, and MozyCorp
  - When I update the email address, I see a error if there is a conflict within the partner or Mozy products
  - Don't cause failures when updating other fields (for example, display name) for existing users with non-unique usernames
  - Don't cause failures when updating users in other products (for example, MozyOEM)

  Scenario: Mozy-21339 : Add New Partner With Non Unique Admin Email
    When I get an admin email from the database
    And I log in bus admin console as administrator
    And I add a new MozyPro partner:
      | period | admin email           |
      | 1      | @existing_admin_email |
    Then Add New Partner error message should be:
    """
    An account with that email address already exists
    """

  Scenario: Mozy-21343:Add New Partner with Existing User Email as Admin Email
    When I get a user email from the database
    And I log in bus admin console as administrator
    And I add a new MozyPro partner:
      | period | base plan | admin email          |
      | 1      | 10 GB     | @existing_user_email |
    Then New partner should be created
    And I delete partner account

  Scenario: Mozy-21340:Edit Admin Email With Admin Email That Is Already in Use
    When I get an admin email from the database
    And I log in bus admin console as administrator
    And I view the partner info
    And I change the username to existing admin email
    Then Account Details error message should be:
    """
    An account with that email address already exists
    Email address unchanged. The email address you entered is invalid or already in use: An account with that email address already exists
    """

  Scenario:  Mozy-21346:Edit Admin Email With User Email That Is Already in Use
    When I get a user email from the database
    And I log in bus admin console as administrator
    And I view the partner info
    And I change the username to existing user email
    Then username changed success message should be displayed
    When I change the username to automation admin email
    Then username changed success message should be displayed

  Scenario: Mozy-21341:Add New Admin Role with Existing User Email
    When I get a user email from the database
    And I log in bus admin console as administrator
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name       | Email                | Roles |
      | First Last | @existing_user_email | Sales |
    Then Add New Admin success message should be displayed
    When I delete admin by:
      | email                |
      | @existing_user_email |

  Scenario: Mozy-21342:Add New Admin Role with Existing Admin Email
    When I get an admin email from the database
    And I log in bus admin console as administrator
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name       | Email                 | Roles |
      | First Last | @existing_admin_email | Sales |
    Then Add New Admin error message should be:
    """
    An account with that email address already exists
    """

  Scenario: Mozy-21347:Edit Sub Admin with Existing User Email
    When I get a user email from the database
    And I log in bus admin console as administrator
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Roles |
      | Sales |
    Then Add New Admin success message should be displayed
    When I view admin details by:
      | email        |
      | @admin_email |
    And edit admin details:
      | Email:               |
      | @existing_user_email |
    Then edit details success message should display
    When I delete admin by:
      | email                |
      | @existing_user_email |