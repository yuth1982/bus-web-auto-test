Feature: Requirement #143134 Aria coupon code remove: change period and change plan

  Background:
    Given I log in bus admin console as administrator

  @TC.143134_31 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan monthly USD
    When I add a new MozyPro partner:
      | company name                              | period | base plan | country       |
      | DONOT EDIT MozyPro 10 GB Plan monthly USD | 1      | 10 GB     | United States |
    Then Sub-total before taxes or discounts should be $9.99
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | $9.99      | $9.99       |
      | Pre-tax Subtotal  |          |            | $9.99       |
      | Total Charges     |          |            | $9.99       |
    And New partner should be created

  @TC.143134_32 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan monthly USD new
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | country       | coupon      |
      | DONOT EDIT MozyPro 10 GB Plan monthly USD exception new | 1      | 10 GB     | United States | Nonprofit10 |
    Then Sub-total before taxes or discounts should be $9.99
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | $9.99      | $9.99       |
      | Discounts Applied |          |            | -$1.00      |
      | Pre-tax Subtotal  |          |            | $8.99       |
      | Total Charges     |          |            | $8.99       |
    And New partner should be created

  @TC.143134_33 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan yearly Ireland new
    When I add a new MozyPro partner:
      | company name                                     | period | base plan | server plan | create under    | country | coupon      | cc number        |
      | DONOT EDIT MozyPro 10 GB Plan yearly Ireland exception new | 12     | 10 GB     | yes         | MozyPro Ireland | Ireland | Nonprofit10 | 4319402211111113 |
    Then Sub-total before taxes or discounts should be €120.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | €87.89     | €87.89      |
      | Server Plan       | 1        | €32.89     | €32.89      |
      | Discounts Applied |          |            | -€12.08     |
      | Pre-tax Subtotal  |          |            | €108.70     |
      | Taxes             |          |            | €25.00      |
      | Total Charges     |          |            | €133.70     |
    And New partner should be created

  @TC.143134_34 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan yearly GBP new
    When I add a new MozyPro partner:
      | company name                                 | period | base plan | create under | country        | coupon                        | cc number        |
      | DONOT EDIT MozyPro 10 GB Plan yearly GBP exception new | 24     | 10 GB     | MozyPro UK   | United Kingdom | 100pctOffInternalTestCustomer | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £146.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | £146.79    | £146.79     |
      | Total Charges     |          |            | £0.00       |
    And New partner should be created

  @TC.143134_35 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan monthly GBP new
    When I add a new MozyPro partner:
      | company name                                   | period | base plan | server plan | storage add on 50 gb | create under | country        | coupon      | cc number        |
      | DONOT EDIT MozyPro 250 GB Plan monthly GBP exception new | 1      | 250 GB    | yes         | 1                    | MozyPro UK   | United Kingdom | Nonprofit10 | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £88.97
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £63.99     | £63.99      |
      | Server Plan       | 1        | £10.99     | £10.99      |
      | 50GB Add-on       | 1        | £13.99     | £13.99      |
      | Discounts Applied |          |            | -£8.90      |
      | Pre-tax Subtotal  |          |            | £80.07      |
      | Taxes             |          |            | £16.02      |
      | Total Charges     |          |            | £96.09      |
    And New partner should be created

  @TC.143134_36 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan yearly USD new
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | country       | coupon      |
      | DONOT EDIT MozyPro 250 GB Plan yearly USD exception new | 12     | 250 GB    | United States | Nonprofit10 |
    Then Sub-total before taxes or discounts should be $729.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $729.89    | $729.89     |
      | Discounts Applied |          |            | -$72.99     |
      | Pre-tax Subtotal  |          |            | $656.90     |
      | Total Charges     |          |            | $656.90     |
    And New partner should be created

  @TC.143134_37 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan Biennially EUR Germany new
    When I add a new MozyPro partner:
      | company name                                              | period | base plan | server plan | create under    | country | cc number        | coupon                        |
      | DONOT EDIT MozyPro 250 GB Plan Biennially EUR Germany exception new | 24     | 250 GB    | yes         | MozyPro Germany | Germany | 4188181111111112 | 100pctOffInternalTestCustomer |
    Then Sub-total before taxes or discounts should be €1,483.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €1,272.79  | €1,272.79   |
      | Server Plan       | 1        | €210.79    | €210.79     |
      | Total Charges     |          |            | €0.00       |
    And New partner should be created

  @TC.143134_38 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan monthly GBP VAT new
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | create under   | country | vat number    | coupon      | cc number        |
      | DONOT EDIT MozyPro 500 GB Plan monthly GBP VAT exception new | 1      | 500 GB    | MozyPro France | France  | FR08410091490 | Nonprofit10 | 4485393141463880 |
    Then Sub-total before taxes or discounts should be €149.99
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | €149.99    |  €149.99    |
      | Discounts Applied |          |            | -€15.00     |
      | Pre-tax Subtotal  |          |            | €134.99     |
      | Total Charges     |          |            | €134.99     |
    And New partner should be created

  @TC.143134_39 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan yearly GBP VAT new NOT execute successfully
    When I add a new MozyPro partner:
      | company name                                      | period | base plan | server plan | create under | country        | vat number  | coupon      | cc number        |
      | DONOT EDIT MozyPro 500 GB Plan yearly GBP VAT exception new | 12     | 500 GB    | yes         | MozyPro UK   | United Kingdom | GB117223643 | Nonprofit10 | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £1,056.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | £954.89    | £954.89     |
      | Server Plan       | 1        | £101.89    | £101.89     |
      | Discounts Applied |          |            | -£105.68    |
      | Pre-tax Subtotal  |          |            | £951.10     |
      | Total Charges     |          |            | £951.10     |
    And New partner should be created

  @TC.143134_310 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan Biennially USD new
    When I add a new MozyPro partner:
      | company name                                      | period | base plan | country       | coupon                        |
      | DONOT EDIT MozyPro 500 GB Plan Biennially USD exception new | 24     | 500 GB    | United States | 100pctOffInternalTestCustomer |
    Then Sub-total before taxes or discounts should be $2,789.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | $2,789.79  | $2,789.79   |
      | Total Charges     |          |            | $0.00       |
    And New partner should be created

  @TC.143134_311 @add_new_partner @mozypro
  Scenario: MozyPro 1 TB Plan monthly USD new
    When I add a new MozyPro partner:
      | company name                                 | period | base plan | server plan | storage add on | country       | coupon      |
      | DONOT EDIT MozyPro 1 TB Plan monthly USD exception new | 1      | 1 TB      | yes         | 2              | United States | Nonprofit10 |
    Then Sub-total before taxes or discounts should be $599.96
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 1 TB              | 1        | $379.99    | $379.99     |
      | Server Plan       | 1        | $29.99     | $29.99      |
      | 250 GB Add-on     | 2        | $94.99     | $189.98     |
      | Discounts Applied |          |            | -$60.00     |
      | Pre-tax Subtotal  |          |            | $539.96     |
      | Total Charges     |          |            | $539.96     |
    And New partner should be created

  @TC.143134_312 @add_new_partner @mozypro
  Scenario: MozyPro 1 TB Plan yearly Ireland new
    When I add a new MozyPro partner:
      | company name                                    | period | base plan | create under     | country | coupon      | vat number | cc number        |
      | DONOT EDIT MozyPro 1 TB Plan yearly Ireland exception new | 12     | 1 TB      | MozyPro Ireland  | Ireland | Nonprofit10 | IE9691104A | 4319402211111113 |
    Then Sub-total before taxes or discounts should be €2,654.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 1 TB              | 1        | €2,654.89  | €2,654.89   |
      | Discounts Applied |          |            | -€265.49    |
      | Pre-tax Subtotal  |          |            | €2,389.40   |
      | Taxes             |          |            | €549.56     |
      | Total Charges     |          |            | €2,938.96   |
    And New partner should be created

  @TC.143134_313 @add_new_partner @mozypro
  Scenario: MozyPro 1 TB Plan Biennially GBP new
    When I add a new MozyPro partner:
      | company name                               | period | base plan | server plan | create under | country        | coupon                        | cc number        |
      | DONOT EDIT MozyPro 1 TB Biennially GBP exception new | 24     | 1 TB      | yes         | MozyPro UK   | United Kingdom | 100pctOffInternalTestCustomer | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £3,938.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 1 TB              | 1        | £3,646.79  | £3,646.79   |
      | Server Plan       | 1        | £291.79    | £291.79     |
      | Total Charges     |          |            | £0.00       |
    And New partner should be created

  @TC.143134_314 @add_new_partner @mozypro
  Scenario: MozyPro 2 TB Plan monthly GBP new
    When I add a new MozyPro partner:
      | company name                            | period | base plan | create under | country        | coupon       | cc number        |
      | DONOT EDIT MozyPro 2 TB monthly GBP exception new | 1      | 2 TB      | MozyPro UK   | United Kingdom | Nonprofit10  | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £474.99
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 2 TB              | 1        | £474.99    | £474.99     |
      | Discounts Applied |          |            | -£47.50     |
      | Pre-tax Subtotal  |          |            | £427.49     |
      | Taxes             |          |            | £85.50      |
      | Total Charges     |          |            | £512.99     |
    And New partner should be created

  @TC.143134_315 @add_new_partner @mozypro @bus
  Scenario: MozyPro 2 TB Plan yearly USD new
    When I add a new MozyPro partner:
      | company name                           | period | base plan | server plan | country       | coupon      |
      | DONOT EDIT MozyPro 2 TB yearly USD exception new | 12     | 2 TB      | yes         | United States | Nonprofit10 |
    Then Sub-total before taxes or discounts should be $6,082.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 2 TB              | 1        | $5,769.89  | $5,769.89   |
      | Server Plan       | 1        | $312.89    | $312.89     |
      | Discounts Applied |          |            | -$608.28    |
      | Pre-tax Subtotal  |          |            | $5,474.50   |
      | Total Charges     |          |            | $5,474.50   |
    And New partner should be created

  @TC.143134_316 @add_new_partner @mozypro @bus
  Scenario: MozyPro 2 TB Plan Biennially EUR Germany new
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | create under    | country | cc number        | coupon                        |
      | DONOT EDIT MozyPro 2 TB Biennially EUR Germany exception new | 24     | 2 TB      | MozyPro Germany | Germany | 4188181111111112 | 100pctOffInternalTestCustomer |
    Then Sub-total before taxes or discounts should be €10,017.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 2 TB              | 1        | €10,017.79 | €10,017.79  |
      | Total Charges     |          |            | €0.00       |
    And New partner should be created

  @TC.143134_317 @add_new_partner @mozypro @bus
  Scenario: MozyPro 4 TB Plan monthly EUR France new
    When I add a new MozyPro partner:
      | company name                                      | period | base plan | server plan | create under   | country | cc number        | coupon      |
      | DONOT EDIT MozyPro 4 TB Biennially EUR France exception new | 1      | 4 TB      | yes         | MozyPro France | France  | 4485393141463880 | Nonprofit10 |
    Then Sub-total before taxes or discounts should be €1,149.98
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 4 TB              | 1        | €1,109.99  | €1,109.99   |
      | Server Plan       | 1        | €39.99     | €39.99      |
      | Discounts Applied |          |            | -€115.00    |
      | Pre-tax Subtotal  |          |            | €1,034.98   |
      | Taxes             |          |            | €207.00     |
      | Total Charges     |          |            | €1,241.98   |
    And New partner should be created

  @TC.143134_318 @add_new_partner @mozypro
  Scenario: MozyPro 4 TB Plan yearly GBP new
    When I add a new MozyPro partner:
      | company name                           | period | base plan | create under | country        | coupon       | cc number        |
      | DONOT EDIT MozyPro 4 TB yearly GBP exception new | 12     | 4 TB      | MozyPro UK   | United Kingdom | Nonprofit10  | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £7,248.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 4 TB              | 1        | £7,248.89  | £7,248.89   |
      | Discounts Applied |          |            | -£724.89    |
      | Pre-tax Subtotal  |          |            | £6,524.00   |
      | Taxes             |          |            | £1,304.80   |
      | Total Charges     |          |            | £7,828.80   |
    And New partner should be created

  @TC.143134_319 @add_new_partner @mozypro @bus
  Scenario: MozyPro 4 TB Plan Biennially USD new
    When I add a new MozyPro partner:
      | company name                               | period | base plan | server plan | country       | coupon                        |
      | DONOT EDIT MozyPro 4 TB Biennially USD exception new | 24     | 4 TB      | yes         | United States | 100pctOffInternalTestCustomer |
    Then Sub-total before taxes or discounts should be $21,902.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 4 TB              | 1        | $21,169.79 | $21,169.79  |
      | Server Plan       | 1        | $732.79    | $732.79     |
      | Total Charges     |          |            | $0.00       |
    And New partner should be created

  @TC.143134_320 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB yearly Ireland new change plan
    When I add a new MozyPro partner:
      | company name                                            | period | base plan | create under    | country | coupon      | cc number        |
      | DONOT EDIT MozyPro 10 GB yearly Ireland exception new change plan | 12     | 10 GB     | MozyPro Ireland | Ireland | Nonprofit10 | 4319402211111113 |
    Then Sub-total before taxes or discounts should be €87.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | €87.89     | €87.89      |
      | Discounts Applied |          |            | -€8.79      |
      | Pre-tax Subtotal  |          |            | €79.10      |
      | Taxes             |          |            | €18.19      |
      | Total Charges     |          |            | €97.29      |
    And New partner should be created

  @TC.143134_321 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan Biennially EUR Germany new change plan
    When I add a new MozyPro partner:
      | company name                                                          | period | base plan | create under    | country | cc number        | coupon                        |
      | DONOT EDIT MozyPro 250 GB Plan Biennially EUR Germany exception new change plan | 24     | 250 GB    | MozyPro Germany | Germany | 4188181111111112 | 100pctOffInternalTestCustomer |
    Then Sub-total before taxes or discounts should be €1,272.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €1,272.79  | €1,272.79   |
      | Total Charges     |          |            | €0.00       |
    And New partner should be created

  @TC.143134_322 @add_new_partner @mozypro @bus
  Scenario: Reseller silver monthly France new
    When I add a new Reseller partner:
      | company name                                  | period | reseller type | reseller quota | create under   | country | cc number        | coupon      |
      | DONOT EDIT Reseller silver monthly France exception new | 1      | Silver        | 100            | MozyPro France | France  | 4485393141463880 | Nonprofit10 |
    Then Sub-total before taxes or discounts should be €30.00
    And Order summary table should be:
      | Description          | Quantity | Price Each | Total Price |
      | GB - Silver Reseller | 100      | €0.30      | €30.00      |
      | Discounts Applied    |          |            | -€3.00      |
      | Pre-tax Subtotal     |          |            | €27.00      |
      | Taxes                |          |            | €5.40       |
      | Total Charges        |          |            | €32.40      |
    And New partner should be created

  @TC.143134_323 @add_new_partner @mozypro @bus
  Scenario: Reseller silver yearly EUR Ireland new
    When I add a new Reseller partner:
      | company name                                      | period | reseller type | reseller quota | server plan | storage add on | create under    | vat number | coupon      | country | cc number        |
      | DONOT EDIT Reseller silver yearly EUR Ireland exception new | 12     | Silver        | 500            | yes         | 10             | MozyPro Ireland | IE9691104A | Nonprofit10 | Ireland | 4319402211111113 |
    Then Sub-total before taxes or discounts should be €2,760.00
    And Order summary table should be:
      | Description          | Quantity | Price Each | Total Price |
      | GB - Silver Reseller | 500      | €3.60      | €1,800.00   |
      | Server Plan          | 1        | €240.00    | €240.00     |
      | 20 GB add-on         | 10       | €72.00     | €720.00     |
      | Discounts Applied    |          |            | -€276.00    |
      | Pre-tax Subtotal     |          |            | €2,484.00   |
      | Taxes                |          |            | €571.32     |
      | Total Charges        |          |            | €3,055.32   |
    And New partner should be created

  @TC.143134_324 @add_new_partner @mozypro @bus
  Scenario: Reseller gold monthly GBP new execute manually as wrong sequence of gold and platinum
    When I add a new Reseller partner:
      | company name                             | period | reseller type | reseller quota | create under | vat number  | coupon                        | country        | cc number        |
      | DONOT EDIT Reseller gold monthly GBP exception new | 1      | Gold          | 500            | MozyPro UK   | GB117223643 | 100pctOffInternalTestCustomer | United Kingdom | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £90.00
    And Order summary table should be:
      | Description        | Quantity | Price Each | Total Price |
      | GB - Gold Reseller | 500      | £0.18      | £90.00      |
      | Total Charges      |          |            | £0.00       |
    And New partner should be created

  @TC.143134_325 @add_new_partner @mozypro @bus
  Scenario: Reseller gold yearly GBP new
    When I add a new Reseller partner:
      | company name                            | period | reseller type | reseller quota | server plan | storage add on | create under | coupon      | country        | cc number        |
      | DONOT EDIT Reseller gold yearly GBP exception new | 12     | Gold          | 100            | yes         | 10             | MozyPro UK   | Nonprofit10 | United Kingdom | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £1,428.00
    And Order summary table should be:
      | Description        | Quantity | Price Each | Total Price |
      | GB - Gold Reseller | 100      | £2.16      | £216.00     |
      | Server Plan        | 1        | £780.00    | £780.00     |
      | 20 GB add-on       | 10       | £43.20     | £432.00     |
      | Discounts Applied  |          |            | -£142.80    |
      | Pre-tax Subtotal   |          |            | £1,285.20   |
      | Taxes              |          |            | £257.04     |
      | Total Charges      |          |            | £1,542.24   |
    And New partner should be created

  @TC.143134_326 @add_new_partner @mozypro @bus
  Scenario: Reseller platinum monthly USD new execute manually as wrong sequence of gold and platinum
    When I add a new Reseller partner:
      | company name                                 | period | reseller type | reseller quota | coupon      | country       |
      | DONOT EDIT Reseller platinum monthly USD exception new | 1      | Platinum      | 100            | Nonprofit10 | United States |
    Then Sub-total before taxes or discounts should be $24.00
    And Order summary table should be:
      | Description            | Quantity | Price Each | Total Price |
      | GB - Platinum Reseller | 100      | $0.24      | $24.00      |
      | Discounts Applied      |          |            | -$2.40      |
      | Pre-tax Subtotal       |          |            | $21.60      |
      | Total Charges          |          |            | $21.60      |
    And New partner should be created

  @TC.143134_327 @add_new_partner @mozypro @bus
  Scenario: Reseller platinum yearly USD new
    When I add a new Reseller partner:
      | company name                                | period | reseller type | reseller quota | server plan | storage add on | coupon                        | country       |
      | DONOT EDIT Reseller platinum yearly USD exception new | 12     | Platinum      | 100            | yes         | 10             | 100pctOffInternalTestCustomer | United States |
    Then Sub-total before taxes or discounts should be $2,964.00
    And Order summary table should be:
      | Description            | Quantity | Price Each | Total Price |
      | GB - Platinum Reseller | 100      | $2.88      | $288.00     |
      | Server Plan            | 1        | $2,100.00  | $2,100.00   |
      | 20 GB add-on           | 10       | $57.60     | $576.00     |
      | Total Charges          |          |            | $0.00       |
    And New partner should be created

  @TC.143134_328 @add_new_partner @mozypro @bus
  Scenario: Reseller silver yearly EUR Ireland new
    When I add a new Reseller partner:
      | company name                                                  | period | reseller type | reseller quota | create under    | vat number | coupon      | country | cc number        |
      | DONOT EDIT Reseller silver yearly EUR Ireland change plan exception new | 12     | Silver        | 500            | MozyPro Ireland | IE9691104A | Nonprofit10 | Ireland | 4319402211111113 |
    Then Sub-total before taxes or discounts should be €1,800.00
    And Order summary table should be:
      | Description          | Quantity | Price Each | Total Price |
      | GB - Silver Reseller | 500      | €3.60      | €1,800.00   |
      | Discounts Applied    |          |            | -€180.00    |
      | Pre-tax Subtotal     |          |            | €1,620.00   |
      | Taxes                |          |            | €372.60     |
      | Total Charges        |          |            | €1,992.60   |
    And New partner should be created

  @TC.143134_329 @add_new_partner @mozypro @bus
  Scenario: Reseller gold yearly GBP new
    When I add a new Reseller partner:
      | company name                                        | period | reseller type | reseller quota | create under | coupon      | country        | cc number        |
      | DONOT EDIT Reseller gold yearly GBP exception new change plan | 12     | Gold          | 100            | MozyPro UK   | Nonprofit10 | United Kingdom | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £216.00
    And Order summary table should be:
      | Description        | Quantity | Price Each | Total Price |
      | GB - Gold Reseller | 100      | £2.16      | £216.00     |
      | Discounts Applied  |          |            | -£21.60     |
      | Pre-tax Subtotal   |          |            | £194.40     |
      | Taxes              |          |            | £38.88      |
      | Total Charges      |          |            | £233.28     |
    And New partner should be created

  @TC.143134_330 @add_new_partner @mozypro @bus
  Scenario: Reseller platinum yearly USD new
    When I add a new Reseller partner:
      | company name                                            | period | reseller type | reseller quota | coupon                        | country       |
      | DONOT EDIT Reseller platinum yearly USD change plan exception new | 12     | Platinum      | 100            | 100pctOffInternalTestCustomer | United States |
    Then Sub-total before taxes or discounts should be $288.00
    And Order summary table should be:
      | Description            | Quantity | Price Each | Total Price |
      | GB - Platinum Reseller | 100      | $2.88      | $288.00     |
      | Total Charges          |          |            | $0.00       |
    And New partner should be created

  @TC.143134_331 @add_new_partner @mozypro @bus
  Scenario: Reseller monthly USD new without inital purchase
    When I add a new Reseller partner:
      | company name                                | period | country        | coupon      |
      | DONOT EDIT Reseller monthly USD exception new without | 1      | United States  | Nonprofit10 |
    Then Sub-total before taxes or discounts should be 0
    And New partner should be created

  @TC.143134_332 @add_new_partner @mozypro @bus
  Scenario: Reseller monthly France new without inital purchase
    When I add a new Reseller partner:
      | company name                                   | period | create under   | country | cc number        | coupon      |
      | DONOT EDIT Reseller monthly France exception new without | 1      | MozyPro France | France  | 4485393141463880 | Nonprofit10 |
    Then Sub-total before taxes or discounts should be 0
    And New partner should be created

  @TC.143134_333 @add_new_partner @mozypro @bus
  Scenario: Reseller monthly GBP  newwithout inital purchase
    When I add a new Reseller partner:
      | company name                                | period | create under | country        | coupon      |
      | DONOT EDIT Reseller monthly GBP exception new without | 1      | MozyPro UK   | United Kingdom | Nonprofit10 |
    Then Sub-total before taxes or discounts should be 0
    And New partner should be created

  @TC.143134_334 @add_new_partner @mozypro @bus
  Scenario: Reseller yearly USD new without inital purchase
    When I add a new Reseller partner:
      | company name                               | period | country        | coupon      |
      | DONOT EDIT Reseller yearly USD exception new without | 12     | United States  | Nonprofit10 |
    Then Sub-total before taxes or discounts should be 0
    And New partner should be created

  @TC.143134_335 @add_new_partner @mozypro @bus
  Scenario: Reseller yearly France new without inital purchase
    When I add a new Reseller partner:
      | company name                                  | period | create under   | country | cc number        | coupon      |
      | DONOT EDIT Reseller yearly France exception new without | 12     | MozyPro France | France  | 4485393141463880 | Nonprofit10 |
    Then Sub-total before taxes or discounts should be 0
    And New partner should be created

  @TC.143134_336 @add_new_partner @mozypro @bus
  Scenario: Reseller yearly GBP new without inital purchase
    When I add a new Reseller partner:
      | company name                               | period | create under | country        | coupon      |
      | DONOT EDIT Reseller yearly GBP exception new without | 12     | MozyPro UK   | United Kingdom | Nonprofit10 |
    Then Sub-total before taxes or discounts should be 0
    And New partner should be created
