Feature: Login freyja

  @freyja  @ent  @ent_login_logout
  Scenario: MozyEnterprise user login freyja valid username and password
    When I navigate to freyja ent login page
    And I login as a existing user
    Then freyja page is displayed
    When I select options menu
    And I logout

