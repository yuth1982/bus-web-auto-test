Feature: Add a new user through phoenix

  As a private citizen
  I want to create a user account through phoenix
  So that I can organize my personal life in a way that works for me

  Background:
  # info to be added here: coverage matrix

#---------------------------------------------------------------------------------
# precondition
# ssh root@phoenix01.qa6.mozyops.com  QAP@SSw0rd
# /var/www/phoenix/app/controllers/account_controller.rb
# /var/www/phoenix/app/controllers/registration_controller.rb
# IpCountry.country_with_ip(request.remote_ip)
# set to 'FR' if @ip_country=fr
# restart: /etc/init.d/apache2 restart
#---------------------------------------------------------------------------------

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
      | Description                             | PriX              | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Mensuel | 4,99€\n(inc. VAT) | 1        | 4,99€   |
      | Prix d'abonnement                       |                   |          | 4,16€   |
      | VAT Rate (20.0%)                        |                   |          | 0,83€   |
      | Montant total des frais                 |                   |          | 4,99€   |
    Then the user is successfully added.

  @TC.137002 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 137001 Add a new FR yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 50 Go     | France  | France          |
    Then the billing summary looks like:
      | Description                             | PriX               | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Annuel  | 54,89€\n(inc. VAT) | 1        | 54,89€  |
      | Prix d'abonnement                       |                    |          | 45,74€  |
      | VAT Rate (20.0%)                        |                    |          | 9,15€   |
      | Montant total des frais                 |                    |          | 54,89€  |
    Then the user is successfully added.

  @TC.137003 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 137003 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 24     | 50 Go     | France  | France          |
    Then the billing summary looks like:
      | Description                               | PriX                | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Bisannuel | 104,79€\n(inc. VAT) | 1        | 104,79€ |
      | Prix d'abonnement                         |                     |          | 87,32€  |
      | VAT Rate (20.0%)                          |                     |          | 17,47€  |
      | Montant total des frais                   |                     |          | 104,79€ |
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
      | Description                                       | PriX                | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Mensuel | 8,99€\n(inc. VAT) | 1          | 8,99€   |
      | Prix d'abonnement                                 |                     |          | 7,49€   |
      | VAT Rate (20.0%)                                  |                     |          | 1,50€   |
      | Montant total des frais                           |                     |          | 8,99€   |
    Then the user is successfully added.

  @TC.137005 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 137005 Add a new FR yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 Go    | France  | France          |
    Then the billing summary looks like:
      | Description                                       | PriX                | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Annuel  | 98,89€\n(inc. VAT)  | 1        | 98,89€  |
      | Prix d'abonnement                                 |                     |          | 82,41€  |
      | VAT Rate (20.0%)                                  |                     |          | 16,48€  |
      | Montant total des frais                           |                     |          | 98,89€  |
    Then the user is successfully added.

  @TC.137006 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 137006 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 24     | 125 Go    | France  | France          |
    Then the billing summary looks like:
      | Description                                          | PriX                | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Bisannuel  | 188,79€\n(inc. VAT) | 1        | 188,79€ |
      | Prix d'abonnement                                    |                     |          | 157,32€ |
      | VAT Rate (20.0%)                                     |                     |          | 31,47€  |
      | Montant total des frais                              |                     |          | 188,79€ |
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
      | Description                             | PriX                | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Mensuel | 4,99€\n(inc. VAT)   | 1        | 4,99€   |
      | 20 Stockage supplémentaire - Mensuel    | 2,00€\n(inc. VAT)   | 1        | 2,00€   |
      | Prix d'abonnement                       |                     |          | 5,82€   |
      | VAT Rate (20.0%)                        |                     |          | 1,17€   |
      | Montant total des frais                 |                     |          | 6,99€   |
    Then the user is successfully added.

  @TC.137008 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 137008 Add a new fr yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl computers |
      | 12     | 50 Go     | France  | Royaume-Uni     | 1              |
    Then the billing summary looks like:
      | Description                            | PriX               | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Annuel | 54,89€\n(inc. VAT) | 1        | 54,89€  |
      | Ordinateurs supplémentaires - Annuel   | 22,00€\n(inc. VAT) | 1        | 22,00€  |
      | Prix d'abonnement                      |                    |          | 64,07€  |
      | VAT Rate (20.0%)                       |                    |          | 12,82€  |
      | Montant total des frais                |                    |          | 76,89€  |
    Then the user is successfully added.

  @TC.137009 @BUG.128707 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk @qa6_dependent
  Scenario: 137009 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | coupon       |
      | 24     | 50 Go     | France  | Royaume-Uni     | 10percentoff |
    Then the billing summary looks like:
      | Description                               | PriX                | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Bisannuel | 104,79€\n(inc. VAT) | 1        | 104,79€ |
      | 24 mois à 10.0 % de réduction             | -10,47€\n(inc. VAT) |          | -10,47€ |
      | Prix d'abonnement                         |                     |          | 78,60€  |
      | VAT Rate (20.0%)                          |                     |          | 15,72€  |
      | Montant total des frais                   |                     |          | 94,32€  |
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
      | Description                                       | PriX              | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Mensuel | 8,99€\n(inc. VAT) | 1        | 8,99€   |
      | 20 Stockage supplémentaire - Mensuel              | 2,00€\n(inc. VAT) |   2      | 4,00€   |
      | Ordinateurs supplémentaires - Mensuel             | 2,00€\n(inc. VAT) |   2      | 4,00€   |
      | Prix d'abonnement                                 |                   |          | 14,16€  |
      | VAT Rate (20.0%)                                  |                   |          | 2,83€   |
      | Montant total des frais                           |                   |          | 16,99€  |
    Then the user is successfully added.

  @TC.137011 @BUG.128707 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk @qa6_dependent
  Scenario: 137011 Add a new FR yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl storage | coupon       |
      | 12     | 125 Go    | France  | Royaume-Uni     | 98           | 10percentoff |
    Then the billing summary looks like:
      | Description                                      | PriX                 | Quantité | Montant   |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Annuel | 98,89€\n(inc. VAT)   | 1        | 98,89€    |
      | 20 Stockage supplémentaire - Annuel              | 22,00€\n(inc. VAT)   | 98       | 2156,00€  |
      | 12 mois à 10.0 % de réduction                    | -225,48€\n(inc. VAT) |          | -225,48€  |
      | Prix d'abonnement                                |                      |          | 1691,17€ |
      | VAT Rate (20.0%)                                 |                      |          | 338,24€   |
      | Montant total des frais                          |                      |          | 2029,41€  |
    Then the user is successfully added.

  @TC.137012 @BUG.128707 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk @qa6_dependent
  Scenario: 137012 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl computers | coupon       |
      | 24     | 125 Go    | France  | Royaume-Uni     | 1              | 10percentoff |
    Then the billing summary looks like:
      | Description                                         | PriX                | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Bisannuel | 188,79€\n(inc. VAT) | 1        | 188,79€ |
      | Ordinateurs supplémentaires - Bisannuel             | 42,00€\n(inc. VAT)  | 1        | 42,00€  |
      | 24 mois à 10.0 % de réduction                       | -23,07€\n(inc. VAT) |          | -23,07€ |
      | Prix d'abonnement                                   |                     |          | 173,10€ |
      | VAT Rate (20.0%)                                    |                     |          | 34,62€  |
      | Montant total des frais                             |                     |          | 207,72€ |
    Then the user is successfully added.

  #
  # 50 Go Cases
  #
  @TC.137013 @BUG.128707 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr @qa6_dependent
  Scenario: 137013 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl storage | addl computers | coupon       |
      | 1      | 50 Go     | France  | France          | 99           | 2              | 10percentoff |
    Then the billing summary looks like:
      | Description                             | PriX                | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Mensuel | 4,99€\n(inc. VAT)   | 1        | 4,99€   |
      | 20 Stockage supplémentaire - Mensuel    | 2,00€\n(inc. VAT)   | 99       | 198,00€ |
      | Ordinateurs supplémentaires - Mensuel   | 2,00€\n(inc. VAT)   | 2        | 4,00€   |
      | 1 mois à 10.0 % de réduction            | -20,69€\n(inc. VAT) |          | -20,69€ |
      | Prix d'abonnement                       |                     |          | 155,25€ |
      | VAT Rate (20.0%)                        |                     |          | 31,05€  |
      | Montant total des frais                 |                     |          | 186,30€ |
    Then the user is successfully added.

  @TC.137014 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 137014 Add a new FR yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 50 Go     | France  | France          |
    Then the billing summary looks like:
      | Description                             | PriX               | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Annuel  | 54,89€\n(inc. VAT) | 1        | 54,89€  |
      | Prix d'abonnement                       |                    |          | 45,74€  |
      | VAT Rate (20.0%)                        |                    |          | 9,15€   |
      | Montant total des frais                 |                    |          | 54,89€  |
    Then the user is successfully added.

  @TC.137015 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 137015 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 24     | 50 Go     | France  | France          |
    Then the billing summary looks like:
      | Description                               | PriX                | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Bisannuel | 104,79€\n(inc. VAT) | 1        | 104,79€ |
      | Prix d'abonnement                         |                     |          | 87,32€  |
      | VAT Rate (20.0%)                          |                     |          | 17,47€  |
      | Montant total des frais                   |                     |          | 104,79€ |

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
      | Description                                      | PriX              | Quantité | Montant |
      |MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Mensuel | 8,99€\n(inc. VAT) | 1        | 8,99€   |
      | Prix d'abonnement                                |                   |          | 7,49€   |
      | VAT Rate (20.0%)                                 |                   |          | 1,50€   |
      | Montant total des frais                          |                   |          | 8,99€   |
    Then the user is successfully added.

  @TC.137017 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 137017 Add a new FR yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 Go    | France  | France          |
    Then the billing summary looks like:
      | Description                                      | PriX               | Quantité | Montant |
      |MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Annuel  | 98,89€\n(inc. VAT) | 1        | 98,89€  |
      | Prix d'abonnement                                |                    |          | 82,41€  |
      | VAT Rate (20.0%)                                 |                    |          | 16,48€  |
      | Montant total des frais                          |                    |          | 98,89€  |
    Then the user is successfully added.

  @TC.137018 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 137018 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 24     | 125 Go    | France  | France          |
    Then the billing summary looks like:
      | Description                                         | PriX                | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Bisannuel | 188,79€\n(inc. VAT) | 1        | 188,79€ |
      | Prix d'abonnement                                   |                     |          | 157,32€ |
      | VAT Rate (20.0%)                                    |                     |          | 31,47€  |
      | Montant total des frais                             |                     |          | 188,79€ |
    Then the user is successfully added.

  #
  # 50 Go Cases
  #
  @TC.137019 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 137019 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | coupon                  |
      | 1      | 50 Go     | France  | France          | 1dollaroffwithoutdollar |
    Then the billing summary looks like:
      | Description                             | Prix   | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Mensuel | 4,16€  | 1        |
      | Prix d'abonnement                       | 4,16€  |          |
      | 1 mois, avec 1,00€ de remise:           | -1,00€ |          |
      | Montant:                                | 3,32€  |          |
      | VAT Rate (20.0%):                       | 0,67€  |          |
      | Montant total des frais:                | 3,99€  |          |
    Then the user is successfully added.

  @TC.137020 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr @qa6_dependent
  Scenario: 137020 Add a new fr yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | coupon                  |
      | 12     | 50 Go     | France  | France          | 1dollaroffwithoutdollar |
    Then the billing summary looks like:
      | Description                             | Prix    | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Annuel  | 45,76€  | 1        |
      | Prix d'abonnement                       | 45,74€  |          |
      | 12 mois, avec 1,00€ de remise par mois: | -11,00€ |          |
      | Montant:                                | 36,57€  |          |
      | VAT Rate (20.0%):                       | 7,32€   |          |
      | Montant total des frais:                | 43,89€  |          |
    Then the user is successfully added.

  @TC.137021 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr @qa6_dependent
  Scenario: 137021 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | coupon                  |
      | 24     | 50 Go     | France  | France          | 1dollaroffwithoutdollar |
    Then the billing summary looks like:
      | Description                               | Prix    | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Bisannuel | 87,36€  | 1        |
      | Prix d'abonnement                         | 87,32€  |          |
      | 24 mois, avec 1,00€ de remise par mois:   | -21,00€ |          |
      | Montant:                                  | 69,82€  |          |
      | VAT Rate (20.0%):                         | 13,97€  |          |
      | Montant total des frais:                  | 83,79€  |          |
    Then the user is successfully added.

  #
  # 125 Go Cases
  #
  @TC.137022 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr @qa6_dependent
  Scenario: 137022 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | coupon                  |
      | 1      | 125 Go    | France  | France          | 1dollaroffwithoutdollar |
    Then the billing summary looks like:
      | Description                                       | Prix   | Quantité |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Mensuel | 7,49€  | 1        |
      | Prix d'abonnement                                 | 7,49€  |          |
      | 1 mois, avec 1,00€ de remise:                     | -1,00€ |          |
      | Montant:                                          | 6,66€  |          |
      | VAT Rate (20.0%):                                 | 1,33€  |          |
      | Montant total des frais:                          | 7,99€  |          |
    Then the user is successfully added.
