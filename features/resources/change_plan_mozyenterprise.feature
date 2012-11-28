Feature:

  Background:
    Given I log in bus admin console as administrator

  @TC.19239 @change_plan
  Scenario: 19239 MozyEnterprise 250 GB server add-on yearly to 500 GB add-on
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
    And the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan | server add-on |
      | 15    | 500 GB      | 5             |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19239 @change_plan
  Scenario: 19239 MozyEnterprise 500 GB server add-on biennially to 1 TB add-on
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
    And the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan | server add-on |
      | 15    | 1 TB        | 5             |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19263 @Bug.84933 @regression @change_plan
Scenario: 19263 MozyEnterprise 1 TB server add-on 3 years to 2 TB add-on
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
  And the MozyEnterprise account plan should be changed
  And MozyEnterprise new plan should be:
    | users | server plan | server add-on |
    | 10    | 2 TB        | 5             |
  When I stop masquerading
  Then I search and delete partner account by newly created partner company name

  @TC.19265 @change_plan
  Scenario: 19265 MozyEnterprise 16 TB server add-on yearly to 8 TB add-on
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on|
      | 12     | 15    | 16 TB       | 5            |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan | server add-on |
      | 10    | 8 TB        | 0             |
    Then the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan | server add-on |
      | 10    | 8 TB        | 0             |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19266 @change_plan
  Scenario: 19266 MozyEnterprise 32 TB server add-on yearly to 28 TB add-on
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on |
      | 24     | 15    | 32 TB       | 5             |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan | server add-on |
      | 10    | 28 TB       | 0             |
    Then the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan | server add-on |
      | 10    | 28 TB       | 0             |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19267 @change_plan
  Scenario: 19267 MozyEnterprise 28 TB server add-on yearly to 24 TB add-on
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on |
      | 36     | 10    | 28 TB       | 5             |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan | server add-on |
      | 10    | 24 TB       | 0             |
    Then the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan | server add-on |
      | 10    | 24 TB       | 0             |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19268 @change_plan
  Scenario: 19268 MozyEnterprise VAT no server add-on yearly to 10 GB add-on
    When I add a new MozyEnterprise partner:
      | period | users |  vat number    | country |
      | 12     | 10    | FR08410091490  | France  |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan |
      | 15    | 10 GB       |
    Then Change plan charge summary should be:
      | Description                                | Amount      |
      | Charge for upgraded plans                  | $470.90     |
    And the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan |
      | 15    | 10 GB       |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19269 @change_plan
  Scenario: 19269 MozyEnterprise no VAT 10gb server add-on biennially to 50 GB add-on
    When I add a new MozyEnterprise partner:
      | period | users | server plan | country  |
      | 24     | 10    | 10 GB       | Germany  |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan |
      | 15    | 50 GB       |
    Then Change plan charge summary should be:
      | Description                                | Amount      |
      | Credit for remainder of 10 GB Server Plan  | -$361.10    |
      | Charge for upgraded plans                  | $1,810.04   |
      |                                            |             |
      | Total amount to be charged                 | $1,448.94   |
    And the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan |
      | 15    | 50 GB       |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19270 @change_plan
  Scenario: 19270 MozyEnterprise VAT IE 50 gbs server add-on triennially to 100 GB add-on
    When I add a new MozyEnterprise partner:
      | period | users | server plan | vat number | country  |
      | 36     | 10    | 50 GB       | IE9691104A | Ireland  |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan  |
      | 15    | 100 GB       |
    Then Change plan charge summary should be:
      | Description                                | Amount      |
      | Credit for remainder of 50 GB Server Plan  | -$995.56    |
      | Charge for upgraded plans                  | $3,547.81   |
      |                                            |             |
      | Total amount to be charged                 | $2,552.25   |
    And the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan |
      | 15    | 100 GB      |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19271 @change_plan
  Scenario: 19271 MozyEnterprise initial purchase coupon 100 gbs server add-on yearly to 250 GB add-on
    When I add a new MozyEnterprise partner:
      | period | users | server plan  | coupon              |
      | 12     | 10    | 100 GB       | 10PERCENTOFFOUTLINE |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan  |
      | 15    | 250 GB       |
    Then Change plan charge summary should be:
      | Description                                | Amount      |
      | Credit for remainder of 100 GB Server Plan | -$582.78    |
      | Charge for upgraded plans                  | $1,431.20   |
      |                                            |             |
      | Total amount to be charged                 | $848.42     |
    And the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan |
      | 15    | 250 GB      |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19272 @change_plan
  Scenario: 19272 MozyEnterprise VAT yearly to 20 TB add-on
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on |  vat number    | country |
      | 12     | 15    | 24 TB       | 5             | FR08410091490  | France  |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan | server add-on |
      | 10    | 20 TB       | 0             |
    And the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan | server add-on |
      | 10    | 20 TB       | 0             |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19273 @change_plan
  Scenario: 19273 MozyEnterprise no VAT biennially to 16 TB add-on
    When I add a new MozyEnterprise partner:
      | period | users | server plan | country  |
      | 24     | 15    | 20 TB       | Germany  |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan | server add-on |
      | 10    | 16 TB       | 0             |
    And the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan | server add-on |
      | 10    | 16 TB       | 0             |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19274 @change_plan
  Scenario: 19274 MozyEnterprise VAT IE triennially to 12 TB add-on
    When I add a new MozyEnterprise partner:
      | period | users | server plan | vat number | country  |
      | 36     | 15    | 12 TB       | IE9691104A | Ireland  |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan | server add-on |
      | 10    | 12 TB       | 0             |
    And the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan | server add-on |
      | 10    | 12 TB       | 0             |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19275 @change_plan
  Scenario: 19275 MozyEnterprise initial purchase coupon 100 gbs server add-on yearly to 250 GB add-on
    When I add a new MozyEnterprise partner:
      | period | users | server plan  | coupon              |
      | 12     | 10    | 100 GB       | 10PERCENTOFFOUTLINE |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan | server add-on |
      | 10    |  8 TB       | 0             |
    And the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan | server add-on |
      | 10    |  8 TB       | 0             |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19392 @change_plan
  Scenario: 19392 MozyEnterprise initial purchase coupon no server add on to 10gb server add on
    When I add a new MozyEnterprise partner:
      | period | users | coupon              | country       | address           | city      | state abbrev | zip   | phone          |
      | 12     | 100   | 20PERCENTOFFOUTLINE | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan |
      | 105   | 10 GB       |
    Then Change plan charge summary should be:
      | Description                                | Amount      |
      | Charge for upgraded plans                  | $123.02     |
    And the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan |
      | 105   | 10 GB       |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19393 @change_plan
  Scenario: 19393 MozyEnterprise initial purchase coupon 250gb server add on to 250gb server add on
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on | country       | address           | city      | state abbrev | zip   | phone          |
      | 24     | 200   | 250 GB      | 10             | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan  |
      | 205   | 500 GB       |
    Then Change plan charge summary should be:
      | Description                                 | Amount      |
      | Credit for remainder of 250 GB Server Plan  | -$2,330.58  |
      | Charge for upgraded plans                   | $5,314.58   |
      |                                             |             |
      | Total amount to be charged                  | $2,984.00   |
    And the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan  |
      | 205   | 500 GB       |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19394 @change_plan
  Scenario: 19394 MozyEnterprise initial purchase coupon 500gb server add on to 1tb server add on
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on | coupon              | country       | address           | city      | state abbrev | zip   | phone          |
      | 36     | 300   | 500 GB      | 10            | 20PERCENTOFFOUTLINE | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan | server add-on |
      | 305   | 1 TB        | 11            |
    Then Change plan charge summary should be:
      | Description                                 | Amount      |
      | Credit for remainder of 500 GB Server Plan  | -$6,299.40  |
      | Charge for upgraded plans                   | $9,839.52   |
      |                                             |             |
      | Total amount to be charged                  | $3,540.12   |
    And the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan | server add-on |
      | 305   | 1 TB        | 11            |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19396 @change_plan
  Scenario: 19396 MozyEnterprise 1 TB server add on to 100gbs server add on
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on | country       | address           | city      | state abbrev | zip   | phone          |
      | 12     | 400   | 1 TB        | 10            | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan   |
      | 300   | 100 GB        |
    And the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan   |
      | 300   | 100 GB        |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19397 @change_plan
  Scenario: 19397 MozyEnterprise initial purchase coupon and net terms 2tb server add on to no server add on
    When I add a new MozyEnterprise partner:
      | period | users | server plan | coupon              | net terms | country       | address           | city      | state abbrev | zip   | phone          |
      | 24     | 500   | 2 TB        | 20PERCENTOFFOUTLINE | yes       | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan |
      | 505   | None        |
    And the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan |
      | 505   | None        |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19398 @change_plan
  Scenario: 19398 MozyEnterprise Net Terms 4 TB server add on to 2 TB server add on
    When I add a new MozyEnterprise partner:
      | period | users | server plan  | server add on | net terms | country       | address           | city      | state abbrev | zip   | phone          |
      | 36     | 600   | 4 TB         | 10            | yes       | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan |
      | 500   | 2 TB        |
    And the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan |
      | 500   | 2 TB        |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name