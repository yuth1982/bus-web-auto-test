Feature:

  Background:
    Given I log in bus admin console as administrator

  @TC.16865 @javascript
  Scenario: 16865 MozyEnterprise 250 GB server add-on yearly to 500 GB add-on
    When I add a new MozyEnterprise partner:
    | period | users | server plan |
    | 12     | 10    | 250 GB      |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
    | users | server plan | server add-on |
    | 15    | 500 GB      | 5             |
    Then Change plan charge summary should be:
    | Description                                | Amount     |
    | Credit for remainder of 250 GB Server Plan | -$1,220.78 |
    | Charge for upgraded plans                  | $8,009.23  |
    |                                            |            |
    | Total amount to be charged                 | $6,788.45  |
    And Account plan should be changed
    And MozyEnterprise new plan should be:
    | users | server plan | server add-on |
    | 15    | 500 GB      | 5             |

  @TC.16955
  Scenario: 16955 MozyEnterprise 500 GB server add-on biennially to 1 TB add-on
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 24     | 10    | 500 GB      |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan | server add-on |
      | 15    | 1 TB        | 5             |
    Then Change plan charge summary should be:
      | Description                                | Amount     |
      | Credit for remainder of 500 GB Server Plan | -$4,409.58 |
      | Charge for upgraded plans                  | $19,488.53 |
      |                                            |            |
      | Total amount to be charged                 | $15,078.95 |
    And Account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan | server add-on |
      | 15    | 1 TB        | 5             |

  @TC.16997 @Bug.84933 @Regression
  Scenario: 16997 MozyEnterprise 1 TB server add-on 3 years to 2 TB add-on
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 36     | 10    | 1 TB        |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | uers | server plan | server add-on |
      | 15   | 2 TB        | 5             |
    Then Change plan charge summary should be:
      | Description                                | Amount      |
      | Credit for remainder of 1 TB Server Plan   | -$12,299.40 |
      | Charge for upgraded plans                  | $37,947.90  |
      |                                            |             |
      | Total amount to be charged                 | $25,648.50  |
    And Account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan | server add-on |
      | 10    | 2 TB        | 5             |

  @TC.17728
  Scenario: 17728 MozyEnterprise 16 TB server add-on yearly to 8 TB add-on
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 16 TB       |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | server plan |
      | 8 TB        |
    And Account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan |
      | 10    | 8 TB        |

  @TC.17714
  Scenario: 17714 MozyEnterprise 32 TB server add-on yearly to 28 TB add-on
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 24     | 10    | 32 TB       |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | server plan |
      | 28 TB       |
    And Account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan |
      | 10    | 28 TB       |

  @TC.17718
  Scenario: 17718 MozyEnterprise 32 TB server add-on yearly to 28 TB add-on
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 36     | 10    | 28 TB       |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | server plan |
      | 24 TB       |
    And Account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan |
      | 10    | 24 TB       |
