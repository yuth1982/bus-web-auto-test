Feature: Login freyja

  @OEM_login
  Scenario: OEM user login freyja valid username and password
    When I navigate to freyja OEM login page
    And I login as a existing user
    Then freyja page is displayed
