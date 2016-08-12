Feature: Add a new partner


  Background:
    Given I log in bus admin console as administrator

  @TC.120167 @bus @regression
  Scenario: 120167 Error will occur if no 'Security' option is selected during partner creation
    When I add a new MozyPro partner:
      | period | security |
      | 12     |          |
    Then Add New Partner error message should be:
      """
      Security field cannot be blank
      """
    Then I add a new OEM partner:
      | company_name  | security |
      | TC.120167.OEM |          |
    Then Add New Partner error message should be:
      """
      Security field cannot be blank
      """

  @TC.21339 @bus @2.5 @add_new_partner @existing_email @regression
  Scenario: 21339 : Add New Partner With Non Unique Admin Email
    When I get an admin email from the database
    And I add a new MozyPro partner:
      | period | admin email           |
      | 1      | @existing_admin_email |
    Then Add New Partner error message should be:
    """
    An account with that email address already exists
    """

  @TC.21343 @bus @2.5 @add_new_partner @existing_email @regression
  Scenario: 21343:Add New Partner with Existing User Email as Admin Email
    When I get a user email from the database
    And I add a new MozyPro partner:
      | period | base plan | admin email          |
      | 1      | 10 GB     | @existing_user_email |
    Then New partner should be created
    And I delete partner account
