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

  Scenario Outline: Display internal billing info
    When I search partner by <partner name>
    And I view partner details by <partner name>
    Then License types table header should be <expected header>
    And License desktop content should be <expected desktop info>
    And License server content should be <expected server info>

  Scenarios:
    | partner name             | expected header                                              | expected desktop info              | expected server info                |
    | Roob, Sanford and Braun  | Licenses: Licenses Used: Quota: Quota Used: Resource Policy: | Desktop 5 0 280 GB 0 bytes Enabled | Server 15 0 260 GB 0 bytes Enabled  |