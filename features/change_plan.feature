Feature: Change plan

  Background:
    Given I log in bus admin console as administrator

  @TC.16485
  Scenario: 16485 SMB 10 GB partner moves to 50 GB plan
    When I add a new MozyPro partner:
    | period | base plan    |
    | 1      | 10 GB, $9.99 |
    Then New partner should created
    When I log in bus admin console as the new partner account
    When I change MozyPro account plan to:
    | base plan       | server plan | coupon |
    | 50 GB, $19.99   | yes         |        |
    Then Change plan charge summary should be:
    | Description                     | Amount   |
    | Credit for remainder of 10 GB   | -$9.99   |
    | Charge for upgraded plans       | $26.98   |
    |                                 |          |
    | Total amount to be charged      | $16.99   |
    Then Account plan should be changed

  @TC.16841
  Scenario: 16841 MozyPro Enterprise Yearly to 50 GB Add-on
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 10    |
    Then New partner should created
    When I log in bus admin console as the new partner account
    When I change MozyEnterprise account plan to:
    | users | server plan                  | server add-on | coupon |
    | 20    | 50 GB Server Plan, $296.78   | 1             |        |
    Then Change plan charge summary should be:
    | Description                | Amount    |
    | Charge for upgraded plans  | $2,291.67 |
    Then Account plan should be changed

  @test3
  Scenario: Test change reseller plan
    When I add a new Reseller partner:
    | period | reseller type | reseller quota |
    | 1      | Silver        | 100            |
    Then New partner should created
    When I log in bus admin console as the new partner account
    When I change Reseller account plan to:
    | server plan | server add-on | coupon |
    | yes         | 2             |        |
    Then Change plan charge summary should be:
    | Description                | Amount |
    | Charge for upgraded plans  | $41.80 |
    Then Account plan should be changed