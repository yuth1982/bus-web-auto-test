Feature: Add a new user through phoenix

  As a private citizen
  I want to create a user account through phoenix
  So that I can organize my personal life in a way that works for me

  Background:
  # info to be added here: coverage matrix

  #
  # 50 Go Cases
  #
  @TC.137001 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 137001 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 1      | 50 Go     | France  | France          |
    Then the billing summary looks like:
      | Description                             | Prix  | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Mensuel | 4,16€ | 1        |
      | Montant:                                | 4,16€ |          |
      | VAT Rate (20.0%):                       | 0,83€ |          |
      | Montant total des frais:                | 4,99€ |          |
    Then the user is successfully added.

  @TC.137002 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 137001 Add a new FR yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 50 Go     | France  | France          |
    Then the billing summary looks like:
      | Description                            | Prix   | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Annuel | 45,74€ | 1        |
      | Montant:                               | 45,74€ |          |
      | VAT Rate (20.0%):                      | 9,15€  |          |
      | Montant total des frais:               | 54,89€ |          |
    Then the user is successfully added.

  @TC.137003 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 137003 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 24     | 50 Go     | France  | France          |
    Then the billing summary looks like:
      | Description                               | Prix    | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Bisannuel | 87,32€  | 1        |
      | Montant:                                  | 87,32€  |          |
      | VAT Rate (20.0%):                         | 17,47€  |          |
      | Montant total des frais:                  | 104,79€ |          |
    Then the user is successfully added.

  #
  # 125 Go Cases
  #
  @TC.137004 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 137004 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 1      | 125 Go    | France  | France          |
    Then the billing summary looks like:
      | Description                                       | Prix  | Quantité |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Mensuel | 7,49€ | 1        |
      | Montant:                                          | 7,49€ |          |
      | VAT Rate (20.0%):                                 | 1,50€ |          |
      | Montant total des frais:                          | 8,99€ |          |
    Then the user is successfully added.

  @TC.137005 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 137005 Add a new FR yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 Go    | France  | France          |
    Then the billing summary looks like:
      | Description                                      | Prix   | Quantité |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Annuel | 82,41€ | 1        |
      | Montant:                                         | 82,41€ |          |
      | VAT Rate (20.0%):                                | 16,48€ |          |
      | Montant total des frais:                         | 98,89€ |          |
    Then the user is successfully added.

  @TC.137006 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 137006 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 24     | 125 Go    | France  | France          |
    Then the billing summary looks like:
      | Description                                         | Prix    | Quantité |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Bisannuel | 157,32€ | 1        |
      | Montant:                                            | 157,32€ |          |
      | VAT Rate (20.0%):                                   | 31,47€  |          |
      | Montant total des frais:                            | 188,79€ |          |
    Then the user is successfully added.

  #
  # 50 Go Cases
  #
  @TC.137007 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 137007 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl storage |
      | 1      | 50 Go     | France  | Royaume-Uni     | 1            |
    Then the billing summary looks like:
      | Description                             | Prix  | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Mensuel | 4,16€ | 1        |
      | 20 Stockage supplémentaire - Mensuel    | 1,67€ | 1        |
      | Montant:                                | 5,82€ |          |
      | VAT Rate (20.0%):                       | 1,17€ |          |
      | Montant total des frais:                | 6,99€ |          |
    Then the user is successfully added.

  @TC.137008 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 137008 Add a new fr yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl computers |
      | 12     | 50 Go     | France  | Royaume-Uni     | 1              |
    Then the billing summary looks like:
      | Description                            | Prix   | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Annuel | 45,74€ | 1        |
      | Ordinateurs supplémentaires - Annuel   | 18,37€ | 1        |
      | Montant:                               | 64,07€ |          |
      | VAT Rate (20.0%):                      | 12,82€ |          |
      | Montant total des frais:               | 76,89€ |          |
    Then the user is successfully added.

  @TC.137009 @BUG.128707 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk @qa6_dependent
  Scenario: 137009 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | coupon       |
      | 24     | 50 Go     | France  | Royaume-Uni     | 10percentoff |
    Then the billing summary looks like:
      | Description                               | Prix   | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Bisannuel | 87,32€ | 1        |
      | Prix d'abonnement                         | 87,32€ |          |
      | 24 mois à 10.0 % de réduction:            | -8,72€ |          |
      | Montant:                                  | 78,60€ |          |
      | VAT Rate (20.0%):                         | 15,72€ |          |
      | Montant total des frais:                  | 94,32€ |          |
    Then the user is successfully added.

  #
  # 125 Go Cases
  #
  @TC.137010 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 137010 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl storage | addl computers |
      | 1      | 125 Go    | France  | Royaume-Uni     | 2            | 2              |
    Then the billing summary looks like:
      | Description                                       | Prix   | Quantité |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Mensuel | 7,49€  | 1        |
      | 20 Stockage supplémentaire - Mensuel              | 1,67€  | 2        |
      | Ordinateurs supplémentaires - Mensuel             | 1,67€  | 2        |
      | Montant:                                          | 14,16€ |          |
      | VAT Rate (20.0%):                                 | 2,83€  |          |
      | Montant total des frais:                          | 16,99€ |          |
    Then the user is successfully added.

  @TC.137011 @BUG.128707 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 137011 Add a new FR yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl storage | coupon       |
      | 12     | 125 Go    | France  | Royaume-Uni     | 98           | 10percentoff |
    Then the billing summary looks like:
      | Description                                      | Prix      | Quantité |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Annuel | 82,41€    | 1        |
      | 20 Stockage supplémentaire - Annuel              | 18,37€    | 98       |
      | Prix d'abonnement                                | 1 879,07€ |          |
      | 24 mois à 10.0 % de réduction:                   | -187,90€  |          |
      | Montant:                                         | 1 691,17€ |          |
      | VAT Rate (20.0%):                                | 338,24€   |          |
      | Montant total des frais:                         | 2 029,41€ |          |
    Then the user is successfully added.

  @TC.137012 @BUG.128707 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 137012 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl computers | coupon       |
      | 24     | 125 Go    | France  | Royaume-Uni     | 1              | 10percentoff |
    Then the billing summary looks like:
      | Description                                         | Prix    | Quantité |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Bisannuel | 157,32€ | 1        |
      | Ordinateurs supplémentaires - Bisannuel             | 35,07€  | 1        |
      | Prix d'abonnement                                   | 192,32€ |          |
      | 24 mois à 10.0 % de réduction:                      | -19,22€ |          |
      | Montant:                                            | 173,10€ |          |
      | VAT Rate (20.0%):                                   | 34,62€  |          |
      | Montant total des frais:                            | 207,72€ |          |
    Then the user is successfully added.

  #
  # 50 Go Cases
  #
  @TC.137013 @BUG.128707 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 137013 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl storage | addl computers | coupon       |
      | 1      | 50 Go     | France  | France          | 99           | 2              | 10percentoff |
    Then the billing summary looks like:
      | Description                             | Prix    | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Mensuel | 4,16€   | 1        |
      | 20 Stockage supplémentaire - Mensuel    | 1,67€   | 99       |
      | Ordinateurs supplémentaires - Mensuel   | 1,67€   | 2        |
      | Prix d'abonnement                       | 172,49€ |          |
      | 24 mois à 10.0 % de réduction:          | -17,24€ |          |
      | Montant:                                | 155,25€ |          |
      | VAT Rate (20.0%):                       | 31,05€  |          |
      | Montant total des frais:                | 186,30€ |          |
    Then the user is successfully added.

  @TC.137014 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 137014 Add a new FR yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 50 Go     | France  | France          |
    Then the billing summary looks like:
      | Description                            | Prix   | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Annuel | 45,74€ | 1        |
      | Montant:                               | 45,74€ |          |
      | VAT Rate (20.0%):                      | 9,15€  |          |
      | Montant total des frais:               | 54,89€ |          |
    Then the user is successfully added.

  @TC.137015 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 137015 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 24     | 50 Go     | France  | France          |
    Then the billing summary looks like:
      | Description                               | Prix    | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Bisannuel | 87,32€  | 1        |
      | Montant:                                  | 87,32€  |          |
      | VAT Rate (20.0%):                         | 17,47€  |          |
      | Montant total des frais:                  | 104,79€ |          |

  #
  # 125 Go Cases
  #
  @TC.137016 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 137016 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 1      | 125 Go    | France  | France          |
    Then the billing summary looks like:
      | Description                                       | Prix  | Quantité |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Mensuel | 7,49€ | 1        |
      | Montant:                                          | 7,49€ |          |
      | VAT Rate (20.0%):                                 | 1,50€ |          |
      | Montant total des frais:                          | 8,99€ |          |
    Then the user is successfully added.

  @TC.137017 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 137017 Add a new FR yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 Go    | France  | France          |
    Then the billing summary looks like:
      | Description                                      | Prix   | Quantité |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Annuel | 82,41€ | 1        |
      | Montant:                                         | 82,41€ |          |
      | VAT Rate (20.0%):                                | 16,48€ |          |
      | Montant total des frais:                         | 98,89€ |          |
    Then the user is successfully added.

  @TC.137018 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 137018 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 24     | 125 Go    | France  | France          |
    Then the billing summary looks like:
      | Description                                         | Prix    | Quantité |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Bisannuel | 157,32€ | 1        |
      | Montant:                                            | 157,32€ |          |
      | VAT Rate (20.0%):                                   | 31,47€  |          |
      | Montant total des frais:                            | 188,79€ |          |
    Then the user is successfully added.
