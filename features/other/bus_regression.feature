Feature: BUS Regression Test

  Background:
    Given I log in bus admin console as administrator

  @TC.2188 @bus @others
  Scenario: 2188 XXS issues and input validation
    When I search partner by <script>alert('foo')</script>
    Then I will see alert('foo') in the search partner input box

  @TC.18897 @bus @others
  Scenario: 18897 Deletion is triggered by admins in the bus(Mozypro,business,yearly)
    When I add a new MozyPro partner:
      | period | users | server plan | server add on |
      | 12     | 10    | 100 GB      | 1             |
    And New partner should be created
    And I get partner aria id
    And I delete partner account
    When API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label |
      | CANCELLED    |