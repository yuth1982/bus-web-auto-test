Feature: Requirement #141405 Changing price schedules in Aria, and how this is reflected in BUS

  Background:
    Given I log in bus admin console as administrator

  @TC.141405_1 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Annual) USD
    When I add a new MozyPro partner:
      | company name                                | period | base plan | country       | address           | city      | state abbrev | zip   | phone          | net terms |
      | DONOT EDIT MozyPro 250 GB Plan (Annual) USD | 12     | 250 GB    | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 | yes       |
    Then Sub-total before taxes or discounts should be $729.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $729.89    | $729.89     |
      | Pre-tax Subtotal  |          |            | $729.89     |
      | Total Charges     |          |            | $729.89     |
    And New partner should be created

  @TC.141405_2 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Annual) EUR France
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | create under   | country | net terms | cc number        |
      | DONOT EDIT MozyPro 250 GB Plan (Annual) EUR France | 12     | 250 GB    | MozyPro France | France  | yes       | 4485393141463880 |
    Then Sub-total before taxes or discounts should be €663.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €663.89    | €663.89     |
      | Pre-tax Subtotal  |          |            | €663.89     |
      | Taxes             |          |            | €132.78     |
      | Total Charges     |          |            | €796.67     |
    And New partner should be created

  @TC.141405_3 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Annual) GBP
    When I add a new MozyPro partner:
      | company name                                | period | base plan | create under | country        | net terms |
      | DONOT EDIT MozyPro 250 GB Plan (Annual) GBP | 12     | 250 GB    | MozyPro UK   | United Kingdom | yes       |
    Then Sub-total before taxes or discounts should be £477.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £477.89    | £477.89     |
      | Pre-tax Subtotal  |          |            | £477.89     |
      | Taxes             |          |            | £95.58      |
      | Total Charges     |          |            | £573.47     |
    And New partner should be created

  @TC.141405_4 @add_new_partner @mozypro @bus
  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) USD
    When I add a new MozyPro partner:
      | company name                                                      | period | base plan | server plan | country       | net terms |
      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) USD | 12     | 250 GB    | yes         | United States | yes       |
    Then Sub-total before taxes or discounts should be $854.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $729.89    | $729.89     |
      | Server Plan       | 1        | $124.89    | $124.89     |
      | Pre-tax Subtotal  |          |            | $854.78     |
      | Total Charges     |          |            | $854.78     |
    And New partner should be created

  @TC.141405_5 @add_new_partner @mozypro @bus
  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) EUR Germany
    When I add a new MozyPro partner:
      | company name                                                              | period | base plan | server plan | create under    | country | net terms |
      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) EUR Germany | 12     | 250 GB    | yes         | MozyPro Germany | Germany | yes       |
    Then Sub-total before taxes or discounts should be €777.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €663.89    | €663.89     |
      | Server Plan       | 1        | €113.89    | €113.89     |
      | Pre-tax Subtotal  |          |            | €777.78     |
      | Taxes             |          |            | €147.78     |
      | Total Charges     |          |            | €925.56     |
    And New partner should be created

  @TC.141405_6 @add_new_partner @mozypro @bus
  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) GBP
    When I add a new MozyPro partner:
      | company name                                                      | period | base plan | server plan | create under | country        | net terms |
      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) GBP | 12     | 250 GB    | yes         | MozyPro UK   | United Kingdom | yes       |
    Then Sub-total before taxes or discounts should be £558.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £477.89    | £477.89     |
      | Server Plan       | 1        | £80.89     | £80.89      |
      | Pre-tax Subtotal  |          |            | £558.78     |
      | Taxes             |          |            | £111.76     |
      | Total Charges     |          |            | £670.54     |
    And New partner should be created

  @TC.141405_7 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Biennial) USD
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | country       | net terms |
      | DONOT EDIT MozyPro 250 GB Plan (Biennial) USD | 24     | 250 GB    | United States | yes       |
    Then Sub-total before taxes or discounts should be $1,396.35
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $1,396.35  | $1,396.35   |
      | Pre-tax Subtotal  |          |            | $1,396.35   |
      | Total Charges     |          |            | $1,396.35   |
    And New partner should be created

  @TC.141405_8 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Biennial) EUR Ireland
    When I add a new MozyPro partner:
      | company name                                          | period | base plan | create under    | country | net terms |
      | DONOT EDIT MozyPro 250 GB Plan (Biennial) EUR Ireland | 24     | 250 GB    | MozyPro Ireland | Ireland | yes       |
    Then Sub-total before taxes or discounts should be €1,269.41
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €1,269.41  | €1,269.41   |
      | Pre-tax Subtotal  |          |            | €1,269.41   |
      | Taxes             |          |            | €291.96     |
      | Total Charges     |          |            | €1,561.37   |
    And New partner should be created

  @TC.141405_9 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Biennial) GBP
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | create under | country        | net terms |
      | DONOT EDIT MozyPro 250 GB Plan (Biennial) GBP | 24     | 250 GB    | MozyPro UK   | United Kingdom | yes       |
    Then Sub-total before taxes or discounts should be £912.65
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £912.65    | £912.65     |
      | Pre-tax Subtotal  |          |            | £912.65     |
      | Taxes             |          |            | £182.53     |
      | Total Charges     |          |            | £1,095.18   |
    And New partner should be created

  @TC.141405_10 @add_new_partner @mozypro @bus
  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) USD
    When I add a new MozyPro partner:
      | company name                                                    | period | base plan | server plan | country       | net terms |
      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) USD | 24     | 250 GB    | yes         | United States | yes       |
    Then Sub-total before taxes or discounts should be $1,631.40
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $1,396.35  | $1,396.35   |
      | Server Plan       | 1        | $235.05    | $235.05     |
      | Pre-tax Subtotal  |          |            | $1,631.40   |
      | Total Charges     |          |            | $1,631.40   |
    And New partner should be created

  @TC.141405_11 @add_new_partner @mozypro @bus
  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) EUR Ireland
    When I add a new MozyPro partner:
      | company name                                                            | period | base plan | server plan | create under    | country | net terms |
      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) EUR Ireland | 24     | 250 GB    | yes         | MozyPro Ireland | Ireland | yes       |
    Then Sub-total before taxes or discounts should be €1,483.09
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €1,269.41  | €1,269.41   |
      | Server Plan       | 1        | €213.68    | €213.68     |
      | Pre-tax Subtotal  |          |            | €1,483.09   |
      | Taxes             |          |            | €341.11     |
      | Total Charges     |          |            | €1,824.20   |
    And New partner should be created

  @TC.141405_12 @add_new_partner @mozypro @bus
  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) GBP
    When I add a new MozyPro partner:
      | company name                                                    | period | base plan | server plan | create under | country        | net terms |
      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) GBP | 24     | 250 GB    | yes         | MozyPro UK   | United Kingdom | yes       |
    Then Sub-total before taxes or discounts should be £1,066.28
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £912.65    | £912.65     |
      | Server Plan       | 1        | £153.63    | £153.63     |
      | Pre-tax Subtotal  |          |            | £1,066.28   |
      | Taxes             |          |            | £213.26     |
      | Total Charges     |          |            | £1,279.54   |
    And New partner should be created
