Feature: Manage Internal Jobs in Internal Tools in Admin Console

  Background:
    Given I log in bus admin console as administrator

  @TC.122215 @bus @internal_tools @smoke @ROR @ROR_smoke
  Scenario: 122215 Migrate a partner
    #======step1: create an OEM partner======
    When I add a new OEM partner:
      | Company Name    | Root role     | Security | Company Type  |
      | test_for_122215 | ITOK OEM Root | HIPAA    | Reseller      |
    Then New partner should be created
    #======step2: search the partner and verify the Pooled Resource option on partner details======
    Given I log in bus admin console as administrator
    When I search partner by test_for_122215
    And I view partner details by test_for_122215
    And I get the partner_id
    And Partner general information should be:
      | Pooled Resource: |
      | No               |
    Given I navigate to Manage Internal Jobs section from bus admin console page
    #======step3: start job to the partner======
    When I setup a internal job for parnter newly created partner id and provide note Testing for internal job
    Then I submit a internal job
    And I wait for the Testing internal job done
    #======step4: after that, the Pooled Resource should be updated======
    When I search partner by test_for_122215
    And I view partner details by test_for_122215
    And I get the partner_id
    Then Partner general information should be:
      | Pooled Resource: |
      | Yes              |
    #======step5: delete the partner======
    And I delete partner account