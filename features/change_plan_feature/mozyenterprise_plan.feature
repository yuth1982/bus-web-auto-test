Feature:

  Background:
    Given I log in bus admin console as administrator

  @TC.16865
  Scenario: 16865 MozyEnterprise 250 server add-on yearly to 500 GB add-on
    When I add a new MozyEnterprise partner:
    | period | users | server plan                   |
    | 12     | 10    | 250 GB Server Plan, $1,220.78 |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
    | users | server plan                   | server add-on |
    | 15    | 500 GB Server Plan, $2,309.78 | 5             |
    Then Change plan charge summary should be:
    | Description                                | Amount     |
    | Credit for remainder of 250 GB Server Plan | -$1,220.78 |
    | Charge for upgraded plans                  | $8,009.23  |
    |                                            |            |
    | Total amount to be charged                 | $6,788.45  |
    And Account plan should be changed
    And MozyEnterprise new plan should be:
    | users | server plan                                      | server add on |
    | 15    | 500 GB Server Plan, $2,309.78 (current purchase) | 5             |

  @TC.16955
  Scenario: 16955 MozyPro Enterprise 500 server add-on biennially to 1 TB add-on
    When I add a new MozyEnterprise partner:
      | period | users | server plan                   |
      | 24     | 10    | 500 GB Server Plan, $4,409.58 |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan                 | server add-on |
      | 15    | 1 TB Server Plan, $8,609.58 | 5             |
    Then Change plan charge summary should be:
      | Description                                | Amount     |
      | Credit for remainder of 500 GB Server Plan | -$4,409.58 |
      | Charge for upgraded plans                  | $19,488.53 |
      |                                            |            |
      | Total amount to be charged                 | $15,078.95 |
    And Account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan                                    | server add on |
      | 15    | 1 TB Server Plan, $8,609.58 (current purchase) | 5             |

  @TC.16997 @Bug.84933 @Regression
  Scenario: 16997 MozyPro Enterprise 1 TB server add-on 3 years to 2 TB add-on
    When I add a new MozyEnterprise partner:
      | period | users | server plan                  |
      | 36     | 10    | 1 TB Server Plan, $12,299.40 |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | uers | server plan                  | server add-on |
      | 15   | 2 TB Server Plan, $23,699.40 | 5             |
    Then Change plan charge summary should be:
      | Description                                | Amount     |
      | Credit for remainder of 250 GB Server Plan | -$1,220.78 |
      | Charge for upgraded plans                  | $7,534.23  |
      |                                            |            |
      | Total amount to be charged                 | $6,313.45  |
    And Account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan                                     | server add on |
      | 10    | 2 TB Server Plan, $23,699.40 (current purchase) | 5             |


  #Show / Hide direct link   Mozy-17735:MozyPro Enterprise 2 TB Server Add-on 2 year to 1 TB Add-on
# Show / Hide direct link   Mozy-17733:MozyPro Enterprise 4 TB Server Add-on 3 year to 2 TB Add-on
  #Show / Hide direct link   Mozy-17740:MozyPro Enterprise 1 TB Server Add-on Yearly to 500 GB Add-on