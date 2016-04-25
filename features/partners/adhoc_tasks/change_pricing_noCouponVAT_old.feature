Feature: Add a new partner

  As a Mozy Administrator
  I want to create MozyPro partners
  So that I can organize my business in a way that works for me

  Background:
    Given I log in bus admin console as administrator

  @TC.141405_19 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - US - Biennial - 500 GB - net terms
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | country      | address          | city      | state abbrev | zip  | phone          |net terms |
      | DONOT EDIT MozyPro 500 GB Plan (Biennial) USD | 24     | 500 GB    | United States | 3401 Hillview Ave | Palo Alto | CA        | 94304 | 1-877-486-9273 |yes     |
    Then Sub-total before taxes or discounts should be $3,989.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | $3,989.79  | $3,989.79  |
      | Pre-tax Subtotal  |          |            | $3,989.79  |
      | Total Charges     |          |            | $3,989.79  |
    And New partner should be created

  @TC.141405_20 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - EUR - Biennial - 500 GB - net terms
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | create under     |country | net terms|address          | city      | state abbrev | zip  | phone          |
      | DONOT EDIT MozyPro 500 GB Plan (Biennial) EUR | 24     | 500 GB    |  MozyPro France |France |   yes    |3401 Hillview Ave | Palo Alto | CA          | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €3,149.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | €3,149.79  | €3,149.79  |
      | Pre-tax Subtotal  |          |            | €3,149.79  |
      | Taxes             |          |            | €629.96    |
      | Total Charges     |          |            | €3,779.75  |
    And New partner should be created

  @TC.141405_21 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - GBP - Biennial - 500 GB - net terms
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | create under     |country         | net terms|address          | city      | state abbrev | zip  | phone          |
      | DONOT EDIT MozyPro 500 GB Plan (Biennial) GBP | 24     | 500 GB    |  MozyPro UK      | United Kingdom |   yes    |3401 Hillview Ave | Palo Alto | CA          | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be £2,624.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | £2,624.79  | £2,624.79  |
      | Pre-tax Subtotal  |          |            | £2,624.79  |
      | Taxes             |          |            | £524.96   |
      | Total Charges     |          |            | £3,149.75  |
    And New partner should be created


  @TC.141405_22 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - US - Biennial - 500 GB - server plan - net terms
    When I add a new MozyPro partner:
      | company name                                                | period | base plan | server plan|country      | address          | city      | state abbrev | zip  | phone          |net terms |
      | DONOT EDIT MozyPro Server add-on 500 GB Plan (Biennial) USD | 24     | 500 GB    |  yes       |United States | 3401 Hillview Ave | Palo Alto | CA        | 94304 | 1-877-486-9273 |yes     |
    Then Sub-total before taxes or discounts should be $4,409.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | $3,989.79  | $3,989.79  |
      | Server Plan       | 1        | $419.79    | $419.79     |
      | Pre-tax Subtotal  |          |            | $4,409.58  |
      | Total Charges     |          |            | $4,409.58  |
    And New partner should be created


  @TC.141405_23 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - EUR - Biennial - 500 GB - server plan -net terms
    When I add a new MozyPro partner:
      | company name                                                | period | base plan | server plan|create under     |country | net terms|address          | city      | state abbrev | zip  | phone          |
      | DONOT EDIT MozyPro Server add-on 500 GB Plan (Biennial) EUR | 24     | 500 GB    |   yes      |MozyPro Germany |Germany |   yes    |3401 Hillview Ave | Palo Alto | CA          | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €3,485.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | €3,149.79  | €3,149.79  |
      | Server Plan       | 1        | €335.79    | €335.79     |
      | Pre-tax Subtotal  |          |            | €3,485.58  |
      | Taxes             |          |            | €662.26    |
      | Total Charges     |          |            | €4,147.84  |
    And New partner should be created


  @TC.141405_24 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - GBP - Biennial - 500 GB - server plan -net terms
    When I add a new MozyPro partner:
      | company name                                                | period | base plan | server plan|create under     |country         | net terms|address          | city      | state abbrev | zip  | phone          |
      | DONOT EDIT MozyPro Server add-on 500 GB Plan (Biennial) GBP | 24     | 500 GB    |  yes       |MozyPro UK      | United Kingdom |   yes    |3401 Hillview Ave | Palo Alto | CA          | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be £2,918.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | £2,624.79  | £2,624.79  |
      | Server Plan       | 1        | £293.79    | £293.79     |
      | Pre-tax Subtotal  |          |            | £2,918.58  |
      | Taxes             |          |            | £583.72   |
      | Total Charges     |          |            | £3,502.30  |
    And New partner should be created

  @TC.141405_13 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - US - Annual - 500 GB - net terms
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | country      | address          | city      | state abbrev | zip  | phone          |net terms |
      | DONOT EDIT MozyPro 500 GB Plan (Annual) USD | 12     | 500 GB    | United States | 3401 Hillview Ave | Palo Alto | CA        | 94304 | 1-877-486-9273 |yes     |
    Then Sub-total before taxes or discounts should be $2,089.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | $2,089.89  | $2,089.89  |
      | Pre-tax Subtotal  |          |            | $2,089.89  |
      | Total Charges     |          |            | $2,089.89  |
    And New partner should be created

  @TC.141405_14 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - EUR - Annual - 500 GB - net terms
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | create under     |country | net terms|address          | city      | state abbrev | zip  | phone          |
      | DONOT EDIT MozyPro 500 GB Plan (Annual) EUR | 12     | 500 GB    |  MozyPro Ireland |Ireland |   yes    |3401 Hillview Ave | Palo Alto | CA          | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €1,649.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | €1,649.89  | €1,649.89  |
      | Pre-tax Subtotal  |          |            | €1,649.89  |
      | Taxes             |          |            | €379.47    |
      | Total Charges     |          |            | €2,029.36  |
    And New partner should be created

  @TC.141405_15 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - GBP - Annual - 500 GB - net terms
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | create under     |country         | net terms|address          | city      | state abbrev | zip  | phone          |
      | DONOT EDIT MozyPro 500 GB Plan (Annual) GBP | 12     | 500 GB    |  MozyPro UK      | United Kingdom |   yes    |3401 Hillview Ave | Palo Alto | CA          | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be £1,374.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | £1,374.89  | £1,374.89  |
      | Pre-tax Subtotal  |          |            | £1,374.89  |
      | Taxes             |          |            | £274.98   |
      | Total Charges     |          |            | £1,649.87  |
    And New partner should be created


  @TC.141405_16 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - US - Annual - 500 GB - server plan - net terms
    When I add a new MozyPro partner:
      | company name                                                | period | base plan | server plan|country      | address          | city      | state abbrev | zip  | phone          |net terms |
      | DONOT EDIT MozyPro Server add-on 500 GB Plan (Annual) USD | 12     | 500 GB    |  yes       |United States | 3401 Hillview Ave | Palo Alto | CA        | 94304 | 1-877-486-9273 |yes     |
    Then Sub-total before taxes or discounts should be $2,309.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | $2,089.89  | $2,089.89  |
      | Server Plan       | 1        | $219.89    | $219.89     |
      | Pre-tax Subtotal  |          |            | $2,309.78  |
      | Total Charges     |          |            | $2,309.78  |
    And New partner should be created


  @TC.141405_17 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - EUR - Annual - 500 GB - server plan -net terms
    When I add a new MozyPro partner:
      | company name                                                | period | base plan | server plan|create under     |country | net terms|address          | city      | state abbrev | zip  | phone          |
      | DONOT EDIT MozyPro Server add-on 500 GB Plan (Annual) EUR | 12     | 500 GB    |   yes      |MozyPro Germany |Germany |   yes    |3401 Hillview Ave | Palo Alto | CA          | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €1,825.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | €1,649.89  | €1,649.89  |
      | Server Plan       | 1        | €175.89    | €175.89     |
      | Pre-tax Subtotal  |          |            | €1,825.78  |
      | Taxes             |          |            | €346.90   |
      | Total Charges     |          |            | €2,172.68  |
    And New partner should be created


  @TC.141405_18 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - GBP - Annual - 500 GB - server plan -net terms
    When I add a new MozyPro partner:
      | company name                                                | period | base plan | server plan|create under     |country         | net terms|address          | city      | state abbrev | zip  | phone          |
      | DONOT EDIT MozyPro Server add-on 500 GB Plan (Annual) GBP | 12     | 500 GB    |  yes       |MozyPro UK      | United Kingdom |   yes    |3401 Hillview Ave | Palo Alto | CA          | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be £1,528.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | £1,374.89  | £1,374.89  |
      | Server Plan       | 1        | £153.89    | £153.89     |
      | Pre-tax Subtotal  |          |            | £1,528.78  |
      | Taxes             |          |            | £305.76   |
      | Total Charges     |          |            | £1,834.54  |
    And New partner should be created
