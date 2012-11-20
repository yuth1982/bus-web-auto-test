Feature: Add a new user through phoenix

  As a private citizen
  I want to create a user account through phoenix
  So that I can organize my personal life in a way that works for me

  Background:
    Given I wish to be a new user:

  @TC.13462 @phx_smoke @month @sample
  Scenario: 13462 Add a new US monthly basic MozyHome user
    When I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the billing summary looks like:
      | Description                   | Quantity | Price Each | Total Price |
      | 50 GB - 1 Computer - Monthly  | 1        | $xx.xx     | $xx.xx      |
      | Pre-tax Subtotal              |          |            | $xx.xx      |
      | Total Charges                 |          |            | $xx.xx      |

  @TC.13463 @phx_smoke @year
  Scenario: 13463 Add a new US yearly basic MozyHome user
    When I add a phoenix Home user:
      | period | base plan | country       |
      | 12     | 50 GB     | United States |
    Then the billing summary looks like:
      | Description                   | Quantity | Price Each | Total Price |
      | 50 GB - 1 Computer - Annually | 1        | $xx.xx     | $xx.xx      |
      | Pre-tax Subtotal              |          |            | $xx.xx      |
      | Total Charges                 |          |            | $xx.xx      |