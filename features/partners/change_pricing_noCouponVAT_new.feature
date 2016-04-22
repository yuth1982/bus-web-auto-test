Feature: Add a new partner

  As a Mozy Administrator
  I want to create MozyPro partners
  So that I can organize my business in a way that works for me

  Background:
    Given I log in bus admin console as administrator

  @TC.141405_19 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - US - Biennial - 500 GB - net terms
    When I add a new MozyPro partner:
      | company name                                     | period | base plan | country      | address          | city      | state abbrev | zip  | phone          |net terms |
      | DONOT EDIT MozyPro 500 GB Plan (Biennial) USD new| 24     | 500 GB    | United States | 3401 Hillview Ave | Palo Alto | CA        | 94304 | 1-877-486-9273 |yes     |
    Then Sub-total before taxes or discounts should be $2,789.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | $2,789.79  | $2,789.79  |
      | Pre-tax Subtotal  |          |            | $2,789.79  |
      | Total Charges     |          |            | $2,789.79  |
    And New partner should be created

  @TC.141405_20 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - EUR - Biennial - 500 GB - net terms
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | create under     |country | net terms|address          | city      | state abbrev | zip  | phone          |
      | DONOT EDIT MozyPro 500 GB Plan (Biennial) EUR new| 24     | 500 GB    |  MozyPro France |France |   yes    |3401 Hillview Ave | Palo Alto | CA          | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €2,536.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | €2,536.79  | €2,536.79  |
      | Pre-tax Subtotal  |          |            | €2,536.79  |
      | Taxes             |          |            | €507.36    |
      | Total Charges     |          |            | €3,044.15  |
    And New partner should be created

  @TC.141405_21 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - GBP - Biennial - 500 GB - net terms
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | create under     |country         | net terms|address          | city      | state abbrev | zip  | phone          |
      | DONOT EDIT MozyPro 500 GB Plan (Biennial) GBP new| 24     | 500 GB    |  MozyPro UK      | United Kingdom |   yes    |3401 Hillview Ave | Palo Alto | CA          | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be £1,823.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | £1,823.79  | £1,823.79  |
      | Pre-tax Subtotal  |          |            | £1,823.79  |
      | Taxes             |          |            | £364.76   |
      | Total Charges     |          |            | £2,188.55  |
    And New partner should be created


  @TC.141405_22 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - US - Biennial - 500 GB - server plan - net terms
    When I add a new MozyPro partner:
      | company name                                                | period | base plan | server plan|country      | address          | city      | state abbrev | zip  | phone          |net terms |
      | DONOT EDIT MozyPro Server add-on 500 GB Plan (Biennial) USD new| 24     | 500 GB    |  yes       |United States | 3401 Hillview Ave | Palo Alto | CA        | 94304 | 1-877-486-9273 |yes     |
    Then Sub-total before taxes or discounts should be $3,086.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | $2,789.79  | $2,789.79  |
      | Server Plan       | 1        | $296.79    | $296.79     |
      | Pre-tax Subtotal  |          |            | $3,086.58  |
      | Total Charges     |          |            | $3,086.58  |
    And New partner should be created


  @TC.141405_23 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - EUR - Biennial - 500 GB - server plan -net terms
    When I add a new MozyPro partner:
      | company name                                                | period | base plan | server plan|create under     |country | net terms|address          | city      | state abbrev | zip  | phone          |
      | DONOT EDIT MozyPro Server add-on 500 GB Plan (Biennial) EUR new| 24     | 500 GB    |   yes      |MozyPro Germany |Germany |   yes    |3401 Hillview Ave | Palo Alto | CA          | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €2,805.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | €2,536.79  | €2,536.79  |
      | Server Plan       | 1        | €268.79    | €268.79     |
      | Pre-tax Subtotal  |          |            | €2,805.58  |
      | Taxes             |          |            | €533.06    |
      | Total Charges     |          |            | €3,338.64  |
    And New partner should be created


  @TC.141405_24 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - GBP - Biennial - 500 GB - server plan -net terms
    When I add a new MozyPro partner:
      | company name                                                | period | base plan | server plan|create under     |country         | net terms|address          | city      | state abbrev | zip  | phone          |
      | DONOT EDIT MozyPro Server add-on 500 GB Plan (Biennial) GBP new| 24     | 500 GB    |  yes       |MozyPro UK      | United Kingdom |   yes    |3401 Hillview Ave | Palo Alto | CA          | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be £2,017.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | £1,823.79  | £1,823.79  |
      | Server Plan       | 1        | £193.79    | £193.79     |
      | Pre-tax Subtotal  |          |            | £2,017.58  |
      | Taxes             |          |            | £403.52   |
      | Total Charges     |          |            | £2,421.10  |
    And New partner should be created

  @TC.141405_13 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - US - Annual - 500 GB - net terms
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | country      | address          | city      | state abbrev | zip  | phone          |net terms |
      | DONOT EDIT MozyPro 500 GB Plan (Annual) USD new| 12     | 500 GB    | United States | 3401 Hillview Ave | Palo Alto | CA        | 94304 | 1-877-486-9273 |yes     |
    Then Sub-total before taxes or discounts should be $1,459.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | $1,459.89  | $1,459.89  |
      | Pre-tax Subtotal  |          |            | $1,459.89  |
      | Total Charges     |          |            | $1,459.89  |
    And New partner should be created

  @TC.141405_14 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - EUR - Annual - 500 GB - net terms
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | create under     |country | net terms|address          | city      | state abbrev | zip  | phone          |
      | DONOT EDIT MozyPro 500 GB Plan (Annual) EUR new| 12     | 500 GB    |  MozyPro Ireland |Ireland |   yes    |3401 Hillview Ave | Palo Alto | CA          | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €1,327.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | €1,327.89  | €1,327.89  |
      | Pre-tax Subtotal  |          |            | €1,327.89  |
      | Taxes             |          |            | €305.41    |
      | Total Charges     |          |            | €1,633.30  |
    And New partner should be created

  @TC.141405_15 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - GBP - Annual - 500 GB - net terms
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | create under     |country         | net terms|address          | city      | state abbrev | zip  | phone          |
      | DONOT EDIT MozyPro 500 GB Plan (Annual) GBP new| 12     | 500 GB    |  MozyPro UK      | United Kingdom |   yes    |3401 Hillview Ave | Palo Alto | CA          | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be £954.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | £954.89  | £954.89  |
      | Pre-tax Subtotal  |          |            | £954.89  |
      | Taxes             |          |            | £190.98   |
      | Total Charges     |          |            | £1,145.87 |
    And New partner should be created


  @TC.141405_16 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - US - Annual - 500 GB - server plan - net terms
    When I add a new MozyPro partner:
      | company name                                                | period | base plan | server plan|country      | address          | city      | state abbrev | zip  | phone          |net terms |
      | DONOT EDIT MozyPro Server add-on 500 GB Plan (Annual) USD new| 12     | 500 GB    |  yes       |United States | 3401 Hillview Ave | Palo Alto | CA        | 94304 | 1-877-486-9273 |yes     |
    Then Sub-total before taxes or discounts should be $1,616.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | $1,459.89  | $1,459.89  |
      | Server Plan       | 1        | $156.89    | $156.89     |
      | Pre-tax Subtotal  |          |            | $1,616.78  |
      | Total Charges     |          |            | $1,616.78  |
    And New partner should be created


  @TC.141405_17 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - EUR - Annual - 500 GB - server plan -net terms
    When I add a new MozyPro partner:
      | company name                                                | period | base plan | server plan|create under     |country | net terms|address          | city      | state abbrev | zip  | phone          |
      | DONOT EDIT MozyPro Server add-on 500 GB Plan (Annual) EUR new| 12     | 500 GB    |   yes      |MozyPro Germany |Germany |   yes    |3401 Hillview Ave | Palo Alto | CA          | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €1,469.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | €1,327.89  | €1,327.89  |
      | Server Plan       | 1        | €141.89    | €141.89    |
      | Pre-tax Subtotal  |          |            | €1,469.78  |
      | Taxes             |          |            | €279.26   |
      | Total Charges     |          |            | €1,749.04  |
    And New partner should be created


  @TC.141405_18 @add_new_partner @mozypro
  Scenario: Add New MozyPro Partner - GBP - Annual - 500 GB - server plan -net terms
    When I add a new MozyPro partner:
      | company name                                                | period | base plan | server plan|create under     |country         | net terms|address          | city      | state abbrev | zip  | phone          |
      | DONOT EDIT MozyPro Server add-on 500 GB Plan (Annual) GBP new| 12     | 500 GB    |  yes       |MozyPro UK      | United Kingdom |   yes    |3401 Hillview Ave | Palo Alto | CA          | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be £1,056.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | £954.89  | £954.89  |
      | Server Plan       | 1        | £101.89    | £101.89     |
      | Pre-tax Subtotal  |          |            | £1,056.78  |
      | Taxes             |          |            | £211.36   |
      | Total Charges     |          |            | £1,268.14  |
    And New partner should be created