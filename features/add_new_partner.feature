Feature: Add a new partner

  As a Mozy Administrator
  I want to create partners
  So that I can organize my business in a way that works for me

  Background:
    Given I log in bus admin console as administrator

  @add_pro_basic @smoke_test
  Scenario: Add a new monthly MozyPro partner
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 base plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.

  @add_pro_european_vat
  Scenario: Add a new yearly MozyPro european country partner with vat number
    When I add a MozyPro partner with 12 month(s) period, 500 GB, $2,089.89 base plan, has server plan, no coupon, Belgium country, BE0883236072 VAT number, credit card payment
    Then Partner created successful message should be New partner created.

  @add_pro_us_coupon @smoke_test
  Scenario: Add a new yearly MozyPro partner with coupon
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 base plan, no server plan, Coupon1DollarOff coupon, credit card payment
    Then Order summary table should be:
    | Column A          | Column B | Column C   | Column D    |
    | Description       | Quantity | Price Each | Total Price |
    | 50 GB             | 1        | $19.99     | $19.99      |
    | Discounts Applied |          |            | -$1.00      |
    | Pre-tax Subtotal  |          |            | $18.99      |
    | Total Charges     |          |            | $18.99      |
    Then Partner created successful message should be New partner created.

  @add_pro_european @smoke_test
  Scenario: Add a new monthly MozyPro european country partner
   When I add a MozyPro partner with 1 month(s) period, 100 GB, $39.99 base plan, no server plan, no coupon, United Kingdom country, no VAT number, credit card payment
   Then Order summary table should be:
   | Column A          | Column B | Column C   | Column D    |
   | Description       | Quantity | Price Each | Total Price |
   | 100 GB            | 1        | $39.99     | $39.99      |
   | Pre-tax Subtotal  |          |            | $39.99      |
   | Taxes             |          |            | $9.20       |
   | Total Charges     |          |            | $49.19      |
   Then Partner created successful message should be New partner created.

  @add_pro_european_vat_coupon
    Scenario: Add a new yearly MozyPro european country partner with vat and coupon
    When I add a MozyPro partner with 12 month(s) period, 500 GB, $2,089.89 base plan, has server plan, Coupon1DollarOff coupon, Belgium country, BE0883236072 VAT number, credit card payment
    Then Order summary table should be:
    | Column A          | Column B | Column C   | Column D    |
    | Description       | Quantity | Price Each | Total Price |
    | 500 GB            | 1        | $2,089.89  | $2,089.89   |
    | Server Plan       | 1        | $219.89    | $219.89     |
    | Discounts Applied |          |            | -$2.00      |
    | Pre-tax Subtotal  |          |            | $2,307.78   |
    | Total Charges     |          |            | $2,307.78   |
    Then Partner created successful message should be New partner created.

  @add_pro_no_purchase
  Scenario: Add a new biennially MozyPro partner with no initial purchase
    When I add a MozyPro partner with 24 month(s) period, no initial purchase
    Then Partner created successful message should be New partner created.

  @add_pro_net_terms
  Scenario: Add a new MozyPro partner with net terms payment
    When I add a MozyPro partner with 12 month(s) period, 500 GB, $2,089.89 base plan, has server plan, no coupon, net terms payment
    Then Partner created successful message should be New partner created.

  @add_enterprise_basic @smoke_test
  Scenario: Add a new yearly MozyEnterprise partner
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.

  @add_enterprise_european_vat
    Scenario: Add a new biennially MozyEnterprise european country partner with vat
      When I add a MozyEnterprise partner with 24 month(s) period, 1 user(s), 100 GB Server Plan, $1,112.58 server plan, 1 server add-on, no coupon, Belgium country, BE0883236072 VAT number, credit card payment
      Then Partner created successful message should be New partner created.

  @add_enterprise_us_coupon
  Scenario: Add a new yearly MozyEnterprise partner
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), no server plan, 0 server add-on, Coupon1DollarOff coupon, credit card payment
    Then Order summary table should be:
    | Column A            | Column B | Column C   | Column D    |
    | Description         | Quantity | Price Each | Total Price |
    | MozyEnterprise User | 1        | $95.00     | $95.00      |
    | Discounts Applied   |          |            | -$1.00      |
    | Pre-tax Subtotal    |          |            | $94.00      |
    | Total Charges       |          |            | $94.00      |
    Then Partner created successful message should be New partner created.

  @add_enterprise_european
  Scenario: Add a new biennially MozyEnterprise european country partner
    When I add a MozyEnterprise partner with 24 month(s) period, 1 user(s), 100 GB Server Plan, $1,112.58 server plan, 1 server add-on, no coupon, United Kingdom country, no VAT number, credit card payment
    Then Order summary table should be:
    | Column A              | Column B | Column C   | Column D    |
    | Description           | Quantity | Price Each | Total Price |
    | MozyEnterprise User   | 1        | $181.00    | $181.00     |
    | 100 GB Server Plan    | 1        | $1,112.58  | $1,112.58   |
    | 250 GB Server Add-on  | 1        | $1,994.79  | $1,994.79   |
    | Pre-tax Subtotal      |          |            | $3,288.37   |
    | Taxes                 |          |            | $500.43     |
    | Total Charges         |          |            | $3,788.80   |
   Then Partner created successful message should be New partner created.

  @add_enterprise_european_vat_coupon
  Scenario: Add a new biennially MozyEnterprise european country partner with vat and coupon
    When I add a MozyEnterprise partner with 24 month(s) period, 1 user(s), 100 GB Server Plan, $1,112.58 server plan, 1 server add-on, Coupon1DollarOff coupon, Belgium country, BE0883236072 VAT number, credit card payment
    Then Order summary table should be:
    | Column A              | Column B | Column C   | Column D    |
    | Description           | Quantity | Price Each | Total Price |
    | MozyEnterprise User   | 1        | $181.00    | $181.00     |
    | 100 GB Server Plan    | 1        | $1,112.58  | $1,112.58   |
    | 250 GB Server Add-on  | 1        | $1,994.79  | $1,994.79   |
    | Discounts Applied     |          |            | -$3.00      |
    | Pre-tax Subtotal      |          |            | $3,285.37   |
    | Total Charges         |          |            | $3,285.37   |
    Then Partner created successful message should be New partner created.

  @add_enterprise_no_purchase
  Scenario: Add a new 3 years MozyEnterprise partner with no initial purchase
    When I add a MozyEnterprise partner with 36 month(s) period, no initial purchase
    Then Partner created successful message should be New partner created.

  @add_enterprise_net_terms
  Scenario: Add a new MozyEnterprise partner with net terms payment
    When I add a MozyEnterprise partner with 12 month(s) period, 5 user(s), 500 GB Server Plan, $2,309.78 server plan, 1 server add-on, no coupon, net terms payment
    Then Partner created successful message should be New partner created.

  @add_reseller_basic @smoke_test
  Scenario: Add a new monthly Silver Reseller partner
    When I add a Reseller partner with 1 month(s) period, Silver Reseller, 100 GB base plan, no server plan, 0 add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.

  @add_reseller_european_vat
   Scenario: Add a new monthly Gold Reseller european country partner with vat
     When I add a Reseller partner with 1 month(s) period, Gold Reseller, 100 GB base plan, has server plan, 1 add-on, no coupon, Italy country, IT03018900245 VAT number, credit card payment
     Then Partner created successful message should be New partner created.

  @add_reseller_us_coupon
  Scenario: Add a new monthly Silver Reseller partner with coupon
    When I add a Reseller partner with 1 month(s) period, Silver Reseller, 100 GB base plan, no server plan, 0 add-on, Coupon1DollarOff coupon, credit card payment
    Then Order summary table should be:
    | Column A              | Column B | Column C   | Column D    |
    | Description           | Quantity | Price Each | Total Price |
    | GB - Silver Reseller  | 100      | $0.42      | $42.00      |
    | Discounts Applied     |          |            | -$1.00      |
    | Pre-tax Subtotal      |          |            | $41.00      |
    | Total Charges         |          |            | $41.00      |
    And Partner created successful message should be New partner created.

  @add_reseller_european
  Scenario: Add a new yearly Gold Reseller european country partner
    When I add a Reseller partner with 12 month(s) period, Platinum Reseller, 100 GB base plan, has server plan, 1 add-on, no coupon, United Kingdom country, no VAT number, credit card payment
    Then Order summary table should be:
    | Column A               | Column B | Column C   | Column D    |
    | Description            | Quantity | Price Each | Total Price |
    | GB - Platinum Reseller | 100      | $3.30      | $330.00     |
    | Server Plan            | 1        | $1,925.00  | $1,925.00   |
    | 100 GB add-on          | 1        | $330.00    | $330.00     |
    | Pre-tax Subtotal       |          |            | $2,585.00   |
    | Taxes                  |          |            | $151.80     |
    | Total Charges          |          |            | $2,736.80   |
    Then Partner created successful message should be New partner created.

  @add_reseller_european_vat_coupon
  Scenario: Add a new Gold Reseller partner with vat and coupon
    When I add a Reseller partner with 12 month(s) period, Gold Reseller, 100 GB base plan, has server plan, 1 add-on, Coupon1DollarOff coupon, Italy country, IT03018900245 VAT number, credit card payment
    Then Order summary table should be:
    | Column A              | Column B | Column C   | Column D    |
    | Description           | Quantity | Price Each | Total Price |
    | GB - Gold Reseller    | 100      | $3.85      | $385.00     |
    | Server Plan           | 1        | $1,100.00  | $1,100.00   |
    | 50 GB add-on          | 1        | $192.50    | $192.50     |
    | Discounts Applied     |          |            | $-3.00      |
    | Pre-tax Subtotal      |          |            | $1,674.50   |
    | Total Charges         |          |            | $1,674.50   |
    Then Partner created successful message should be New partner created.

  @add_reseller_no_purchase
  Scenario: Add a new Reseller partner with no initial purchase
    When I add a Reseller partner with 1 month(s) period, no initial purchase
    Then Partner created successful message should be New partner created.

  @add_reseller_net_terms
  Scenario: Add a new Reseller partner with net terms payment
    When I add a Reseller partner with 12 month(s) period, Platinum Reseller, 100 GB base plan, has server plan, 2 add-on, no coupon, net terms payment
    Then Partner created successful message should be New partner created.

