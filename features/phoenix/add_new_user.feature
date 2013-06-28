Feature: Add a new user through phoenix

  As a private citizen
  I want to create a user account through phoenix
  So that I can organize my personal life in a way that works for me

  Background:
    Given I am at dom selection point:

  #
  # 50 GB Cases
  #
  @TC.13462 @smoke @month @bus @regression_test @phoenix @mozyhome
  Scenario: 13462 Add a new US monthly basic MozyHome user
    When I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          | $5.99 |          | $5.99  |
    Then the user is successfully added.

  @TC.13463 @smoke @year @bus @regression_test @phoenix @mozyhome
  Scenario: 13463 Add a new US yearly basic MozyHome user
    When I add a phoenix Home user:
      | period | base plan | country       |
      | 12     | 50 GB     | United States |
    Then the billing summary looks like:
      | Description                           | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual  | $65.89 | 1        | $65.89 |
      | Total Charge                          | $65.89 |          | $65.89 |
    Then the user is successfully added.

  @TC.13464 @smoke @biennial @bus @regression_test @phoenix @mozyhome
  Scenario: 13464 Add a new US biennial basic MozyHome user
    When I add a phoenix Home user:
      | period | base plan | country       |
      | 24     | 50 GB     | United States |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Total Charge                           | $125.79 |          | $125.79 |
    Then the user is successfully added.

  @TC.13468 @smoke @month @IE @bus @regression_test @phoenix @mozyhome
  Scenario: 13468 Add a new IE monthly basic MozyHome user
    When I add a phoenix Home user:
      | period | base plan | country |
      | 1      | 50 GB     | Ireland |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | €4.99 | 1        | €4.99  |
      | Total Charge                          | €4.99 |          | €4.99  |
    Then the user is successfully added.

  @TC.13469 @smoke @year @IE @bus @regression_test @phoenix @mozyhome
  Scenario: 13469 Add a new IE yearly basic MozyHome user
    When I add a phoenix Home user:
      | period  | base plan | country |
      | 12      | 50 GB     | Ireland |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | €54.89 | 1        | €54.89 |
      | Total Charge                         | €54.89 |          | €54.89 |
    Then the user is successfully added.

  @TC.13470 @smoke @biennial @IE @bus @regression_test @phoenix @mozyhome
  Scenario: 13470 Add a new IE biennial basic MozyHome user
    When I add a phoenix Home user:
      | period  | base plan | country |
      | 24      | 50 GB     | Ireland |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | €104.79 | 1        | €104.79 |
      | Total Charge                           | €104.79 |          | €104.79 |
    Then the user is successfully added.

  @TC.13467 @smoke @month @UK @bus @regression_test @phoenix @mozyhome
  Scenario: 13467 Add a new UK monthly basic MozyHome user
    When I add a phoenix Home user:
      | period | base plan | country        |
      | 1      | 50 GB     | United Kingdom |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | £4.99 | 1        | £4.99  |
      | Total Charge                          | £4.99 |          | £4.99  |
    Then the user is successfully added.

  @TC.13471 @smoke @year @UK @bus @regression_test @phoenix @mozyhome
  Scenario: 13471 Add a new UK yearly basic MozyHome user
    When I add a phoenix Home user:
      | period | base plan | country        |
      | 12     | 50 GB     | United Kingdom |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | £54.89 | 1        | £54.89 |
      | Total Charge                         | £54.89 |          | £54.89 |
    Then the user is successfully added.

  @TC.13472 @smoke @biennial @UK @bus @regression_test @phoenix @mozyhome
  Scenario: 13472 Add a new UK biennial basic MozyHome user
    When I add a phoenix Home user:
      | period | base plan | country        |
      | 24     | 50 GB     | United Kingdom |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | £104.79 | 1        | £104.79 |
      | Total Charge                           | £104.79 |          | £104.79 |
    Then the user is successfully added.

  #
  # 125 GB Cases
  #
  @TC.13477 @smoke @month @bus @regression_test @phoenix @mozyhome
  Scenario: 13477 Add a new US monthly basic MozyHome user
    When I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 125 GB    | United States |
    Then the billing summary looks like:
      | Description                                   | Price | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99 | 1        | $9.99  |
      | Total Charge                                  | $9.99 |          | $9.99  |
    Then the user is successfully added.

  @TC.13483 @smoke @year @bus @regression_test @phoenix @mozyhome
  Scenario: 13483 Add a new US yearly basic MozyHome user
    When I add a phoenix Home user:
      | period | base plan | country       |
      | 12     | 125 GB    | United States |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Total Charge                                 | $109.89 |          | $109.89 |
    Then the user is successfully added.

  @TC.13482 @smoke @biennial @bus @regression_test @phoenix @mozyhome
  Scenario: 13482 Add a new US biennial basic MozyHome user
    When I add a phoenix Home user:
      | period | base plan | country       |
      | 24     | 125 GB    | United States |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | Total Charge                                   | $209.79 |          | $209.79 |
    Then the user is successfully added.

  @TC.13478 @smoke @month @IE @bus @regression_test @phoenix @mozyhome
  Scenario: 13478 Add a new IE monthly basic MozyHome user
    When I add a phoenix Home user:
      | period | base plan  | country |
      | 1      | 125 GB     | Ireland |
    Then the billing summary looks like:
      | Description                                   | Price | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | €8.99 | 1        | €8.99  |
      | Total Charge                                  | €8.99 |          | €8.99  |
    Then the user is successfully added.

  @TC.13485 @smoke @year @IE @bus @regression_test @phoenix @mozyhome
  Scenario: 13485 Add a new IE yearly basic MozyHome user
    When I add a phoenix Home user:
      | period  | base plan  | country |
      | 12      | 125 GB     | Ireland |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €98.89 | 1        | €98.89 |
      | Total Charge                                 | €98.89 |          | €98.89 |
    Then the user is successfully added.

  @TC.13484 @smoke @biennial @IE @bus @regression_test @phoenix @mozyhome
  Scenario: 13484 Add a new IE biennial basic MozyHome user
    When I add a phoenix Home user:
      | period  | base plan  | country |
      | 24      | 125 GB     | Ireland |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | €188.79 | 1        | €188.79 |
      | Total Charge                                   | €188.79 |          | €188.79 |
    Then the user is successfully added.

  @TC.13479 @smoke @month @UK @bus @regression_test @phoenix @mozyhome
  Scenario: 13479 Add a new UK monthly basic MozyHome user
    When I add a phoenix Home user:
      | period | base plan | country        |
      | 1      | 125 GB    | United Kingdom |
    Then the billing summary looks like:
      | Description                                   | Price | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | £7.99 | 1        | £7.99  |
      | Total Charge                                  | £7.99 |          | £7.99  |
    Then the user is successfully added.

  @TC.13487 @smoke @year @UK @bus @regression_test @phoenix @mozyhome
  Scenario: 13487 Add a new UK yearly basic MozyHome user
    When I add a phoenix Home user:
      | period | base plan | country        |
      | 12     | 125 GB    | United Kingdom |
    Then the billing summary looks like:
      | Description                                  | Price  | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Annual | £87.89 | 1        | £87.89 |
      | Total Charge                                 | £87.89 |          | £87.89 |
    Then the user is successfully added.

  @TC.13486 @smoke @biennial @UK @bus @regression_test @phoenix @mozyhome
  Scenario: 13486 Add a new UK biennial basic MozyHome user
    When I add a phoenix Home user:
      | period | base plan | country        |
      | 24     | 125 GB    | United Kingdom |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | £167.79 | 1        | £167.79 |
      | Total Charge                                   | £167.79 |          | £167.79 |
    Then the user is successfully added.
