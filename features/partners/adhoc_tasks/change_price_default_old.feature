Feature: Requirement #141405 Changing price schedules in Aria, and how this is reflected in BUS

  Background:
    Given I log in bus admin console as administrator

  @TC.141405_1 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Annual) USD
    When I add a new MozyPro partner:
      | company name                                | period | base plan | country       | address           | city      | state abbrev | zip   | phone          | net terms |
      | DONOT EDIT MozyPro 250 GB Plan (Annual) USD | 12     | 250 GB    | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 | yes       |
    Then Sub-total before taxes or discounts should be $1,044.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $1,044.89  | $1,044.89   |
      | Pre-tax Subtotal  |          |            | $1,044.89   |
      | Total Charges     |          |            | $1,044.89   |
    And New partner should be created

  @TC.141405_2 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Annual) EUR France
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | create under   | country | net terms | cc number        |
      | DONOT EDIT MozyPro 250 GB Plan (Annual) EUR France | 12     | 250 GB    | MozyPro France | France  | yes       | 4485393141463880 |
    Then Sub-total before taxes or discounts should be €824.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €824.89    | €824.89     |
      | Pre-tax Subtotal  |          |            | €824.89     |
      | Taxes             |          |            | €164.98     |
      | Total Charges     |          |            | €989.87     |
    And New partner should be created

  @TC.141405_3 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Annual) GBP
    When I add a new MozyPro partner:
      | company name                                | period | base plan | create under | country        | net terms |
      | DONOT EDIT MozyPro 250 GB Plan (Annual) GBP | 12     | 250 GB    | MozyPro UK   | United Kingdom | yes       |
    Then Sub-total before taxes or discounts should be £703.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £703.89    | £703.89     |
      | Pre-tax Subtotal  |          |            | £703.89     |
      | Taxes             |          |            | £140.78     |
      | Total Charges     |          |            | £844.67     |
    And New partner should be created

  @TC.141405_4 @add_new_partner @mozypro @bus
  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) USD
    When I add a new MozyPro partner:
      | company name                                                      | period | base plan | server plan | country       | net terms |
      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) USD | 12     | 250 GB    | yes         | United States | yes       |
    Then Sub-total before taxes or discounts should be $1,220.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $1,044.89  | $1,044.89   |
      | Server Plan       | 1        | $175.89    | $175.89     |
      | Pre-tax Subtotal  |          |            | $1,220.78   |
      | Total Charges     |          |            | $1,220.78   |
    And New partner should be created

  @TC.141405_5 @add_new_partner @mozypro @bus
  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) EUR Germany
    When I add a new MozyPro partner:
      | company name                                                              | period | base plan | server plan | create under    | country | net terms |
      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) EUR Germany | 12     | 250 GB    | yes         | MozyPro Germany | Germany | yes       |
    Then Sub-total before taxes or discounts should be €967.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €824.89    | €824.89     |
      | Server Plan       | 1        | €142.89    | €142.89     |
      | Pre-tax Subtotal  |          |            | €967.78     |
      | Taxes             |          |            | €183.88     |
      | Total Charges     |          |            | €1,151.66   |
    And New partner should be created

  @TC.141405_6 @add_new_partner @mozypro @bus
  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) GBP
    When I add a new MozyPro partner:
      | company name                                                      | period | base plan | server plan | create under | country        | net terms |
      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) GBP | 12     | 250 GB    | yes         | MozyPro UK   | United Kingdom | yes       |
    Then Sub-total before taxes or discounts should be £824.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £703.89    | £703.89     |
      | Server Plan       | 1        | £120.89    | £120.89     |
      | Pre-tax Subtotal  |          |            | £824.78     |
      | Taxes             |          |            | £164.96     |
      | Total Charges     |          |            | £989.74     |
    And New partner should be created

  @TC.141405_7 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Biennial) USD
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | country       | net terms |
      | DONOT EDIT MozyPro 250 GB Plan (Biennial) USD | 24     | 250 GB    | United States | yes       |
    Then Sub-total before taxes or discounts should be $1,994.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $1,994.79  | $1,994.79   |
      | Pre-tax Subtotal  |          |            | $1,994.79   |
      | Total Charges     |          |            | $1,994.79   |
    And New partner should be created

  @TC.141405_8 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Biennial) EUR Ireland
    When I add a new MozyPro partner:
      | company name                                          | period | base plan | create under    | country | net terms |
      | DONOT EDIT MozyPro 250 GB Plan (Biennial) EUR Ireland | 24     | 250 GB    | MozyPro Ireland | Ireland | yes       |
    Then Sub-total before taxes or discounts should be €1,574.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €1,574.79  | €1,574.79   |
      | Pre-tax Subtotal  |          |            | €1,574.79   |
      | Taxes             |          |            | €362.20     |
      | Total Charges     |          |            | €1,936.99   |
    And New partner should be created

  @TC.141405_9 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Biennial) GBP
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | create under | country        | net terms |
      | DONOT EDIT MozyPro 250 GB Plan (Biennial) GBP | 24     | 250 GB    | MozyPro UK   | United Kingdom | yes       |
    Then Sub-total before taxes or discounts should be £1,343.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £1,343.79  | £1,343.79   |
      | Pre-tax Subtotal  |          |            | £1,343.79   |
      | Taxes             |          |            | £268.76     |
      | Total Charges     |          |            | £1,612.55   |
    And New partner should be created

  @TC.141405_10 @add_new_partner @mozypro @bus
  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) USD
    When I add a new MozyPro partner:
      | company name                                                    | period | base plan | server plan | country       | net terms |
      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) USD | 24     | 250 GB    | yes         | United States | yes       |
    Then Sub-total before taxes or discounts should be $2,330.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $1,994.79  | $1,994.79   |
      | Server Plan       | 1        | $335.79    | $335.79     |
      | Pre-tax Subtotal  |          |            | $2,330.58   |
      | Total Charges     |          |            | $2,330.58   |
    And New partner should be created

  @TC.141405_11 @add_new_partner @mozypro @bus
  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) EUR Ireland
    When I add a new MozyPro partner:
      | company name                                                            | period | base plan | server plan | create under    | country | net terms |
      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) EUR Ireland | 24     | 250 GB    | yes         | MozyPro Ireland | Ireland | yes       |
    Then Sub-total before taxes or discounts should be €1,847.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €1,574.79  | €1,574.79   |
      | Server Plan       | 1        | €272.79    | €272.79     |
      | Pre-tax Subtotal  |          |            | €1,847.58   |
      | Taxes             |          |            | €424.94     |
      | Total Charges     |          |            | €2,272.52   |
    And New partner should be created

  @TC.141405_12 @add_new_partner @mozypro @bus
  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) GBP
    When I add a new MozyPro partner:
      | company name                                                    | period | base plan | server plan | create under | country        | net terms |
      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) GBP | 24     | 250 GB    | yes         | MozyPro UK   | United Kingdom | yes       |
    Then Sub-total before taxes or discounts should be £1,574.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £1,343.79  | £1,343.79   |
      | Server Plan       | 1        | £230.79    | £230.79     |
      | Pre-tax Subtotal  |          |            | £1,574.58   |
      | Taxes             |          |            | £314.92     |
      | Total Charges     |          |            | £1,889.50   |
    And New partner should be created
