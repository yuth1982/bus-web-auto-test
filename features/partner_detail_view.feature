Feature: View partner detail information

  Background:
    Given I log in bus admin console as administrator

  @test-11
  Scenario: Display partner aria id view
    #When I search partner by Roob, Sanford and Braun
    #And I view partner details by Roob, Sanford and Braun
    And I masquerade as the partner Roob, Sanford and Braun
    And I navigate to account details view
    And I set Receive Mozy Account Statements option to Yes
    Then I should see setting saved message is Successfully saved Account Statement preference.