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