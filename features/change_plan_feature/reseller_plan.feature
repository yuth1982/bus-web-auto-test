Feature:

  Background:
    Given I log in bus admin console as administrator

  @test3
  Scenario: Test change reseller plan
    When I add a new Reseller partner:
    | period | reseller type | reseller quota |
    | 1      | Silver        | 100            |
    Then New partner should be created
    When I act as newly created partner account
    When I change Reseller account plan to:
    | server plan | server add-on | coupon |
    | yes         | 2             |        |
    Then Change plan charge summary should be:
    | Description                | Amount |
    Then Account plan should be changed
    | Charge for upgraded plans  | $41.80 |
