Feature: Bus Smoke Test

  Background:
    Given I log in bus admin console as administrator

  @TC.18361 @slow @chrome
  Scenario: 18361 Mozy Enterprise Smoke Test
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add-on |
      | 24     | 1     | 100 GB      | 1             |
    Then Order summary table should be:
      | Description           | Quantity | Price Each | Total Price |
      | MozyEnterprise User   | 1        | $181.00    | $181.00     |
      | 100 GB Server Plan    | 1        | $1,112.58  | $1,112.58   |
      | 250 GB Server Add-on  | 1        | $1,994.79  | $1,994.79   |
      | Pre-tax Subtotal      |          |            | $3,288.37   |
      | Total Charges         |          |            | $3,288.37   |
    And New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan | server add-on |
      | 15    | 500 GB      | 5             |
    Then Change plan charge summary should be:
      | Description                                | Amount      |
      | Credit for remainder of 100 GB Server Plan | -$1,112.58  |
      | Charge for upgraded plans                  | $14,922.74  |
      |                                            |             |
      | Total amount to be charged                 | $13,810.16  |
    And Account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan | server add-on |
      | 15    | 500 GB      | 5             |
    When I add a new user group:
      | default server quota | default desktop quota |
      | 20                   | 10                    |
    Then New user group should be created
    When I transfer resources from (default user group) to the new user group with:
    | server licenses | server quota GB | desktop licenses | desktop quota GB |
    | 2               | 20              | 2                | 20               |
    Then Resources should be transferred
    When I navigate to the new user group details section
    Then User group details should be:
      | Available Keys | Available Quota | Default quota for new installs     |
      | 4              | 40 GB           | 10 GB (Desktop) and 20 GB (Server) |
    When I add a new user:
      | user group     | server licenses | server quota | desktop licenses | desktop quota |
      | @the_new_group | 1               | 10           | 1                | 10            |
    Then New user should be created
    When I assign a key in user group the new user group with email a test email
    Then Key should be assigned
    When I log in aria admin console as aria admin
    Then the new partner account account status should be ACTIVE
    Then I should see 3 email(s) when I search keywords:
      | content |
      | @email  |
