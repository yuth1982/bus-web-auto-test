Feature: Manage Horizon related settings

  As an Mozy administrator
  I want to leverage Horizon service as a 3rd party SSO solution
  So that my users can be authenticated using domain credentials

  Background:
    Given I log in bus admin console as administrator

  @TC.17470
  Scenario: Successfully verify 'Test Connection' button should work with valid organization name
    When I act as the partner by mikeg+fedid@mozy.com on admin details panel
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I select Horizon Manager with organization name mozyqa2
    And I click Test Connection button
    Then Horizon Manager test connection message should be Test passed.