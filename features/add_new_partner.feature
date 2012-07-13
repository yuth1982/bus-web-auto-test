Feature: Add a new partner

  As a Mozy Administrator
  I want to create partners
  So that I can organize my business in a way that works for me

  Background:
    Given I log in bus admin console as administrator

  @add_pro_basic @smoke_test
  Scenario: Add a new monthly MozyPro partner
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created

  @add_pro_coupon
  Scenario: Add a new yearly MozyPro partner with coupon
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 plan, no server plan, Coupon5DollarsOff coupon, credit card payment
    Then Order summary details should be:
    | Description       | Amount   | Price Each | Total Price |
    | 50 GB             | 1        | $19.99     | $19.99      |
    | Discounts Applied |          |            | -$5.00      |
    | Pre-tax Subtotal  |          |            | $14.99      |
    | Taxes             |          |            | $1.20       |
    | Total Charges     |          |            | $16.19      |
    Then Partner created successful message should be New partner created

  @add_pro_vat
  Scenario: Add a new yearly MozyPro partner with vat number
    When I add a MozyPro partner with 12 month(s) period, 500 GB, $2,089.89 plan, has server plan, no coupon, Belgium country, BE0883236072 VAT number, credit card payment
    Then Partner created successful message should be New partner created

  @add_pro_vat_coupon
    Scenario: Add a new yearly MozyPro partner with vat and coupon
    When I add a MozyPro partner with 12 month(s) period, 500 GB, $2,089.89 plan, has server plan, Coupon5DollarsOff coupon, Belgium country, BE0883236072 VAT number, credit card payment
    Then Order summary details should be:
    | Description       | Amount   | Price Each | Total Price |
    | 500 GB            | 1        | $2,089.89  | $2,089.89   |
    | Server Plan       | 1        | $219.89    | $219.89     |
    | Discounts Applied |          |            | -$5.00      |
    | Pre-tax Subtotal  |          |            | $2,304.78   |
    | Total Charges     |          |            | $2,304.78   |
    Then Partner created successful message should be New partner created

  @add_pro_no_purchase
  Scenario: Add a new biennially MozyPro partner with no initial purchase
    When I add a MozyPro partner with 24 month(s) period, no initial purchase
    Then Partner created successful message should be New partner created

  @add_pro_others
  Scenario Outline: Add a new MozyPro partner others
    When I add a MozyPro partner with <period> month(s) period, <supp plan> plan, <add-on> server plan, <coupon code> coupon, <payment type> payment
    Then Partner created successful message should be New partner created
  Scenarios:
    | period  | add-on  | supp plan            | coupon code  | payment type  |
    | 12      | has     | 500 GB, $2,089.89    | no           | net terms     |

  @add_enterprise_basic @smoke_test
  Scenario: Add a new yearly MozyEnterprise partner
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created

  @add_enterprise_coupon
  Scenario: Add a new yearly MozyEnterprise partner
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), no server plan, 0 server add-on, Coupon5DollarsOff coupon, credit card payment
    Then Order summary details should be:
    | Description         | Amount   | Price Each | Total Price |
    | MozyEnterprise User | 1        | $95.00     | $95.00      |
    | Discounts Applied   |          |            | -$5.00      |
    | Pre-tax Subtotal    |          |            | $90.00      |
    | Taxes               |          |            | $7.20       |
    | Total Charges       |          |            | $97.20      |
    Then Partner created successful message should be New partner created

  @add_enterprise_vat
  Scenario: Add a new biennially MozyEnterprise partner with vat
    When I add a MozyEnterprise partner with 24 month(s) period, 1 user(s), 100 GB Server Plan, $1,112.58 server plan, 1 server add-on, no coupon, Belgium country, BE0883236072 VAT number, credit card payment
    Then Partner created successful message should be New partner created

  @add_enterprise_vat_coupon
  Scenario: Add a new biennially MozyEnterprise partner with vat and coupon
    When I add a MozyEnterprise partner with 24 month(s) period, 1 user(s), 100 GB Server Plan, $1,112.58 server plan, 1 server add-on, Coupon5DollarsOff coupon, Belgium country, BE0883236072 VAT number, credit card payment
    Then Order summary details should be:
    | Description           | Amount   | Price Each | Total Price |
    | MozyEnterprise User   | 1        | $181.00    | $181.00     |
    | 100 GB Server Plan    | 1        | $1,112.58  | $1,112.58   |
    | 250 GB Server Add-on  | 1        | $1,994.79  | $1,994.79   |
    | Discounts Applied     |          |            | -$5.00      |
    | Pre-tax Subtotal      |          |            | $3,283.37   |
    | Total Charges         |          |            | $3,283.37   |
    Then Partner created successful message should be New partner created

  @add_enterprise_no_purchase
  Scenario: Add a new 3 years MozyEnterprise partner with no initial purchase
    When I add a MozyEnterprise partner with 36 month(s) period, no initial purchase
    Then Partner created successful message should be New partner created

  @add_enterprise_others
  Scenario Outline: Add a new MozyEnterprise partner others
    When I add a MozyEnterprise partner with <period> month(s) period, <users> user(s), <server plan> server plan, <add-on> server add-on, <coupon code> coupon, <payment type> payment
    Then Partner created successful message should be New partner created
  Scenarios:
    | period | users | server plan                    | add-on | coupon code | payment type  |
    |  12    | 5     | 500 GB Server Plan, $2,309.78  | 1      | no          | net terms     |

  @add_reseller_basic @smoke_test
  Scenario: Add a new Silver Reseller partner
    When I add a Reseller partner with 1 month(s) period, Silver Reseller, 100 GB plan, no server plan, 0 add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created

  @add_reseller_coupon
  Scenario: Add a new Silver Reseller partner with coupon
    When I add a Reseller partner with 1 month(s) period, Silver Reseller, 100 GB plan, no server plan, 0 add-on, Coupon5DollarsOff coupon, credit card payment
    Then Order summary details should be:
    | Description           | Amount   | Price Each | Total Price |
    | GB - Silver Reseller  | 100      | $0.42      | $42.00      |
    | Discounts Applied     |          |            | -$5.00      |
    | Pre-tax Subtotal      |          |            | $37.00      |
    | Taxes                 |          |            | $2.96       |
    | Total Charges         |          |            | $39.96      |
    And Partner created successful message should be New partner created

  @add_reseller_vat
  Scenario: Add a new Gold Reseller partner with vat
    When I add a Reseller partner with 1 month(s) period, Gold Reseller, 100 GB plan, has server plan, 1 add-on, no coupon, Italy country, IT03018900245 VAT number, credit card payment
    Then Partner created successful message should be New partner created

  @add_reseller_vat_coupon
  Scenario: Add a new Gold Reseller partner with vat and coupon
    When I add a Reseller partner with 1 month(s) period, Gold Reseller, 100 GB plan, has server plan, 1 add-on, Coupon5DollarsOff coupon, Italy country, IT03018900245 VAT number, credit card payment
    Then Order summary details should be:
    | Description           | Amount   | Price Each | Total Price |
    | GB - Gold Reseller    | 100      | $0.35      | $35.00      |
    | Server Plan           | 1        | $100.00    | $100.00     |
    | 50 GB add-on          | 1        | $17.50     | $17.50      |
    | Discounts Applied     |          |            | -$5.00      |
    | Pre-tax Subtotal      |          |            | $147.50     |
    | Total Charges         |          |            | $147.50     |
    Then Partner created successful message should be New partner created

  @add_reseller_no_purchase
  Scenario: Add a new Reseller partner with no initial purchase
    When I add a Reseller partner with 1 month(s) period, no initial purchase
    Then Partner created successful message should be New partner created

  @add_reseller_others
  Scenario Outline: Add a new Reseller partner others
    When I add a Reseller partner with <period> month(s) period, <type> Reseller, <quota> GB plan, <add-on> server plan, <add-on quota> add-on, <coupon code> coupon, <payment type> payment
    Then Partner created successful message should be New partner created
  Scenarios:
    |  period  | type     | quota | add-on  | add-on quota  | coupon code   | payment type |
    |  12      | Platinum | 100   | has     | 2             | no            | net terms    |

