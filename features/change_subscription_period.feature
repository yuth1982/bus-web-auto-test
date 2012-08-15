Feature: Change subscription period

  As a Mozy Administrator
  I want to change my subscription period longer
  so that I can save money on my Mozy subscription and be billed less frequently.

  Background:
    Given I log in bus admin console as administrator

  @TC.15231 @smoke
  Scenario: 15231 MozyPro change subscription period from Monthly to Yearly
    When I add a new MozyPro partner:
    | period | base plan     |
    | 1      | 50 GB, $19.99 |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription up to MozyPro annual billing period
    Then Subscription changed message should be Your account has been changed to yearly billing.

  @TC.15232
  Scenario: 15232 MozyPro change subscription period from Yearly to Biennially
    When I add a new MozyPro partner:
    | period | base plan      |
    | 12     | 50 GB, $219.89 |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription up to MozyPro biennial billing period
    Then Subscription changed message should be Your account has been changed to biennial billing.

  @TC.15233
  Scenario: 15233 MozyPro change subscription period from Monthly to Biennially
    When I add a new MozyPro partner:
    | period | base plan     |
    | 1      | 50 GB, $19.99 |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription up to MozyPro biennial billing period
    Then Subscription changed message should be Your account has been changed to biennial billing.

  @TC.15234 @smoke
  Scenario: 15234 MozyPro change subscription period from Biennially to Yearly
    When I add a new MozyPro partner:
    | period | base plan      |
    | 24     | 50 GB, $419.79 |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription down to MozyPro annual billing period
    Then Subscription changed message should be Your account will be switched to yearly billing schedule at your next renewal.

  @TC.15235
  Scenario: 15235 MozyPro change subscription period from Yearly to Monthly
    When I add a new MozyPro partner:
    | period | base plan      |
    | 12     | 50 GB, $219.89 |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription down to MozyPro monthly billing period
    Then Subscription changed message should be Your account will be switched to monthly billing schedule at your next renewal.

  @TC.15236
  Scenario: 15236 MozyPro change subscription period from Biennially to Monthly
    When I add a new MozyPro partner:
    | period | base plan      |
    | 24     | 50 GB, $419.79 |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription down to MozyPro monthly billing period
    Then Subscription changed message should be Your account will be switched to monthly billing schedule at your next renewal.

  @TC.15238 @smoke
  Scenario: 15238 MozyEnterprise change subscription period from Yearly to Biennially
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription up to MozyEnterprise biennial billing period
    Then Subscription changed message should be Your account has been changed to biennial billing.

  @TC.15239
  Scenario: 15239 MozyEnterprise change subscription period from Biennially to 3 Years
    When I add a new MozyEnterprise partner:
    | period | users |
    | 24     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription up to MozyEnterprise 3-year billing period
    Then Subscription changed message should be Your account has been changed to 3-year billing.

  @TC.15240
  Scenario: 15240 MozyEnterprise change subscription period from Yearly to 3 Years
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription up to MozyEnterprise 3-year billing period
    Then Subscription changed message should be Your account has been changed to 3-year billing.

  @TC.15241
  Scenario: 15241 MozyEnterprise change subscription period from Biennially to Yearly
    When I add a new MozyEnterprise partner:
    | period | users |
    | 24     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription down to MozyEnterprise annual billing period
    Then Subscription changed message should be Your account will be switched to yearly billing schedule at your next renewal.

  @TC.15243 @smoke
  Scenario: 15243 MozyEnterprise change subscription period from 3 Years to Biennially
    When I add a new MozyEnterprise partner:
    | period | users |
    | 36     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription down to MozyEnterprise biennial billing period
    Then Subscription changed message should be Your account will be switched to biennial billing schedule at your next renewal.

  @TC.15244
  Scenario: 15244 MozyEnterprise change subscription period from 3 Years to Yearly
    When I add a new MozyEnterprise partner:
    | period | users |
    | 36     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription down to MozyEnterprise annual billing period
    Then Subscription changed message should be Your account will be switched to yearly billing schedule at your next renewal.

  @TC.15245 @smoke
  Scenario: 15245 Reseller change subscription period from Monthly to Yearly
    When I add a new Reseller partner:
    | period | reseller type | reseller quota |
    | 1      | Silver        | 100            |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription up to Reseller annual billing period
    Then Subscription changed message should be Your account has been changed to yearly billing.

  @TC.15246 @smoke
  Scenario: 15246 Reseller change subscription period from Yearly to Monthly
    When I add a new Reseller partner:
    | period | reseller type | reseller quota |
    | 12     | Gold          | 100            |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription down to Reseller monthly billing period
    Then Subscription changed message should be Your account will be switched to monthly billing schedule at your next renewal.

  @TC.15383
  Scenario: 15383 Verify Reseller confirmation message when change subscription period to yearly
    When I add a new Reseller partner:
    | period | reseller type | reseller quota |
    | 1      | Silver        | 100            |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription up to Reseller annual billing period
    Then Change subscription confirmation message should be:
    | Message                                                                                                                                                                                                                                           |
    | Are you sure that you want to change your subscription period from monthly to yearly billing?                                                                                                                                                     |
    | If you choose to continue, your account will be credited for the remainder of your monthly Subscription, then charged for a new yearly subscription beginning today. By choosing yearly billing, you will receive 1 free month(s) of Mozy service.|
    | Any resources you scheduled for return in your next subscription have been deducted from the new subscription total.                                                                      |
    And Change subscription price table should be:
    | Description                                   | Amount   |
    | Credit for remainder of monthly subscription  | $42.00   |
    | Charge for new yearly subscription            | $462.00  |
    | Total amount to be charged                    | $420.00  |

  @TC.15384 @smoke_test
  Scenario: 15384 Verify MozyPro confirmation message when change subscription period to biennially
    When I add a new MozyPro partner:
    | period | base plan     |
    | 1      | 50 GB, $19.99 |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription up to MozyPro biennial billing period
    Then Change subscription confirmation message should be:
    | Message                                                                                                                                                                                                                                                |
    | Are you sure that you want to change your subscription period from monthly to biennial billing?                                                                                                                                                        |
    | If you choose to continue, your account will be credited for the remainder of your monthly Subscription, then charged for a new biennial subscription beginning today. By choosing biennial billing, you will receive 3 free month(s) of Mozy service. |
    | Any resources you scheduled for return in your next subscription have been deducted from the new subscription total.                                                                                                                                   |
    And Change subscription price table should be:
    | Description                                   | Amount   |
    | Credit for remainder of monthly subscription  | $19.99   |
    | Charge for new biennial subscription          | $419.79  |
    | Total amount to be charged                    | $399.80  |

  @TC.15385
  Scenario: 15385 Verify MozyEnterprise confirmation message when change subscription period to 3 years
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription up to MozyEnterprise 3-year billing period
    Then Change subscription confirmation message should be:
    | Message                                                                                                                                                                                                                                           |
    | Are you sure that you want to change your subscription period from yearly to 3-year billing?                                                                                                                                                      |
    | If you choose to continue, your account will be credited for the remainder of your yearly Subscription, then charged for a new 3-year subscription beginning today. By choosing 3-year billing, you will receive 0 free month(s) of Mozy service. |
    | Any resources you scheduled for return in your next subscription have been deducted from the new subscription total.                                                                                                                              |
    And Change subscription price table should be:
    | Description                                   | Amount   |
    | Credit for remainder of yearly subscription   | $95.00   |
    | Charge for new 3-year subscription            | $259.00  |
    | Total amount to be charged                    | $164.00  |



