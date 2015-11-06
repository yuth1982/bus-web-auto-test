Feature: Bin Check

  Background:
    Given I log in bus admin console as administrator

  @TC.125418 @bin_check @tasks_p2 @bus
  Scenario: 125418 MozyPro BUS signup billing country Not same as credit card country us_fr
    When I add a new MozyPro partner:
      | period | base plan | country       | cc number        |
      | 12     | 20 TB     | United States | 4485393141463880 |
    Then Aria payment error message should be Could not validate payment information.


