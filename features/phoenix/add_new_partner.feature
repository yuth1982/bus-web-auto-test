Feature: Add a new partner through phoenix

  As a business owner
  I want to create a partner through phoenix
  So that I can organize my business in a way that works for me

  Background:
    Given I am at dom selection point:

  @TC.13499 @phx_smoke @sample @year
  Scenario: 13499 Add a new US yearly basic MozyPro partner
    When I add a phoenix Pro partner:
      | period | base plan | country       |
      | 12     | 100 GB    | United States |
    Then the order summary looks like:
      | Description      | Quantity | Price Each | Total Price |
      | 100 GB - Annually| 1        | $19.99     | $19.99      |
      | Pre-tax Subtotal |          |            | $19.99      |
      | Total Charges    |          |            | $19.99      |

  @TC.13502 @phx_smoke @month
  Scenario: 13502 Add a new US monthly basic MozyPro partner
    When I add a phoenix Pro partner:
      | period | base plan | country       |
      | 1      | 100 GB    | United States |
    Then the order summary looks like:
      | Description      | Quantity | Price Each | Total Price |
      | 100 GB - Monthly | 1        | $19.99     | $19.99      |
      | Pre-tax Subtotal |          |            | $19.99      |
      | Total Charges    |          |            | $19.99      |

  @TC.13498 @phx_smoke @biennial
  Scenario: 13498 Add a new US biennial basic MozyPro partner
    When I add a phoenix Pro partner:
      | period | base plan | country       |
      | 24     | 100 GB    | United States |
    Then the order summary looks like:
      | Description      | Quantity | Price Each | Total Price |
      | 100 GB - Biennial| 1        | $19.99     | $19.99      |
      | Pre-tax Subtotal |          |            | $19.99      |
      | Total Charges    |          |            | $19.99      |
