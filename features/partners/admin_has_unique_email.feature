Feature: Admin Has Unique Email

  As an admin,
  I want to be told when I create a new user if the name already exists,
  So that I can choose a unique one.

  As an admin,
  when I change a user email address (username) across MH, MP, ME, MEO, MCI want to be told if the name already exists,
  So that I can choose a unique one.


  @TC.21339 @bus @2.5 @add_new_partner @existing_email
  Scenario: 21339 : Add New Partner With Non Unique Admin Email
  When I get an admin email from the database
  And I log in bus admin console as administrator
  And I add a new MozyPro partner:
  | period | admin email           |
  | 1      | @existing_admin_email |
  Then Add New Partner error message should be:
  """
      An account with that email address already exists
      """

  @TC.21343 @bus @2.5 @add_new_partner @existing_email
  Scenario: 21343:Add New Partner with Existing User Email as Admin Email
  When I get a user email from the database
  And I log in bus admin console as administrator
  And I add a new MozyPro partner:
  | period | base plan | admin email          |
  | 1      | 10 GB     | @existing_user_email |
  Then New partner should be created
  And I delete partner account