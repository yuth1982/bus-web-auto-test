Feature: Requirement #141405 Changing price schedules in Aria, and how this is reflected in BUS

  Background:
    Given I log in bus admin console as administrator

  @TC.141405_coupon_1 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Annual) USD coupon
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | country       | net terms | coupon              |
      | DONOT EDIT MozyPro 250 GB Plan (Annual) USD coupon | 12     | 250 GB    | United States | yes       | 10PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $729.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $729.89    | $729.89     |
      | Discounts Applied |          |            | -$72.99     |
      | Pre-tax Subtotal  |          |            | $656.90     |
      | Total Charges     |          |            | $656.90     |
    And New partner should be created

  @TC.141405_coupon_2 @add_new_partner @mozypro @bus
  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) USD coupon
    When I add a new MozyPro partner:
      | company name                                                             | period | base plan | server plan | country       | net terms | coupon              |
      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) USD coupon | 12     | 250 GB    | yes         | United States | yes       | 20PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $854.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $729.89    | $729.89     |
      | Server Plan       | 1        | $124.89    | $124.89     |
      | Discounts Applied |          |            | -$170.96    |
      | Pre-tax Subtotal  |          |            | $683.82     |
      | Total Charges     |          |            | $683.82     |
    And New partner should be created

  @TC.141405_coupon_3 @add_new_partner @mozypro @bus
  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) USD coupon 100
    When I add a new MozyPro partner:
      | company name                                                                 | period | base plan | server plan | country       | net terms | coupon               |
      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) USD coupon 100 | 12     | 250 GB    | yes         | United States | yes       | 100PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $854.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $729.89    | $729.89     |
      | Server Plan       | 1        | $124.89    | $124.89     |
      | Discounts Applied |          |            | -$854.78    |
      | Total Charges     |          |            | $0.00       |
    And New partner should be created

  @TC.141405_coupon_4 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Annual) EUR France coupon
    When I add a new MozyPro partner:
      | company name                                              | period | base plan | create under   | country | net terms | coupon               |
      | DONOT EDIT MozyPro 250 GB Plan (Annual) EUR France coupon | 12     | 250 GB    | MozyPro France | France  | yes       | 100PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be €663.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €663.89    | €663.89     |
      | Discounts Applied |          |            | -€663.89    |
      | Total Charges     |          |            | €0.00       |
    And New partner should be created

  @TC.141405_coupon_5 @add_new_partner @mozypro @bus
  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) EUR Germany coupon
    When I add a new MozyPro partner:
      | company name                                                                     | period | base plan | server plan | create under    | country | net terms | coupon              |
      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) EUR Germany coupon | 12     | 250 GB    | yes         | MozyPro Germany | Germany | yes       | 10PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be €777.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €663.89    | €663.89     |
      | Server Plan       | 1        | €113.89    | €113.89     |
      | Discounts Applied |          |            | -€77.78     |
      | Pre-tax Subtotal  |          |            | €700.00     |
      | Taxes             |          |            | €133.01     |
      | Total Charges     |          |            | €833.01     |
    And New partner should be created

  @TC.141405_coupon_6 @add_new_partner @mozypro @bus
  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) EUR Ireland coupon VAT
    When I add a new MozyPro partner:
      | company name                                                                         | period | base plan | server plan | create under    | country | net terms | coupon              | vat number |
      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) EUR Ireland coupon VAT | 12     | 250 GB    | yes         | MozyPro Ireland | Ireland | yes       | 20PERCENTOFFOUTLINE | IE9691104A |
    Then Sub-total before taxes or discounts should be €777.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €663.89    | €663.89     |
      | Server Plan       | 1        | €113.89    | €113.89     |
      | Discounts Applied |          |            | -€155.56    |
      | Pre-tax Subtotal  |          |            | €622.22     |
      | Taxes             |          |            | €143.12     |
      | Total Charges     |          |            | €765.34     |
    And New partner should be created

  @TC.141405_coupon_7 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Annual) EUR Germany VAT
    When I add a new MozyPro partner:
      | company name                                            | period | base plan | create under    | country | net terms | vat number  |
      | DONOT EDIT MozyPro 250 GB Plan (Annual) EUR Germany VAT | 12     | 250 GB    | MozyPro Germany | Germany | yes       | DE812321109 |
    Then Sub-total before taxes or discounts should be €663.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €663.89    | €663.89     |
      | Pre-tax Subtotal  |          |            | €663.89     |
      | Total Charges     |          |            | €663.89     |
    And New partner should be created

  @TC.141405_coupon_8 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Annual) GBP coupon
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | create under | country        | net terms | coupon              |
      | DONOT EDIT MozyPro 250 GB Plan (Annual) GBP coupon | 12     | 250 GB    | MozyPro UK   | United Kingdom | yes       | 20PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be £477.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £477.89    | £477.89     |
      | Discounts Applied |          |            | -£95.58     |
      | Pre-tax Subtotal  |          |            | £382.31     |
      | Taxes             |          |            | £76.46      |
      | Total Charges     |          |            | £458.77     |
    And New partner should be created

  @TC.141405_coupon_9 @add_new_partner @mozypro @bus
  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) GBP VAT
    When I add a new MozyPro partner:
      | company name                                                          | period | base plan | server plan | create under | country        | net terms | vat number  |
      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) GBP VAT | 12     | 250 GB    | yes         | MozyPro UK   | United Kingdom | yes       | GB117223643 |
    Then Sub-total before taxes or discounts should be £558.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £477.89    | £477.89     |
      | Server Plan       | 1        | £80.89     | £80.89      |
      | Pre-tax Subtotal  |          |            | £558.78     |
      | Total Charges     |          |            | £558.78     |
    And New partner should be created

  @TC.141405_coupon_10 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Annual) GBP coupon VAT
    When I add a new MozyPro partner:
      | company name                                           | period | base plan | create under | country        | net terms | coupon              | vat number  |
      | DONOT EDIT MozyPro 250 GB Plan (Annual) GBP coupon VAT | 12     | 250 GB    | MozyPro UK   | United Kingdom | yes       | 10PERCENTOFFOUTLINE | GB117223643 |
    Then Sub-total before taxes or discounts should be £477.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £477.89    | £477.89     |
      | Discounts Applied |          |            | -£47.79     |
      | Pre-tax Subtotal  |          |            | £430.10     |
      | Total Charges     |          |            | £430.10     |
    And New partner should be created

  @TC.141405_coupon_11 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Biennial) USD coupon
    When I add a new MozyPro partner:
      | company name                                         | period | base plan | country       | net terms | coupon               |
      | DONOT EDIT MozyPro 250 GB Plan (Biennial) USD coupon | 24     | 250 GB    | United States | yes       | 100PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $1,396.35
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $1,396.35  | $1,396.35   |
      | Discounts Applied |          |            | -$1,396.35  |
      | Total Charges     |          |            | $0.00       |
    And New partner should be created

  @TC.141405_coupon_12 @add_new_partner @mozypro @bus
  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) USD coupon
    When I add a new MozyPro partner:
      | company name                                                           | period | base plan | server plan | country       | net terms | coupon              |
      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) USD coupon | 24     | 250 GB    | yes         | United States | yes       | 10PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $1,631.40
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $1,396.35  | $1,396.35   |
      | Server Plan       | 1        | $235.05    | $235.05     |
      | Discounts Applied |          |            | -$163.14    |
      | Pre-tax Subtotal  |          |            | $1,468.26   |
      | Total Charges     |          |            | $1,468.26   |
    And New partner should be created

  @TC.141405_coupon_13 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Biennial) EUR Ireland coupon
    When I add a new MozyPro partner:
      | company name                                                 | period | base plan | create under    | country | net terms | coupon               |
      | DONOT EDIT MozyPro 250 GB Plan (Biennial) EUR Ireland coupon | 24     | 250 GB    | MozyPro Ireland | Ireland | yes       | 100PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be €1,269.41
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €1,269.41  | €1,269.41   |
      | Discounts Applied |          |            | -€1,269.41  |
      | Total Charges     |          |            | €0.00       |
    And New partner should be created

  @TC.141405_coupon_14 @add_new_partner @mozypro @bus
  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) EUR France VAT
    When I add a new MozyPro partner:
      | company name                                                               | period | base plan | server plan | create under   | country | net terms | vat number    |
      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) EUR France VAT | 24     | 250 GB    | yes         | MozyPro France | France  | yes       | FR08410091490 |
    Then Sub-total before taxes or discounts should be €1,483.09
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €1,269.41  | €1,269.41   |
      | Server Plan       | 1        | €213.68    | €213.68     |
      | Pre-tax Subtotal  |          |            | €1,483.09   |
      | Total Charges     |          |            | €1,483.09   |
    And New partner should be created

  @TC.141405_coupon_15 @add_new_partner @mozypro @bus
  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) EUR Germany Coupon VAT
    When I add a new MozyPro partner:
      | company name                                                                       | period | base plan | server plan | create under    | country | net terms | coupon              | vat number  |
      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) EUR Germany Coupon VAT | 24     | 250 GB    | yes         | MozyPro Germany | Germany | yes       | 20PERCENTOFFOUTLINE | DE812321109 |
    Then Sub-total before taxes or discounts should be €1,483.09
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €1,269.41  | €1,269.41   |
      | Server Plan       | 1        | €213.68    | €213.68     |
      | Discounts Applied |          |            | -€296.62    |
      | Pre-tax Subtotal  |          |            | €1,186.47   |
      | Total Charges     |          |            | €1,186.47   |
    And New partner should be created

  @TC.141405_coupon_16 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Biennial) GBP VAT
    When I add a new MozyPro partner:
      | company name                                      | period | base plan | create under | country        | net terms | vat number  |
      | DONOT EDIT MozyPro 250 GB Plan (Biennial) GBP VAT | 24     | 250 GB    | MozyPro UK   | United Kingdom | yes       | GB117223643 |
    Then Sub-total before taxes or discounts should be £912.65
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £912.65    | £912.65   |
      | Pre-tax Subtotal  |          |            | £912.65   |
      | Total Charges     |          |            | £912.65   |
    And New partner should be created

  @TC.141405_coupon_17 @add_new_partner @mozypro @bus
  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) GBP Coupon
    When I add a new MozyPro partner:
      | company name                                                           | period | base plan | server plan | create under | country        | net terms | coupon              |
      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) GBP Coupon | 24     | 250 GB    | yes         | MozyPro UK   | United Kingdom | yes       | 20PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be £1,066.28
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £912.65    | £912.65     |
      | Server Plan       | 1        | £153.63    | £153.63     |
      | Discounts Applied |          |            | -£213.26    |
      | Pre-tax Subtotal  |          |            | £853.02    |
      | Taxes             |          |            | £170.60     |
      | Total Charges     |          |            | £1,023.62   |
    And New partner should be created
