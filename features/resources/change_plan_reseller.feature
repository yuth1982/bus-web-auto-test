Feature:

  Background:
    Given I log in bus admin console as administrator

  @reseller_change_plan_example
  Scenario: Test change reseller plan
    When I add a new Reseller partner:
    | period | reseller type | reseller quota |
    | 1      | Silver        | 100            |
    Then New partner should be created
    When I act as newly created partner account
    When I change Reseller account plan to:
    | server plan | storage add-on |
    | yes         | 2              |
    Then Change plan charge summary should be:
    | Description                | Amount |
    | Charge for upgraded plans  | $41.80 |
    And the Reseller account plan should be changed
    And MozyPro new plan should be:
      | server plan | storage add-on |
      | yes         | 2              |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name
