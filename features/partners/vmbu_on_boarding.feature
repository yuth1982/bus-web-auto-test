Feature: VMBU On Boarding admin console

  Background:
    Given I log in bus admin console as administrator

  @TC.130707 @vmbu @tasks_p2 @bus
  Scenario: 130707 VMBU Tooltip MozyPro
    When I set initial purchase and base plan for specified company type
      | company type | period | base plan |
      | MozyPro      | 12     | 1 TB      |
    Then MozyPro VMBU tool tip should appear next to the Server Add Ons




