Feature: Login freyja

  @MozyPro_login
  Scenario: MozyPro user login freyja valid username and password
    When I navigate to freyja MozyPro login page
    And I login as a existing user
    Then freyja page is displayed

