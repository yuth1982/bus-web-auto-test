Feature: Add a new partner

  As a Mozy Administrator
  I want to create partners
  So that I can organize my business in a way that works for me

  Background:
    Given I log in bus admin console as administrator

  @TC.17955 @smoke @create_partner_sample
  Scenario: 17955 Add a new monthly basic MozyPro partner
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 50 GB            | 1        | $19.99     | $19.99      |
      | Pre-tax Subtotal |          |            | $19.99      |
      | Total Charges    |          |            | $19.99      |
    And New partner should be created

  @TC.17956 @smoke
  Scenario: 17956 Add a new monthly MozyPro partner european
    When I add a new MozyPro partner:
      | period | base plan | country        |
      | 1      | 100 GB    | United Kingdom |
    Then Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 100 GB            | 1        | $39.99     | $39.99      |
      | Pre-tax Subtotal  |          |            | $39.99      |
      | Taxes             |          |            | $9.20       |
      | Total Charges     |          |            | $49.19      |
    And New partner should be created

  @TC.17957
  Scenario: 17957 Add a new yearly MozyPro partner european vat
    When I add a new MozyPro partner:
      | period | base plan | server plan | country | vat number    |
      | 12     | 500 GB    | yes         | Italy   | IT03018900245 |
    Then Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 500 GB           | 1        | $2,089.89  | $2,089.89   |
      | Server Plan      | 1        | $219.89    | $219.89     |
      | Pre-tax Subtotal |          |            | $2,309.78   |
      | Total Charges    |          |            | $2,309.78   |
    And New partner should be created

  @TC.17958 @smoke
  Scenario: 17958 Add a new monthly MozyPro partner with flat coupon
    When I add a new MozyPro partner:
      | period | base plan | coupon           |
      | 1      | 50 GB     | Coupon1DollarOff |
    Then Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 50 GB             | 1        | $19.99     | $19.99      |
      | Discounts Applied |          |            | -$1.00      |
      | Pre-tax Subtotal  |          |            | $18.99      |
      | Total Charges     |          |            | $18.99      |
    And New partner should be created

  @TC.17959
  Scenario: 17959 Add a new yearly MozyPro partner european vat coupon
    When I add a new MozyPro partner:
      | period | base plan | server plan | country | vat number   | coupon           |
      | 12     | 500 GB    | yes         | Belgium | BE0883236072 | Coupon1DollarOff |
    Then Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | $2,089.89  | $2,089.89   |
      | Server Plan       | 1        | $219.89    | $219.89     |
      | Discounts Applied |          |            | -$2.00      |
      | Pre-tax Subtotal  |          |            | $2,307.78   |
      | Total Charges     |          |            | $2,307.78   |
    And New partner should be created

  @TC.17960
  Scenario: 17960 Add a new biennially MozyPro partner with no initial purchase
    When I add a new MozyPro partner:
      | period |
      | 24     |
    Then New partner should be created

  @TC.17961 @pro_net_terms
  Scenario: 17961 Add a new yearly MozyPro partner with net terms payment
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 12     | 500 GB    | yes         | yes       |
    Then New partner should be created

  @TC.17962 @smoke
  Scenario: 17961 Add a new yearly basic MozyEnterprise partner
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then Order summary table should be:
      | Description           | Quantity | Price Each | Total Price |
      | MozyEnterprise User   | 1        | $95.00     | $95.00      |
      | Pre-tax Subtotal      |          |            | $95.00      |
      | Total Charges         |          |            | $95.00      |
    And New partner should be created

  @TC.17963
  Scenario: 17963 Add a new biennially MozyEnterprise partner european
    When I add a new MozyEnterprise partner:
      | period | users | server plan        | server add-on | country        |
      | 24     | 1     | 100 GB Server Plan | 1             | United Kingdom |
    Then Order summary table should be:
      | Description           | Quantity | Price Each | Total Price |
      | MozyEnterprise User   | 1        | $181.00    | $181.00     |
      | 100 GB Server Plan    | 1        | $1,112.58  | $1,112.58   |
      | 250 GB Server Add-on  | 1        | $1,994.79  | $1,994.79   |
      | Pre-tax Subtotal      |          |            | $3,288.37   |
      | Taxes                 |          |            | $756.32     |
      | Total Charges         |          |            | $4,044.69   |
    And New partner should be created

  @TC.17964
  Scenario: 17964 Add a new biennially MozyEnterprise partner european vat
    When I add a new MozyEnterprise partner:
      | period | users | server plan                   | server add-on | country | vat number    |
      | 24     | 1     | 100 GB Server Plan, $1,112.58 | 1             | Italy   | IT03018900245 |
    Then Order summary table should be:
      | Description           | Quantity | Price Each | Total Price |
      | MozyEnterprise User   | 1        | $181.00    | $181.00     |
      | 100 GB Server Plan    | 1        | $1,112.58  | $1,112.58   |
      | 250 GB Server Add-on  | 1        | $1,994.79  | $1,994.79   |
      | Pre-tax Subtotal      |          |            | $3,288.37   |
      | Total Charges         |          |            | $3,288.37   |
    And New partner should be created

  @TC.17965
  Scenario: 17965 Add a new yearly MozyEnterprise partner with coupon
    When I add a new MozyEnterprise partner:
      | period | users | coupon           |
      | 12     | 1     | Coupon1DollarOff |
    Then Order summary table should be:
      | Description         | Quantity | Price Each | Total Price |
      | MozyEnterprise User | 1        | $95.00     | $95.00      |
      | Discounts Applied   |          |            | -$1.00      |
      | Pre-tax Subtotal    |          |            | $94.00      |
      | Total Charges       |          |            | $94.00      |
    And New partner should be created

  @TC.17966
  Scenario: 17966 Add a new biennially MozyEnterprise partner european vat coupon
    When I add a new MozyEnterprise partner:
      | period | users | server plan        | server add-on | country | vat number   | coupon           |
      | 24     | 1     | 100 GB Server Plan | 1             | Belgium | BE0883236072 | Coupon1DollarOff |
    Then Order summary table should be:
      | Description           | Quantity | Price Each | Total Price |
      | MozyEnterprise User   | 1        | $181.00    | $181.00     |
      | 100 GB Server Plan    | 1        | $1,112.58  | $1,112.58   |
      | 250 GB Server Add-on  | 1        | $1,994.79  | $1,994.79   |
      | Discounts Applied     |          |            | -$3.00      |
      | Pre-tax Subtotal      |          |            | $3,285.37   |
      | Total Charges         |          |            | $3,285.37   |
    And New partner should be created

  @TC.17967
  Scenario: 17967 Add a new 3 years MozyEnterprise partner with no initial purchase
    When I add a new MozyEnterprise partner:
      | period |
      | 36     |
    Then New partner should be created

  @TC.17968 @enterprise_net_terms
  Scenario: 17968 Add a new MozyEnterprise partner with net terms payment
    When I add a new MozyEnterprise partner:
      | period | users | server plan        | server add-on | net terms |
      | 12     | 5     | 500 GB Server Plan | 1             | yes       |
    Then New partner should be created

  @TC.17969 @smoke
  Scenario: 17969 Add a new monthly Silver Reseller partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 100            |
    Then Order summary table should be:
      | Description           | Quantity | Price Each | Total Price |
      | GB - Silver Reseller  | 100      | $0.42      | $42.00      |
      | Pre-tax Subtotal      |          |            | $42.00      |
      | Total Charges         |          |            | $42.00      |
    And New partner should be created

  @TC.17970
  Scenario: 17970 Add a new yearly Gold Reseller partner european
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | server add-on | country        |
      | 12     | Platinum      | 100            | yes         | 1             | United Kingdom |
    Then Order summary table should be:
      | Description            | Quantity | Price Each | Total Price |
      | GB - Platinum Reseller | 100      | $3.30      | $330.00     |
      | Server Plan            | 1        | $1,925.00  | $1,925.00   |
      | 100 GB add-on          | 1        | $330.00    | $330.00     |
      | Pre-tax Subtotal       |          |            | $2,585.00   |
      | Taxes                  |          |            | $594.55     |
      | Total Charges          |          |            | $3,179.55   |
    And New partner should be created

  @TC.17971
  Scenario: 17971 Add a new monthly Gold Reseller partner european vat
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | server add-on | country | vat number    |
      | 1      | Gold          | 100            | yes         | 1             | Italy   | IT03018900245 |
    Then Order summary table should be:
      | Description            | Quantity | Price Each | Total Price |
      | GB - Gold Reseller     | 100      | $0.35      | $35.00      |
      | Server Plan            | 1        | $100.00    | $100.00     |
      | 50 GB add-on           | 1        | $17.50     | $17.50      |
      | Pre-tax Subtotal       |          |            | $152.50     |
      | Total Charges          |          |            | $152.50     |
    And New partner should be created

  @TC.17972
  Scenario: 17972 Add a new monthly Silver Reseller partner with coupon
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | coupon           |
      | 1      | Silver        | 100            | Coupon1DollarOff |
    Then Order summary table should be:
      | Description           | Quantity | Price Each | Total Price |
      | GB - Silver Reseller  | 100      | $0.42      | $42.00      |
      | Discounts Applied     |          |            | -$1.00      |
      | Pre-tax Subtotal      |          |            | $41.00      |
      | Total Charges         |          |            | $41.00      |
    And New partner should be created

  @TC.17973
  Scenario: 17973 Add a new Gold Reseller partner european vat coupon
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | server add-on | country | vat number    | coupon           |
      | 12     | Gold          | 100            | yes         | 1             | Italy   | IT03018900245 | Coupon1DollarOff |
    Then Order summary table should be:
      | Description           | Quantity | Price Each | Total Price |
      | GB - Gold Reseller    | 100      | $3.85      | $385.00     |
      | Server Plan           | 1        | $1,100.00  | $1,100.00   |
      | 50 GB add-on          | 1        | $192.50    | $192.50     |
      | Discounts Applied     |          |            | -$3.00      |
      | Pre-tax Subtotal      |          |            | $1,674.50   |
      | Total Charges         |          |            | $1,674.50   |
    And New partner should be created

  @TC.17974
  Scenario: 17974 Add a new Reseller partner with no initial purchase
    When I add a new Reseller partner:
      | period |
      | 1      |
    Then New partner should be created

  @TC.17975 @reseller_net_terms
  Scenario: 17975 Add a new Reseller partner with net terms payment
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | server add-on | net terms |
      | 12     | Platinum      | 100            | yes         | 2             | yes       |
    Then New partner should be created

  @TC.18720
  Scenario: 18720 Verify MozyPro partner has 3 period options
    When I navigate to Add New Partner section from bus admin console page
    Then MozyPro partner subscription period options should be:
      | Monthly | Yearly |  Biennially |

  @TC.18721
  Scenario: 18721 Verify MozyEnterprise partner has 3 period options
    When I navigate to Add New Partner section from bus admin console page
    Then MozyEnterprise partner subscription period options should be:
      | Yearly |  Biennially | 3 years |

  @TC.18722
  Scenario: 18722 Verify Reseller partner has 2 period options
    When I navigate to Add New Partner section from bus admin console page
    Then Reseller partner subscription period options should be:
      | Monthly | Yearly |

  @TC.18733 @smoke
  Scenario: 18733 Add a new monthly MozyPro partner with 10 percent inline coupon
    When I add a new MozyPro partner:
      | period | base plan | coupon              |
      | 1      | 50 GB     | test10pctUltdInline |
    Then Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 50 GB             | 1        | $19.99     | $19.99      |
      | Pre-tax Subtotal  |          |            | $17.99      |
      | Total Charges     |          |            | $17.99      |
    And New partner should be created

  @TC.18734 @smoke
  Scenario: 18734 Add a new monthly MozyPro partner with 10 percent outline coupon
    When I add a new MozyPro partner:
      | period | base plan | coupon               |
      | 1      | 50 GB     | test10pctUltdOutline |
    Then Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 50 GB             | 1        | $19.99     | $19.99      |
      | Discounts Applied |          |            | -$2.00      |
      | Pre-tax Subtotal  |          |            | $17.99      |
      | Total Charges     |          |            | $17.99      |
    And New partner should be created

  @TC.18736 @smoke
  Scenario: 18736 Add a new yearly MozyEnterprise partner with 20 percent inline coupon
    When I add a new MozyEnterprise partner:
      | period | users | coupon              |
      | 12     | 1     | test20pctUltdInline |
    Then Order summary table should be:
      | Description         | Quantity | Price Each | Total Price |
      | MozyEnterprise User | 1        | $95.00     | $95.00      |
      | Pre-tax Subtotal    |          |            | $76.00      |
      | Total Charges       |          |            | $76.00      |
    And New partner should be created

  @TC.18737 @smoke
  Scenario: 18737 Add a new yearly MozyEnterprise partner with 20 percent outline coupon
    When I add a new MozyEnterprise partner:
      | period | users | coupon               |
      | 12     | 1     | test20pctUltdOutline |
    Then Order summary table should be:
      | Description         | Quantity | Price Each | Total Price |
      | MozyEnterprise User | 1        | $95.00     | $95.00      |
      | Discounts Applied   |          |            | -$19.00     |
      | Pre-tax Subtotal    |          |            | $76.00      |
      | Total Charges       |          |            | $76.00      |
    And New partner should be created