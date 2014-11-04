Feature: Add a new EU mozypro partner

  As a Mozy Administrator
  I want to create MozyPro EU partners
  So that I can organize my business in a way that works for me

  Background:
    Given I log in bus admin console as administrator

  @TC.30000 @bus @2.17 @add_new_partner @mozypro
  Scenario: 30000 Add New MozyPro Partner - FR - Monthly - 2 TB - Server Plan - Net Terms - Billing Country: Canada
    When I add a new MozyPro partner:
    | period | base plan | create under   | server plan | net terms | country | billing country |  billing state abbrev  |
    | 1      | 2 TB      | MozyPro France | yes         | yes       | France  |    Canada       |     NU                 |
    Then Sub-total before taxes or discounts should be €609.98
    And Order summary table should be:
    | Description      | Quantity | Price Each | Total Price |
    | 2 TB             | 1        | €579.99    | €579.99     |
    | Server Plan      | 1        | €29.99     | €29.99      |
    | Pre-tax Subtotal |          |            | €609.98     |
    | Taxes            |          |            | €140.30     |
    | Total Charges    |          |            | €750.28     |
    And New partner should be created
    And I search and delete partner account by newly created partner company name