Feature: Requirement #141405   Changing price schedules in Aria, and how this is reflected in BUS

  Background:
    Given I log in bus admin console as administrator

  @TC.141405_coupon_us1 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Annual) USD coupon
    When I add a new MozyPro partner:
      | company name                                      | period | base plan | country      | net terms | coupon              |
      | DONOT EDIT MozyPro 500 GB Plan (Annual) USD coupon new| 12    | 500 GB    | United States | yes      | 10PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $1,459.89
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | $1,459.89  | $1,459.89  |
      | Discounts Applied |          |            | -$145.99    |
      | Pre-tax Subtotal  |          |            | $1,313.90    |
      | Total Charges    |          |            | $1,313.90    |
    And New partner should be created

  @TC.141405_coupon_us2 @add_new_partner @mozypro
  Scenario: MozyPro500 Server Add-on for MozyPro Plan( Annual) USD coupon
    When I add a new MozyPro partner:
      | company name                                                            | period | base plan | server plan | country      | net terms | coupon              |
      | DONOT EDIT MozyPro 500GB Server Add-on for MozyPro Plan( Annual) USD coupon new| 12    | 500 GB    | yes        | United States | yes      | 20PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $1,616.78
    And Order summary table should be:
      | Description| Quantity | Price Each | Total Price |
      | 500 GB     |1         | $1,459.89  | $1,459.89   |
      | Server Plan|1         |  $156.89   | $156.89     |
      | Discounts Applied|    |            |-$323.36     |
      | Pre-tax Subtotal |    |            | $1,293.42   |
      | Total Charges    |    |            | $1,293.42   |
    And New partner should be created

  @TC.141405_coupon_us3 @add_new_partner @mozypro
  Scenario: MozyPro500 Server Add-on for MozyPro Plan( Annual) USD coupon 100
    When I add a new MozyPro partner:
      | company name                                                                | period | base plan | server plan | country      | net terms | coupon              |
      | DONOT EDIT MozyPro500 Server Add-on for MozyPro Plan( Annual) USD coupon 100 new| 12    | 500 GB    | yes        | United States | yes      | 100PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $1,616.78
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 500 GB           |    1     | $1,459.89  | $1,459.89   |
      | Server Plan      |    1     | $156.89    | $156.89     |
      | Discounts Applied|          |            | -$1,616.78  |
      | Total Charges    |          |            |  $0.00      |
    And New partner should be created


  @TC.141405_coupon_EUR1 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Annual) EUR coupon - VAT - server plan
    When I add a new MozyPro partner:
      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | coupon              |vat number|
      | DONOT EDIT MozyPro 500 GB server add-on Plan (Annual) EUR coupon-VAT new| 12    | 500 GB    |    yes         |MozyPro France |France | yes      | 10PERCENTOFFOUTLINE |   FR08410091490           |
    Then Sub-total before taxes or discounts should be €1,469.78
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 500 GB           |    1     |  €1,327.89 |  €1,327.89  |
      | Server Plan      |    1     |   €141.89  |  €141.89    |
      | Discounts Applied|          |            | -€146.98    |
      | Pre-tax Subtotal |          |            | €1,322.80   |
      | Total Charges    |          |            | €1,322.80   |
    And New partner should be created

  @TC.141405_coupon_EUR2 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Annual) EUR coupon - server plan
    When I add a new MozyPro partner:
      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | coupon              |
      | DONOT EDIT MozyPro 500 GB server add-on Plan (Annual) EUR coupon new| 12    | 500 GB    |    yes         |MozyPro Ireland |Ireland | yes      | 20PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be €1,469.78
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      |   500 GB         |    1     |  €1,327.89 |  €1,327.89  |
      |  Server Plan     |    1     |  €141.89   |  €141.89    |
      | Discounts Applied|          |            | -€293.96    |
      | Pre-tax Subtotal |          |            | €1,175.82   |
      |    Taxes         |          |            |  €270.44    |
      | Total Charges    |          |            | €1,446.26   |
    And New partner should be created


  @TC.141405_coupon_EUR3 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Annual) EUR VAT - server plan
    When I add a new MozyPro partner:
      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | vat number              |
      | DONOT EDIT MozyPro 500 GB server add-on Plan (Annual) EUR VAT new   | 12    | 500 GB    |    yes         |MozyPro Germany |Germany | yes      | DE812321109 |
    Then Sub-total before taxes or discounts should be €1,469.78
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      |   500 GB         |    1     |  €1,327.89 |  €1,327.89  |
      |  Server Plan     |    1     |  €141.89   |  €141.89    |
      | Pre-tax Subtotal |          |            | €1,469.78   |
      | Total Charges    |          |            | €1,469.78   |
    And New partner should be created



  @TC.141405_coupon_EUR4 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Annual) EUR VAT only
    When I add a new MozyPro partner:
      | company name                                         | period | base plan | create under      |country       | net terms | vat number  |
      | DONOT EDIT MozyPro 500 GB Plan (Annual) EUR VAT only new| 12     | 500 GB    |   MozyPro Germany |Germany       | yes       | DE812321109 |
    Then Sub-total before taxes or discounts should be €1,327.89
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      |   500 GB         |    1     |  €1,327.89 |  €1,327.89  |
      | Pre-tax Subtotal |          |            |  €1,327.89  |
      | Total Charges    |          |            |  €1,327.89  |
    And New partner should be created


  @TC.141405_coupon_EUR5 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Annual) EUR coupon only
    When I add a new MozyPro partner:
      | company name                                             | period | base plan | create under    |country       | net terms | coupon              |
      | DONOT EDIT MozyPro 500 GB Plan (Annual) EUR coupon only new| 12    | 500 GB    |   MozyPro Ireland |Ireland      | yes       | 20PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be €1,327.89
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      |   500 GB         |    1     |  €1,327.89 |  €1,327.89  |
      | Discounts Applied|          |            | -€265.58    |
      | Pre-tax Subtotal |          |            | €1,062.31   |
      |    Taxes         |          |            |  €244.33    |
      | Total Charges    |          |            | €1,306.64   |
    And New partner should be created


  @TC.141405_coupon_GBP @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Annual) GBP VAT - coupon
    When I add a new MozyPro partner:
      | company name                                                        | period | base plan | create under  |country       | net terms | vat number  |coupon|
      | DONOT EDIT MozyPro 500 GB Plan (Annual) GBP VAT-Coupon new          | 12    | 500 GB    | MozyPro UK |United Kingdom    | yes      | GB117223643 |  100PERCENTOFFOUTLINE     |
    Then Sub-total before taxes or discounts should be £954.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            |    1     |  £954.89 |  £954.89  |
      | Discounts Applied |          |            | -£954.89  |
      | Total Charges     |          |            |    £0.00    |
    And New partner should be created


  @TC.141405_coupon_GBP1 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Annual) GBP VAT - server plan
    When I add a new MozyPro partner:
      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | vat number  |
      | DONOT EDIT MozyPro 500 GB server add-on Plan (Annual) GBP VAT new   | 12    | 500 GB    |   yes       |MozyPro UK |United Kingdom    | yes      | GB117223643 |
    Then Sub-total before taxes or discounts should be £1,056.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            |    1     |  £954.89 |  £954.89  |
      |  Server Plan      |    1     |  £101.89   |   £101.89   |
      | Pre-tax Subtotal  |          |            |	 £1,056.78  |
      | Total Charges     |          |            |  £1,056.78  |
    And New partner should be created


  @TC.141405_coupon_us11 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Biennial) USD coupon
    When I add a new MozyPro partner:
      | company name                                      | period | base plan | country      | net terms | coupon              |
      | DONOT EDIT MozyPro 500 GB Plan (Biennial) USD coupon new| 24    | 500 GB    | United States | yes      | 10PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $2,789.79
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 500 GB           | 1        | $2,789.79  | $2,789.79   |
      | Discounts Applied|          |            | -$278.98    |
      | Pre-tax Subtotal |          |            | $2,510.81   |
      | Total Charges    |          |            | $2,510.81   |
    And New partner should be created

  @TC.141405_coupon_us21 @add_new_partner @mozypro
  Scenario: MozyPro500 Server Add-on for MozyPro Plan( Biennial) USD coupon
    When I add a new MozyPro partner:
      | company name                                                            | period | base plan | server plan | country      | net terms | coupon              |
      | DONOT EDIT MozyPro 500GB Server Add-on for MozyPro Plan( Biennial) USD coupon new| 24    | 500 GB    | yes        | United States | yes      | 20PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $3,086.58
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 500 GB           |    1     |  $2,789.79 | $2,789.79   |
      | Server Plan      |    1     |  $296.79   |  $296.79    |
      | Discounts Applied|          |            |  -$617.32   |
      | Pre-tax Subtotal |          |            | $2,469.26   |
      | Total Charges    |          |            | $2,469.26   |
    And New partner should be created

  @TC.141405_coupon_us31 @add_new_partner @mozypro
  Scenario: MozyPro500 Server Add-on for MozyPro Plan( Biennial) USD coupon 100
    When I add a new MozyPro partner:
      | company name                                                                | period | base plan | server plan | country      | net terms | coupon              |
      | DONOT EDIT MozyPro500 Server Add-on for MozyPro Plan( Biennial) USD coupon 100 new| 24   | 500 GB    | yes        | United States | yes      | 100PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $3,086.58
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 500 GB           |    1     | $2,789.79  | $2,789.79   |
      | Server Plan      |    1     | $296.79    | $296.79     |
      | Discounts Applied|          |            | -$3,086.58  |
      | Total Charges    |          |            | $0.00       |
    And New partner should be created


  @TC.141405_coupon_EUR11 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Biennial) EUR coupon - VAT - server plan
    When I add a new MozyPro partner:
      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | coupon              |vat number|
      | DONOT EDIT MozyPro 500 GB server add-on Plan (Biennial) EUR coupon-VAT new| 24    | 500 GB    |    yes         |MozyPro France |France | yes      | 10PERCENTOFFOUTLINE |   FR08410091490           |
    Then Sub-total before taxes or discounts should be €2,805.58
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 500 GB           |     1    |  €2,536.79 |  €2,536.79  |
      | Server Plan      |     1    |  €268.79   |  €268.79    |
      | Discounts Applied|          |            | -€280.56    |
      | Pre-tax Subtotal |          |            | €2,525.02   |
      | Total Charges    |          |            | €2,525.02   |
    And New partner should be created

  @TC.141405_coupon_EUR21 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Biennial) EUR coupon - server plan
    When I add a new MozyPro partner:
      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | coupon              |
      | DONOT EDIT MozyPro 500 GB server add-on Plan (Biennial) EUR coupon new| 24    | 500 GB    |    yes         |MozyPro Ireland |Ireland | yes      | 20PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be €2,805.58
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 500 GB           |    1     |  €2,536.79 |  €2,536.79  |
      | Server Plan      |    1     |  €268.79   |  €268.79    |
      | Discounts Applied|          |            | -€561.12    |
      | Pre-tax Subtotal |          |            | €2,244.46   |
      |    Taxes         |          |            |  €516.23    |
      | Total Charges    |          |            | €2,760.69   |
    And New partner should be created


  @TC.141405_coupon_EUR31 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Biennial) EUR VAT - server plan
    When I add a new MozyPro partner:
      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | vat number              |
      | DONOT EDIT MozyPro 500 GB server add-on Plan (Biennial) EUR VAT new | 24    | 500 GB    |    yes         |MozyPro Germany |Germany | yes      | DE812321109 |
    Then Sub-total before taxes or discounts should be €2,805.58
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 500 GB           |    1     |  €2,536.79 |   €2,536.79 |
      | Server Plan      |    1     |  €268.79   |   €268.79   |
      | Pre-tax Subtotal |          |            | €2,805.58   |
      | Total Charges    |          |            | €2,805.58   |
    And New partner should be created


  @TC.141405_coupon_EUR41 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Biennial) EUR VAT - coupon
    When I add a new MozyPro partner:
      | company name                                                | period | base plan | create under  |country       | net terms | vat number     |coupon              |
      | DONOT EDIT MozyPro 500 GB Plan (Biennial) EUR VAT-coupon new| 24    | 500 GB    |    MozyPro Germany |Germany | yes      | DE812321109 |  10PERCENTOFFOUTLINE     |
    Then Sub-total before taxes or discounts should be €2,536.79
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 500 GB           |    1     |  €2,536.79 |   €2,536.79 |
      | Discounts Applied|          |            | -€253.68    |
      | Pre-tax Subtotal |          |            | €2,283.11   |
      | Total Charges    |          |            | €2,283.11   |
    And New partner should be created

  @TC.141405_coupon_GBP2 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Biennial) GBP VAT - coupon
    When I add a new MozyPro partner:
      | company name                                                        | period | base plan | create under  |country       | net terms | vat number  |coupon|
      | DONOT EDIT MozyPro 500 GB Plan (Biennial) GBP VAT-Coupon new        | 24    | 500 GB    | MozyPro UK |United Kingdom    | yes      | GB117223643 |  100PERCENTOFFOUTLINE     |
    Then Sub-total before taxes or discounts should be £1,823.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            |    1     | £1,823.79  |   £1,823.79 |
      | Discounts Applied |          |            |  -£1,823.79 |
      | Total Charges     |          |            |    £0.00    |
    And New partner should be created

  @TC.141405_coupon_GBP3 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Biennial) GBP  coupon- server plan
    When I add a new MozyPro partner:
      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | coupon|
      | DONOT EDIT MozyPro 500 GB server add-on Plan (Biennial) GBP Coupon new | 24    | 500 GB    | yes         |MozyPro UK |United Kingdom    | yes      | 100PERCENTOFFOUTLINE     |
    Then Sub-total before taxes or discounts should be £2,017.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            |    1     | £1,823.79  |   £1,823.79 |
      | Server Plan       |	   1	 |  £193.79   |   £193.79   |
      | Discounts Applied |          |            |  -£2,017.58 |
      | Total Charges     |          |            |    £0.00    |
    And New partner should be created



