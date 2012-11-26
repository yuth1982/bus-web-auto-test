Feature: Add a new user through phoenix

  As a private citizen
  I want to create a user account through phoenix
  So that I can organize my personal life in a way that works for me

  Background:
    Given I am at dom selection point:

  @TC.13462 @smoke @month
  Scenario: 13462 Add a new US monthly basic MozyHome user
    When I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          | $5.99 |          | $5.99  |
    Then the user is successfully added.

  @TC.13463 @smoke @year
  Scenario: 13463 Add a new US yearly basic MozyHome user
    When I add a phoenix Home user:
      | period | base plan | country       |
      | 12     | 50 GB     | United States |
    Then the billing summary looks like:
      | Description                           | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual  | $65.89 | 1        | $65.89 |
      | Total Charge                          | $65.89 |          | $65.89 |
    Then the user is successfully added.

  @TC.13464 @smoke @biennial
  Scenario: 13464 Add a new US biennial basic MozyHome user
    When I add a phoenix Home user:
      | period | base plan | country       |
      | 24     | 50 GB     | United States |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Total Charge                           | $125.79 |          | $125.79 |
    Then the user is successfully added.

  @TC.13468 @smoke @month @IE
  Scenario: 13468 Add a new IE monthly basic MozyHome user
    When I add a phoenix Home user:
      | period | base plan | country |
      | 1      | 50 GB     | Ireland |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | €4.99 | 1        | €4.99  |
      | Total Charge                          | €4.99 |          | €4.99  |
    Then the user is successfully added.

  @TC.13469 @smoke @year @IE
  Scenario: 13469 Add a new IE yearly basic MozyHome user
    When I add a phoenix Home user:
      | period  | base plan | country |
      | 12      | 50 GB     | Ireland |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | €54.89 | 1        | €54.89 |
      | Total Charge                         | €54.89 |          | €54.89 |
    Then the user is successfully added.

  @TC.13470 @smoke @biennial @IE
  Scenario: 13470 Add a new IE biennial basic MozyHome user
    When I add a phoenix Home user:
      | period  | base plan | country |
      | 24      | 50 GB     | Ireland |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | €104.79 | 1        | €104.79 |
      | Total Charge                           | €104.79 |          | €104.79 |
    Then the user is successfully added.

  @TC.13467 @smoke @month @UK
  Scenario: 13467 Add a new UK monthly basic MozyHome user
    When I add a phoenix Home user:
      | period | base plan | country        |
      | 1      | 50 GB     | United Kingdom |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | £4.99 | 1        | £4.99  |
      | Total Charge                          | £4.99 |          | £4.99  |
    Then the user is successfully added.

  @TC.13471 @smoke @year @UK
  Scenario: 13471 Add a new UK yearly basic MozyHome user
    When I add a phoenix Home user:
      | period | base plan | country        |
      | 12     | 50 GB     | United Kingdom |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | £54.89 | 1        | £54.89 |
      | Total Charge                         | £54.89 |          | £54.89 |
    Then the user is successfully added.

  @TC.13472 @smoke @biennial @UK
  Scenario: 13472 Add a new UK biennial basic MozyHome user
    When I add a phoenix Home user:
      | period | base plan | country        |
      | 24     | 50 GB     | United Kingdom |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | £104.79 | 1        | £104.79 |
      | Total Charge                           | £104.79 |          | £104.79 |
    Then the user is successfully added.
