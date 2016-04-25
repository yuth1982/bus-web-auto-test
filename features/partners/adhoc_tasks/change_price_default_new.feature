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
    Then Sub-total before taxes or discounts should be $1,399.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $1,399.79  | $1,399.79   |
      | Pre-tax Subtotal  |          |            | $1,399.79   |
      | Total Charges     |          |            | $1,399.79   |
    And New partner should be created

  @TC.141405_8 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Biennial) EUR Ireland
    When I add a new MozyPro partner:
      | company name                                          | period | base plan | create under    | country | net terms |
      | DONOT EDIT MozyPro 250 GB Plan (Biennial) EUR Ireland | 24     | 250 GB    | MozyPro Ireland | Ireland | yes       |
    Then Sub-total before taxes or discounts should be €1,272.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €1,272.79  | €1,272.79   |
      | Pre-tax Subtotal  |          |            | €1,272.79   |
      | Taxes             |          |            | €292.74     |
      | Total Charges     |          |            | €1,565.53   |
    And New partner should be created

  @TC.141405_9 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Biennial) GBP
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | create under | country        | net terms |
      | DONOT EDIT MozyPro 250 GB Plan (Biennial) GBP | 24     | 250 GB    | MozyPro UK   | United Kingdom | yes       |
    Then Sub-total before taxes or discounts should be £914.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £914.79    | £914.79     |
      | Pre-tax Subtotal  |          |            | £914.79     |
      | Taxes             |          |            | £182.96     |
      | Total Charges     |          |            | £1,097.75   |
    And New partner should be created

  @TC.141405_10 @add_new_partner @mozypro @bus
  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) USD
    When I add a new MozyPro partner:
      | company name                                                    | period | base plan | server plan | country       | net terms |
      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) USD | 24     | 250 GB    | yes         | United States | yes       |
    Then Sub-total before taxes or discounts should be $1,631.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $1,399.79  | $1,399.79   |
      | Server Plan       | 1        | $231.79    | $231.79     |
      | Pre-tax Subtotal  |          |            | $1,631.58   |
      | Total Charges     |          |            | $1,631.58   |
    And New partner should be created

  @TC.141405_11 @add_new_partner @mozypro @bus
  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) EUR Ireland
    When I add a new MozyPro partner:
      | company name                                                            | period | base plan | server plan | create under    | country | net terms |
      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) EUR Ireland | 24     | 250 GB    | yes         | MozyPro Ireland | Ireland | yes       |
    Then Sub-total before taxes or discounts should be €1,483.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €1,272.79  | €1,272.79   |
      | Server Plan       | 1        | €210.79    | €210.79     |
      | Pre-tax Subtotal  |          |            | €1,483.58   |
      | Taxes             |          |            | €341.22     |
      | Total Charges     |          |            | €1,824.80   |
    And New partner should be created

  @TC.141405_12 @add_new_partner @mozypro @bus
  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) GBP
    When I add a new MozyPro partner:
      | company name                                                    | period | base plan | server plan | create under | country        | net terms |
      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) GBP | 24     | 250 GB    | yes         | MozyPro UK   | United Kingdom | yes       |
    Then Sub-total before taxes or discounts should be £1,066.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £914.79    | £914.79     |
      | Server Plan       | 1        | £151.79    | £151.79     |
      | Pre-tax Subtotal  |          |            | £1,066.58   |
      | Taxes             |          |            | £213.32     |
      | Total Charges     |          |            | £1,279.90   |
    And New partner should be created
