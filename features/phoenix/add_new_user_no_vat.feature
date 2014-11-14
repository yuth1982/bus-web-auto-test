Feature: Add a new user through phoenix

  As a private citizen
  I want to create a user account through phoenix
  So that I can organize my personal life in a way that works for me

  Background:
  # info to be added here: coverage matrix

  #
  # 50 GB Cases
  #
  @TC.130001 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 130000 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 1      | 50 GB     | United States | United States   |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          | $5.99 |          | $5.99  |
    Then the user is successfully added.

  @TC.130002 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 130001 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 12     | 50 GB     | United States | United States   |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | $65.89 | 1        | $65.89 |
      | Total Charge                         | $65.89 |          | $65.89 |
    Then the user is successfully added.

  @TC.130003 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 130003 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 24     | 50 GB     | United States | United States   |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Total Charge                           | $125.79 |          | $125.79 |
    Then the user is successfully added.

  #
  # 125 GB Cases
  #
  @TC.130004 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 130004 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 1      | 125 GB    | United States | United States   |
    Then the billing summary looks like:
      | Description                                   | Price | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99 | 1        | $9.99  |
      | Total Charge                                  | $9.99 |          | $9.99  |
    Then the user is successfully added.

  @TC.130005 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 130005 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 12     | 125 GB    | United States | United States   |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Total Charge                                 | $109.89 |          | $109.89 |
    Then the user is successfully added.

  @TC.130006 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 130006 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 24     | 125 GB    | United States | United States   |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | Total Charge                                   | $209.79 |          | $209.79 |
    Then the user is successfully added.

  #
  # 50 GB Cases
  #
  @TC.130007 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: 130007 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl storage |
      | 1      | 50 GB     | United States | United States   | 1            |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | 20 Additional Storage - Monthly       | $2.00 | 1        | $2.00  |
      | Total Charge                          | $7.99 |          | $7.99  |
    Then the user is successfully added.

  @TC.130008 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: 130008 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl computers |
      | 12     | 50 GB     | United States | United States   | 1              |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | $65.89 | 1        | $65.89 |
      | Additional Computers - Annual        | $22.00 | 1        | $22.00 |
      | Total Charge                         | $87.89 |          | $87.89 |
    Then the user is successfully added.

  @TC.130009 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us @qa6_dependent
  Scenario: 130009 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | coupon       |
      | 24     | 50 GB     | United States | United States   | 10percentoff |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Subscription Price                     | $125.79 |          | $125.79 |
      | 24 months at 10.0% off                 | $-12.57 |          | $-12.57 |
      | Total Charge                           | $113.22 |          | $113.22 |
    Then the user is successfully added.

  #
  # 125 GB Cases
  #
  @TC.130010 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: 130010 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl storage | addl computers |
      | 1      | 125 GB    | United States | United States   | 2            | 2              |
    Then the billing summary looks like:
      | Description                                   | Price  | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99  | 1        | $9.99  |
      | 20 Additional Storage - Monthly               | $2.00  | 2        | $4.00  |
      | Additional Computers - Monthly                | $2.00  | 2        | $4.00  |
      | Total Charge                                  | $17.99 |          | $17.99 |
    Then the user is successfully added.

  @TC.130011 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: 130011 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl storage |
      | 12     | 125 GB    | United States | United States   | 98           |
    Then the billing summary looks like:
      | Description                                  | Price     | Quantity | Amount    |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89   | 1        | $109.89   |
      | 20 Additional Storage - Annual               | $22.00    | 98       | $2,156.00 |
      | Total Charge                                 | $2,265.89 |          | $2,265.89 |
    Then the user is successfully added.

  @TC.130012 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: 130012 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl computers |
      | 24     | 125 GB    | United States | United States   | 1              |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | Additional Computers - Biennial                | $42.00  | 1        | $42.00  |
      | Total Charge                                   | $251.79 |          | $251.79 |
    Then the user is successfully added.

  #
  # 50 GB Cases
  #
  @TC.130013 @BUG.128707 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr
  Scenario: 130013 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl storage | addl computers | coupon       |
      | 1      | 50 GB     | United States | France          | 99           | 2              | 10percentoff |
    Then the billing summary looks like:
      | Description                           | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99   | 1        | $5.99   |
      | 20 Additional Storage - Monthly       | $2.00   | 99       | $198.00 |
      | Additional Computers - Monthly        | $2.00   | 2        | $4.00   |
      | Subscription Price                    | $207.99 |          | $207.99 |
      | 1 month at 10.0% off                  | $-20.79 |          | $-20.79 |
      | Total Charge                          | $187.20 |          | $187.20 |
    Then the user is successfully added.

  @TC.130014 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr
  Scenario: 130014 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 12     | 50 GB     | United States | France          |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | $65.89 | 1        | $65.89 |
      | Total Charge                         | $65.89 |          | $65.89 |
    Then the user is successfully added.

  @TC.130015 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr
  Scenario: 130015 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 24     | 50 GB     | United States | France          |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Total Charge                           | $125.79 |          | $125.79 |
    Then the user is successfully added.

  #
  # 125 GB Cases
  #
  @TC.130016 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr
  Scenario: 130016 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 1      | 125 GB    | United States | France          |
    Then the billing summary looks like:
      | Description                                   | Price | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99 | 1        | $9.99  |
      | Total Charge                                  | $9.99 |          | $9.99  |
    Then the user is successfully added.

  @TC.130017 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr
  Scenario: 130017 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 12     | 125 GB    | United States | France          |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Total Charge                                 | $109.89 |          | $109.89 |
    Then the user is successfully added.

  @TC.130018 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr
  Scenario: 130018 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 24     | 125 GB    | United States | France          |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | Total Charge                                   | $209.79 |          | $209.79 |
    Then the user is successfully added.

  #
  # 50 GB Cases
  #
  @TC.130019 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 130019 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 1      | 50 GB     | United States | China           |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          | $5.99 |          | $5.99  |
    Then the user is successfully added.

  @TC.130020 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 130020 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 12     | 50 GB     | United States | China           |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | $65.89 | 1        | $65.89 |
      | Total Charge                         | $65.89 |          | $65.89 |
    Then the user is successfully added.

  @TC.130021 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 130021 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 24     | 50 GB     | United States | China           |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Total Charge                           | $125.79 |          | $125.79 |
    Then the user is successfully added.

  #
  # 125 GB Cases
  #
  @TC.130022 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 130022 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 1      | 125 GB    | United States | China           |
    Then the billing summary looks like:
      | Description                                   | Price | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99 | 1        | $9.99  |
      | Total Charge                                  | $9.99 |          | $9.99  |
    Then the user is successfully added.

  @TC.130023 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 130023 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 12     | 125 GB    | United States | China           |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Total Charge                                 | $109.89 |          | $109.89 |
    Then the user is successfully added.

  @TC.130024 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 130024 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 24     | 125 GB    | United States | China           |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | Total Charge                                   | $209.79 |          | $209.79 |
    Then the user is successfully added.

  #
  # 50 GB Cases
  #
  @TC.130025 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 130025 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 1      | 50 GB     | United States | China           |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          | $5.99 |          | $5.99  |
    Then the user is successfully added.

  @TC.130026 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 130026 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 12     | 50 GB     | United States | China           |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | $65.89 | 1        | $65.89 |
      | Total Charge                         | $65.89 |          | $65.89 |
    Then the user is successfully added.

  @TC.130027 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 130027 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 24     | 50 GB     | United States | China           |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Total Charge                           | $125.79 |          | $125.79 |
    Then the user is successfully added.

  #
  # 125 GB Cases
  #
  @TC.130028 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 130028 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 1      | 125 GB    | United States | China           |
    Then the billing summary looks like:
      | Description                                   | Price | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99 | 1        | $9.99  |
      | Total Charge                                  | $9.99 |          | $9.99  |
    Then the user is successfully added.

  @TC.130029 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 130029 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 12     | 125 GB    | United States | China           |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Total Charge                                 | $109.89 |          | $109.89 |
    Then the user is successfully added.

  @TC.130030 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 130030 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 24     | 125 GB    | United States | China           |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | Total Charge                                   | $209.79 |          | $209.79 |
    Then the user is successfully added.

  #
  # 50 GB Cases
  #
  @TC.130031 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=fr
  Scenario: 130031 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 1      | 50 GB     | United States | France          |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          | $5.99 |          | $5.99  |
    Then the user is successfully added.

  @TC.130032 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=fr
  Scenario: 130032 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 12     | 50 GB     | United States | France          |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | $65.89 | 1        | $65.89 |
      | Total Charge                         | $65.89 |          | $65.89 |
    Then the user is successfully added.

  @TC.130033 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=fr
  Scenario: 130033 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 24     | 50 GB     | United States | France          |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Total Charge                           | $125.79 |          | $125.79 |
    Then the user is successfully added.

  #
  # 125 GB Cases
  #
  @TC.130034 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=fr
  Scenario: 130034 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 1      | 125 GB    | United States | France          |
    Then the billing summary looks like:
      | Description                                   | Price | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99 | 1        | $9.99  |
      | Total Charge                                  | $9.99 |          | $9.99  |
    Then the user is successfully added.

  @TC.130035 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=fr
  Scenario: 130035 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 12     | 125 GB    | United States | France          |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Total Charge                                 | $109.89 |          | $109.89 |
    Then the user is successfully added.

  @TC.130036 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=fr
  Scenario: 130036 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 24     | 125 GB    | United States | France          |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | Total Charge                                   | $209.79 |          | $209.79 |
    Then the user is successfully added.
