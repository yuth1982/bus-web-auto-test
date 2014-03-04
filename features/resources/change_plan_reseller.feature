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

  @reseller_change_plan_failure_example
  Scenario: Try to remove server plan after keys assigned
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 1      | Silver        | 100            | yes         |
    Then New partner should be created
    When I act as newly created partner account
    When I add new user(s):
      | name         | user_group           | storage_type | storage_limit | devices |
      | server user  | (default user group) | Server       | 10           | 5       |
    Then 1 new user should be created
    When I change Reseller account plan to:
      | server plan |
      | no          |
    Then Change Plan error message should be You cannot remove the server plan from this account because you have storage and server keys assigned. Click Manage Resources to remove the resources from your servers and then try again.
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name
