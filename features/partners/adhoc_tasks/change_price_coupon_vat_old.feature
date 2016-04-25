Feature: Requirement #141405 Changing price schedules in Aria, and how this is reflected in BUS

  Background:
    Given I log in bus admin console as administrator

  @TC.141405_coupon_1 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Annual) USD coupon
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | country       | net terms | coupon              |
      | DONOT EDIT MozyPro 250 GB Plan (Annual) USD coupon | 12     | 250 GB    | United States | yes       | 10PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $1,044.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $1,044.89  | $1,044.89   |
      | Discounts Applied |          |            | -$104.49    |
      | Pre-tax Subtotal  |          |            | $940.40     |
      | Total Charges     |          |            | $940.40     |
    And New partner should be created

  @TC.141405_coupon_2 @add_new_partner @mozypro @bus
  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) USD coupon
    When I add a new MozyPro partner:
      | company name                                                             | period | base plan | server plan | country       | net terms | coupon              |
      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) USD coupon | 12     | 250 GB    | yes         | United States | yes       | 20PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $1,220.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $1,044.89  | $1,044.89   |
      | Server Plan       | 1        | $175.89    | $175.89     |
      | Discounts Applied |          |            | -$244.16    |
      | Pre-tax Subtotal  |          |            | $976.62     |
      | Total Charges     |          |            | $976.62     |
    And New partner should be created

  @TC.141405_coupon_3 @add_new_partner @mozypro @bus
  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) USD coupon 100
    When I add a new MozyPro partner:
      | company name                                                                 | period | base plan | server plan | country       | net terms | coupon               |
      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) USD coupon 100 | 12     | 250 GB    | yes         | United States | yes       | 100PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $1,220.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $1,044.89  | $1,044.89   |
      | Server Plan       | 1        | $175.89    | $175.89     |
      | Discounts Applied |          |            | -$1,220.78  |
      | Total Charges     |          |            | $0.00       |
    And New partner should be created

  @TC.141405_coupon_4 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Annual) EUR France coupon
    When I add a new MozyPro partner:
      | company name                                              | period | base plan | create under   | country | net terms | coupon               |
      | DONOT EDIT MozyPro 250 GB Plan (Annual) EUR France coupon | 12     | 250 GB    | MozyPro France | France  | yes       | 100PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be €824.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €824.89    | €824.89     |
      | Discounts Applied |          |            | -€824.89    |
      | Total Charges     |          |            | €0.00       |
    And New partner should be created

  @TC.141405_coupon_5 @add_new_partner @mozypro @bus
  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) EUR Germany coupon
    When I add a new MozyPro partner:
      | company name                                                                     | period | base plan | server plan | create under    | country | net terms | coupon              |
      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) EUR Germany coupon | 12     | 250 GB    | yes         | MozyPro Germany | Germany | yes       | 10PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be €967.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €824.89    | €824.89     |
      | Server Plan       | 1        | €142.89    | €142.89     |
      | Discounts Applied |          |            | -€96.78     |
      | Pre-tax Subtotal  |          |            | €871.00     |
      | Taxes             |          |            | €165.49     |
      | Total Charges     |          |            | €1,036.49   |
    And New partner should be created

  @TC.141405_coupon_6 @add_new_partner @mozypro @bus
  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) EUR Ireland coupon VAT
    When I add a new MozyPro partner:
      | company name                                                                         | period | base plan | server plan | create under    | country | net terms | coupon              | vat number |
      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) EUR Ireland coupon VAT | 12     | 250 GB    | yes         | MozyPro Ireland | Ireland | yes       | 20PERCENTOFFOUTLINE | IE9691104A |
    Then Sub-total before taxes or discounts should be €967.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €824.89    | €824.89     |
      | Server Plan       | 1        | €142.89    | €142.89     |
      | Discounts Applied |          |            | -€193.56    |
      | Pre-tax Subtotal  |          |            | €774.22     |
      | Taxes             |          |            | €178.07     |
      | Total Charges     |          |            | €952.29     |
    And New partner should be created

  @TC.141405_coupon_7 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Annual) EUR Germany VAT
    When I add a new MozyPro partner:
      | company name                                            | period | base plan | create under    | country | net terms | vat number  |
      | DONOT EDIT MozyPro 250 GB Plan (Annual) EUR Germany VAT | 12     | 250 GB    | MozyPro Germany | Germany | yes       | DE812321109 |
    Then Sub-total before taxes or discounts should be €824.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €824.89    | €824.89     |
      | Pre-tax Subtotal  |          |            | €824.89     |
      | Total Charges     |          |            | €824.89     |
    And New partner should be created

  @TC.141405_coupon_8 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Annual) GBP coupon
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | create under | country        | net terms | coupon              |
      | DONOT EDIT MozyPro 250 GB Plan (Annual) GBP coupon | 12     | 250 GB    | MozyPro UK   | United Kingdom | yes       | 20PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be £703.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £703.89    | £703.89     |
      | Discounts Applied |          |            | -£140.78    |
      | Pre-tax Subtotal  |          |            | £563.11     |
      | Taxes             |          |            | £112.62     |
      | Total Charges     |          |            | £675.73     |
    And New partner should be created

  @TC.141405_coupon_9 @add_new_partner @mozypro @bus
  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) GBP VAT
    When I add a new MozyPro partner:
      | company name                                                          | period | base plan | server plan | create under | country        | net terms | vat number  |
      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) GBP VAT | 12     | 250 GB    | yes         | MozyPro UK   | United Kingdom | yes       | GB117223643 |
    Then Sub-total before taxes or discounts should be £824.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £703.89    | £703.89     |
      | Server Plan       | 1        | £120.89    | £120.89     |
      | Pre-tax Subtotal  |          |            | £824.78     |
      | Total Charges     |          |            | £824.78     |
    And New partner should be created

  @TC.141405_coupon_10 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Annual) GBP coupon VAT
    When I add a new MozyPro partner:
      | company name                                           | period | base plan | create under | country        | net terms | coupon              | vat number  |
      | DONOT EDIT MozyPro 250 GB Plan (Annual) GBP coupon VAT | 12     | 250 GB    | MozyPro UK   | United Kingdom | yes       | 10PERCENTOFFOUTLINE | GB117223643 |
    Then Sub-total before taxes or discounts should be £703.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £703.89    | £703.89     |
      | Discounts Applied |          |            | -£70.39     |
      | Pre-tax Subtotal  |          |            | £633.50     |
      | Total Charges     |          |            | £633.50     |
    And New partner should be created

  @TC.141405_coupon_11 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Biennial) USD coupon
    When I add a new MozyPro partner:
      | company name                                         | period | base plan | country       | net terms | coupon               |
      | DONOT EDIT MozyPro 250 GB Plan (Biennial) USD coupon | 24     | 250 GB    | United States | yes       | 100PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $1,994.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $1,994.79  | $1,994.79   |
      | Discounts Applied |          |            | -$1,994.79  |
      | Total Charges     |          |            | $0.00       |
    And New partner should be created

  @TC.141405_coupon_12 @add_new_partner @mozypro @bus
  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) USD coupon
    When I add a new MozyPro partner:
      | company name                                                           | period | base plan | server plan | country       | net terms | coupon              |
      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) USD coupon | 24     | 250 GB    | yes         | United States | yes       | 10PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $2,330.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $1,994.79  | $1,994.79   |
      | Server Plan       | 1        | $335.79    | $335.79     |
      | Discounts Applied |          |            | -$233.06    |
      | Pre-tax Subtotal  |          |            | $2,097.52   |
      | Total Charges     |          |            | $2,097.52   |
    And New partner should be created

  @TC.141405_coupon_13 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Biennial) EUR Ireland coupon
    When I add a new MozyPro partner:
      | company name                                                 | period | base plan | create under    | country | net terms | coupon               |
      | DONOT EDIT MozyPro 250 GB Plan (Biennial) EUR Ireland coupon | 24     | 250 GB    | MozyPro Ireland | Ireland | yes       | 100PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be €1,574.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €1,574.79  | €1,574.79   |
      | Discounts Applied |          |            | -€1,574.79  |
      | Total Charges     |          |            | €0.00       |
    And New partner should be created

  @TC.141405_coupon_14 @add_new_partner @mozypro @bus
  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) EUR France VAT
    When I add a new MozyPro partner:
      | company name                                                               | period | base plan | server plan | create under   | country | net terms | vat number    |
      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) EUR France VAT | 24     | 250 GB    | yes         | MozyPro France | France  | yes       | FR08410091490 |
    Then Sub-total before taxes or discounts should be €1,847.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €1,574.79  | €1,574.79   |
      | Server Plan       | 1        | €272.79    | €272.79     |
      | Pre-tax Subtotal  |          |            | €1,847.58   |
      | Total Charges     |          |            | €1,847.58   |
    And New partner should be created

  @TC.141405_coupon_15 @add_new_partner @mozypro @bus
  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) EUR Germany Coupon VAT
    When I add a new MozyPro partner:
      | company name                                                                       | period | base plan | server plan | create under    | country | net terms | coupon              | vat number  |
      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) EUR Germany Coupon VAT | 24     | 250 GB    | yes         | MozyPro Germany | Germany | yes       | 20PERCENTOFFOUTLINE | DE812321109 |
    Then Sub-total before taxes or discounts should be €1,847.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €1,574.79  | €1,574.79   |
      | Server Plan       | 1        | €272.79    | €272.79     |
      | Discounts Applied |          |            | -€369.52    |
      | Pre-tax Subtotal  |          |            | €1,478.06   |
      | Total Charges     |          |            | €1,478.06   |
    And New partner should be created

  @TC.141405_coupon_16 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Biennial) GBP VAT
    When I add a new MozyPro partner:
      | company name                                      | period | base plan | create under | country        | net terms | vat number  |
      | DONOT EDIT MozyPro 250 GB Plan (Biennial) GBP VAT | 24     | 250 GB    | MozyPro UK   | United Kingdom | yes       | GB117223643 |
    Then Sub-total before taxes or discounts should be £1,343.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £1,343.79  | £1,343.79   |
      | Pre-tax Subtotal  |          |            | £1,343.79   |
      | Total Charges     |          |            | £1,343.79   |
    And New partner should be created

  @TC.141405_coupon_17 @add_new_partner @mozypro @bus
  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) GBP Coupon
    When I add a new MozyPro partner:
      | company name                                                           | period | base plan | server plan | create under | country        | net terms | coupon              |
      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) GBP Coupon | 24     | 250 GB    | yes         | MozyPro UK   | United Kingdom | yes       | 20PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be £1,574.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £1,343.79  | £1,343.79   |
      | Server Plan       | 1        | £230.79    | £230.79     |
      | Discounts Applied |          |            | -£314.92    |
      | Pre-tax Subtotal  |          |            | £1,259.66   |
      | Taxes             |          |            | £251.94     |
      | Total Charges     |          |            | £1,511.60   |
    And New partner should be created
