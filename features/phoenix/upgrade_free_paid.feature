Feature: MozyHome user upgrades from free to paid through phoenix

  As a MozyHome free user
  I want to upgrade from free to paid
  So that I can have more storage and computers for backup

  Background:
   Given I am at dom selection point:

  #
  # FR VAT applied
  #
  @TC.1 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: TC.1 Upgrade FR MozyHome free user to paid with 50 GB Monthly additional storage
    When I add a phoenix Free user:
      | base plan | country |
      | free      | France  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | billing country |
      | 1       | 50 Go     | 1            | France          |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                             | Prix  | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Mensuel | 4,16€ | 1        |
      | 20 Stockage supplémentaire - Mensuel    | 1,67€ | 1        |
      | Montant:                                | 5,82€ |          |
      | VAT Rate (20.0%):                       | 1,17€ |          |
      | Montant total des frais:                | 6,99€ |          |
    And the current plan summary looks like:
      | Plan de base :                     | MozyHome 50 Go    |
      | Espace de stockage supplémentaire :| 20 Go             |
      | Ordinateurs :                      | 1                 |
      | Abonnement :                       | Mensuel           |
      | Prochaine facture :                | @1 month from now |
      | Montant:                           | 5,82€             |
      | VAT Rate (20.0%):                  | 1,17€             |
      | Total :                            | 6,99€             |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.2 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: TC.2 Upgrade FR MozyHome free user to paid with 50 GB Yearly
    When I add a phoenix Free user:
      | base plan | country |
      | free      | France  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | billing country |
      | 12      | 50 Go     | France          |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                            | Prix   | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Annuel | 45,76€ | 1        |
      | Montant:                               | 45,74€ |          |
      | VAT Rate (20.0%):                      | 9,15€  |          |
      | Montant total des frais:               | 54,89€ |          |
    And the current plan summary looks like:
      | Plan de base :                     | MozyHome 50 Go   |
      | Espace de stockage supplémentaire :| 0 Go             |
      | Ordinateurs :                      | 1                |
      | Abonnement :                       | Annuel           |
      | Remise : 	                       | 1 mois gratuit   |
      | Prochaine facture :                | @1 year from now |
      | Montant:                           | 45,74€           |
      | VAT Rate (20.0%):                  | 9,15€            |
      | Total :                            | 54,89€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.3 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: TC.3 Upgrade FR MozyHome free user to paid with 125 GB Biennial additional computers
    When I add a phoenix Free user:
      | base plan | country |
      | free      | France  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl computers | billing country |
      | 24      | 125 Go    | 2              | France          |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                         | Prix    | Quantité |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Bisannuel | 157,29€ | 1        |
      | Ordinateurs supplémentaires - Bisannuel             | 35,07€  | 2        |
      | Montant:                                            | 227,32€ |          |
      | VAT Rate (20.0%):                                   | 45,47€  |          |
      | Montant total des frais:                            | 272,79€ |          |
    And the current plan summary looks like:
      | Plan de base :                     | MozyHome 125 Go   |
      | Espace de stockage supplémentaire :| 0 Go              |
      | Ordinateurs :                      | 5                 |
      | Abonnement :                       | Bisannuel         |
      | Remise : 	                       | 3 mois gratuits   |
      | Prochaine facture :                | @2 years from now |
      | Montant:                           | 227,32€           |
      | VAT Rate (20.0%):                  | 45,47€            |
      | Total :                            | 272,79€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.4 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk @qa6_dependent @BUG.128707
  Scenario: TC.4 Upgrade FR MozyHome free user to paid with 50 GB Yearly additional storage promotional code
    When I add a phoenix Free user:
      | base plan | country |
      | free      | France  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | coupon       | billing country |
      | 12      | 50 Go     |  10          | 10percentoff | Royaume-Uni     |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                             | Prix    | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Annuel  | 45,76€  | 1        |
      | 20 Stockage supplémentaire - Annuel     | 18,37€  | 10       |
      | Prix d'abonnement                       | 229,07€ |          |
      | 24 mois à 10.0 % de réduction:          | -22,90€ |          |
      | Montant:                                | 206,17€ |          |
      | VAT Rate (20.0%):                       | 41,24€  |          |
      | Montant total des frais:                | 247,41€ |          |
    And the current plan summary looks like:
      | Plan de base :                     | MozyHome 50 Go   |
      | Espace de stockage supplémentaire :| 200 Go           |
      | Ordinateurs :                      | 1                |
      | Abonnement :                       | Annuel           |
      | Remise : 	                       | 1 mois gratuit   |
      | Prochaine facture :                | @1 year from now |
      | Montant:                           | 229,07€          |
      | VAT Rate (20.0%):                  | 45,82€           |
      | Total :                            | 274,89€          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.5 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: TC.5 Upgrade FR MozyHome free user to paid with 50 GB Biennial
    When I add a phoenix Free user:
      | base plan | country |
      | free      | France  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | billing country |
      | 24      | 50 Go     | Royaume-Uni     |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                | Prix    | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Bisannuel  | 87,32€  | 1        |
      | Montant:                                   | 87,32€  |          |
      | VAT Rate (20.0%):                          | 17,47€  |          |
      | Montant total des frais:                   | 104,79€ |          |
    And the current plan summary looks like:
      | Plan de base :                     | MozyHome 50 Go    |
      | Espace de stockage supplémentaire :| 0 Go              |
      | Ordinateurs :                      | 1                 |
      | Abonnement :                       | Bisannuel         |
      | Remise : 	                       | 3 mois gratuits   |
      | Prochaine facture :                | @2 years from now |
      | Montant:                           | 87,32€            |
      | VAT Rate (20.0%):                  | 17,47€            |
      | Total :                            | 104,79€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.6 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: Upgrade FR MozyHome free user to paid with 125 GB Monthly additional Storage computers
    When I add a phoenix Free user:
      | base plan | country |
      | free      | France  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | addl computers | billing country |
      | 1       | 125 Go    | 1            | 1              | Royaume-Uni     |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                       | Prix    | Quantité |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Mensuel | 7,49€   | 1        |
      | 20 Stockage supplémentaire - Mensuel              | 1,67€   | 1        |
      | Ordinateurs supplémentaires - Mensuel             | 1,67€   | 1        |
      | Montant:                                          | 227,32€ |          |
      | VAT Rate (20.0%):                                 | 45,47€  |          |
      | Montant total des frais:                          | 272,79€ |          |
    And the current plan summary looks like:
      | Plan de base :                     | MozyHome 125 Go   |
      | Espace de stockage supplémentaire :| 20 Go             |
      | Ordinateurs :                      | 4                 |
      | Abonnement :                       | Mensuel           |
      | Prochaine facture :                | @1 month from now |
      | Montant:                           | 227,32€           |
      | VAT Rate (20.0%):                  | 45,47€            |
      | Total :                            | 272,79€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.7 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: TC.7 Upgrade FR MozyHome free user to paid with 50 GB Biennial additional computers
    When I add a phoenix Free user:
      | base plan | country |
      | free      | France  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl computers | billing country |
      | 24      | 50 Go     |  4             | France          |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                | Prix    | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Bisannuel  | 104,79€ | 1        | 104,79€ |
      | Ordinateurs supplémentaires - Bisannuel    | 42,00€  | 4        | 168,00€ |
      | Montant total des frais                    | 272,79€ |          | 272,79€ |
    And the current plan summary looks like:
      | Plan de base :                     | MozyHome 50 Go    |
      | Espace de stockage supplémentaire :| 0 Go              |
      | Ordinateurs :                      | 5                 |
      | Abonnement :                       | Bisannuel         |
      | Remise : 	                       | 3 mois gratuits   |
      | Prochaine facture :                | @2 years from now |
      | Total :                            | 104,79€           |
      | Montant:                           | 272,79€           |
      | VAT Rate (20.0%):                  | 54,56€            |
      | Montant total des frais:           | 327,35€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.8 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: Upgrade FR MozyHome free user to paid with 125 GB Monthly
    When I add a phoenix Free user:
      | base plan | country |
      | free      | France  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | billing country |
      | 1       |  125 Go   | France          |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                       | Prix  | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Mensuel | 8,99€ | 1        | 8,99€   |
      | Montant total des frais                           | 8,99€ |          | 8,99€   |
    And the current plan summary looks like:
      | Plan de base :                     | MozyHome 125 Go   |
      | Espace de stockage supplémentaire :| 0 Go              |
      | Ordinateurs :                      | 3                 |
      | Abonnement :                       | Mensuel           |
      | Prochaine facture :                | @1 month from now |
      | Total :                            | 8,99€             |
      | Montant:                           | 272,79€           |
      | VAT Rate (20.0%):                  | 54,56€            |
      | Montant total des frais:           | 327,35€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

    @TC.9 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr @qa6_dependent
    Scenario: TC.9 Upgrade FR MozyHome free user to paid with 125 GB Yearly additional Storage computers promotional code
      When I add a phoenix Free user:
        | base plan | country |
        | free      | France  |
      Then the user is successfully added.
      And the user has activated their account
      And I login as the user on the account.
      And I upgrade my free account to:
        | period  | base plan | addl storage | addl computers | coupon       | billing country |
        | 12      | 125 Go    | 5            | 2              | 10percentoff | France          |
      Then upgrade from free to paid will be successful
      Then the billing summary looks like:
        | Description                                      | Prix    | Quantité |
        | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Annuel | 98,89€  | 1        |
        | 20 Stockage supplémentaire - Annuel              | 22,00€  | 5        |
        | Ordinateurs supplémentaires - Annuel             | 22,00€  | 2        |
        | Prix d'abonnement                                | 252,89€ |          |
        | 24 mois à 10.0 % de réduction                    | -50,57€ |          |
        | Montant total des frais                          | 202,32€ |          |
        | Montant:                           | 252,89€          |
        | VAT Rate (20.0%):                  | 50,58€           |
        | Montant total des frais:           | 303,47€          |
      And the current plan summary looks like:
        | Plan de base :                     | MozyHome 125 Go  |
        | Espace de stockage supplémentaire :| 100 Go           |
        | Ordinateurs :                      | 5                |
        | Abonnement :                       | Annuel           |
        | Remise : 	                         | 1 mois gratuit   |
        | Prochaine facture :                | @1 year from now |
        | Montant:                           | 252,89€          |
        | VAT Rate (20.0%):                  | 50,58€           |
        | Montant total des frais:           | 303,47€          |
      And the renewal plan summary is Same as current plan
      And I log in bus admin console as administrator
      And I search user by:
        | keywords       |
        | @mh_user_email |
      And I view user details by newly created MozyHome username
      And I delete user

  @TC.10 @phoenix @mozyhome @profile_country=de @ip_country=de @billing_country=de
  Scenario: TC.10 Upgrade DE MozyHome free user to paid with 50GB Yearly additional computers
    When I add a phoenix Free user:
      | base plan | country |
      | free      | Germany |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl computers | billing country |
      | 12      | 50 GB     | 2              | Deutschland     |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Beschreibung                           | Preis  | Menge | Betrag |
      | MozyHome 50 GB (1 Computer) - jährlich | 54,89€ | 1     | 54,89€ |
      | Zusätzliche Computer - jährlich        | 22,00€ | 2     | 44,00€ |
      | Gesamtbelastung                        | 98,89€ |       | 98,89€ |
    And the current plan summary looks like:
      | Basistarif: 	            | MozyHome 50 GB   |
      | Zusätzlicher Speicherplatz: | 0 GB             |
      | Computer:                   | 3                |
      | Abonnement: 	            | Jährlich         |
      | Laufzeit Rabatt: 	        | 1 Monat gratis   |
      | Nächste Rechnungsstellung:  | @1 year from now |
      | Gesamt: 	                | 98,89€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.11 @phoenix @mozyhome @profile_country=ie @ip_country=ie @billing_country=us
  Scenario: TC.11 Upgrade IE MozyHome free user to paid with 50 GB Monthly
    When I add a phoenix Free user:
      | base plan | country |
      | free      | Ireland |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | billing country |
      | 1       | 50 GB     | United States   |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                           | Price | Quantity |
      | MozyHome 50 GB (1 computer) - Monthly | €4.99 | 1        |
      | Amount:                               | €4.99 |          |
      | VAT Rate (23.0%):                     | €1.15 |          |
      | Total Charge:                         | €6.14 |          |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 50 GB    |
      | Additional Storage: | 0 GB              |
      | Computers:          | 1                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Amount:             | €4.99             |
      | VAT Rate (23.0%):   | €1.15             |
      | Total Charge:       | €6.14             |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.12 @phoenix @mozyhome @profile_country=uk @ip_country=de @billing_country=uk
  Scenario: TC.12 Upgrade UK MozyHome free user to paid with 125 GB Yearly additional storage computers
    When I add a phoenix Free user:
      | base plan | country        |
      | free      | United Kingdom |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | addl computers | billing country |
      | 12      | 125 GB    | 2            | 2              | United Kingdom  |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity |
      | MozyHome 125 GB (Up to 3 computers) - Annual | £87.89  | 1        |
      | 20 Additional Storage - Annual               | £19.25  | 2        |
      | Additional Computers - Annual                | £19.25  | 2        |
      | Amount:                                      | £164.89 |          |
      | VAT Rate (20.0%):                            | £32.98  |          |
      | Total Charge:                                | £197.87 |          |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 40 GB            |
      | Computers:          | 5                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Amount:             | £164.89          |
      | VAT Rate (20.0%):   | £32.98           |
      | Total Charge:       | £197.87          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # VAT not applicable
  #
  @TC.13 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: TC.13 Upgrade UK MozyHome free user to paid with 50GB Two Year additional Storage
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | billing country |
      | 24      | 50 GB     | 5            | United States   |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | 20 Additional Storage - Biennial       | $42.00  | 5        | $210.00 |
      | Total Charge                           | $335.79 |          | $335.79 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 50 GB    |
      | Additional Storage: | 100 GB            |
      | Computers:          | 1                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Next Billing:       | @2 years from now |
      | Total:              | $335.79           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.14 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: Upgrade UK MozyHome free user to paid with 125GB Monthly promotional code
    When I add a phoenix Free user:                                                              F
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | coupon       | billing country |
      | 1       | 125 GB    | 10percentoff | United States   |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                   | Price  | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99  | 1        | $9.99  |
      | Subscription Price                            | $9.99  |          | $9.99  |
      | 24 months at 20.0% off                        | $-1.99 |          | $-1.99 |
      |Total Charge                                   | $8.00  |          | $8.00  |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 0 GB              |
      | Computers:          | 3                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $9.99             |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.15 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: Upgrade UK MozyHome free user to paid with 125 GB Yearly additional computers
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl computers | billing country |
      | 12      | 125 GB    | 2              | United States   |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Additional Computers - Annual                | $22.00  | 2        | $44.00  |
      | Total Charge                                 | $153.89 |          | $153.89 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 0 GB             |
      | Computers:          | 5                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $153.89          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.16 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: Upgrade UK MozyHome free user to paid with 50 GB Monthly additional storage
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | billing country |
      | 1       | 50 GB     | 2            | United States   |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                            | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly  | $5.99 | 1        | $5.99  |
      | 20 Additional Storage - Monthly        | $2.00 | 2        | $4.00  |
      | Total Charge                           | $9.99 |          | $9.99  |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 50 GB    |
      | Additional Storage: | 40 GB             |
      | Computers:          | 1                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $9.99             |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.17 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: Upgrade UK MozyHome free user to paid with 125 GB Yearly
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | billing country |
      | 12      | 125 GB    | United States   |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Total Charge                                 | $109.89 |          | $109.89 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 0 GB             |
      | Computers:          | 3                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $109.89          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.18 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: Upgrade UK MozyHome free user to paid with 125 GB Two Year additional storage computers
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | addl computers | billing country |
      | 24      | 125 GB    | 3            | 1              | United States   |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | 20 Additional Storage - Biennial               | $42.00  | 3        | $126.00 |
      | Additional Computers - Biennial                | $42.00  | 1        | $42.00  |
      | Total Charge                                   | $377.79 |          | $377.79 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 60 GB             |
      | Computers:          | 4                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Next Billing:       | @2 years from now |
      | Total:              | $377.79           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.19 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr @qa6_dependent
  Scenario: Upgrade UK MozyHome free user to paid with 50 GB Yearly additional computer promotional code
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl computers | coupon       | billing country |
      | 12      | 50 GB     | 3              | 10percentoff | France          |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                          | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Annual | $65.89  | 1        | $65.89  |
      | Additional Computers - Annual        | $22.00  | 3        | $66.00  |
      | Subscription Price                   | $131.89 |          | $131.89 |
      | 24 months at 10.0% off               | $-26.38 |          | $-26.38 |
      | Total Charge                         | $83.51  |          | $83.51  |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 GB             |
      | Computers:          | 4                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $83.51           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.20 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr
  Scenario: Upgrade UK MozyHome free user to paid with 125 GB Monthly additional storage computers
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | addl computers | billing country |
      | 1       | 125 GB    | 30           | 2              | France          |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                   | Price  | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99  | 1        | $9.99  |
      | 20 Additional Storage - Monthly               | $2.00  | 30       | $60.00 |
      | Additional Computers - Monthly                | $2.00  | 2        | $4.00  |
      | Total Charge                                  | $73.99 |          | $73.99 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 600 GB            |
      | Computers:          | 5                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $73.99            |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.21 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr
  Scenario: Upgrade UK MozyHome free user to paid with 125 GB Two Year
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | billing country |
      | 24      | 125 GB    | France          |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | Total Charge                                   | $209.79 |          | $209.79 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 0 GB              |
      | Computers:          | 3                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Next Billing:       | @2 years from now |
      | Total:              | $209.79           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.22 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn @qa6_dependent
  Scenario: Upgrade UK MozyHome free user to paid with 50 GB Monthly additional Storage promotional code
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | billing country | coupon       |
      | 1       | 50 GB     | 1            | China           | 10percentoff |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                            | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly  | $5.99  | 1        | $5.99  |
      | 20 Additional Storage - Monthly        | $2.00  | 1        | $2.00  |
      | 24 months at 10.0% off                 | $-0.80 |          | $-0.80 |
      | Total Charge                           | $7.19  |          | $7.19  |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 50 GB    |
      | Additional Storage: | 20 GB             |
      | Computers:          | 1                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $7.19             |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

@TC.23 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
 Scenario: Upgrade UK MozyHome free user to paid with 50 GB Yearly additional computer us jp cn
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl computers | billing country |
      | 12      | 50 GB     | 4              | China           |
   Then upgrade from free to paid will be successful
   Then the billing summary looks like:
      | Description                          | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Annual | $65.89  | 1        | $65.89  |
      | Additional Computers - Annual        | $22.00  | 4        | $88.00  |
      | Total Charge                         | $153.89 |          | $153.89 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 GB             |
      | Computers:          | 5                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $153.89          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

   @TC.24 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
   Scenario: Upgrade UK MozyHome free user to paid with 125 GB Two Year additional Storage
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | billing country |
      | 24      | 125 GB    | 11           | China           |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | 20 Additional Storage - Biennial               | $42.00  | 11       | $462.00 |
      | Total Charge                                   | $671.79 |          | $671.79 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 220 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Next Billing:       | @2 years from now |
      | Total:              | $671.79           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.25 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: Upgrade UK MozyHome free user to paid with 50 GB Two Year
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | billing country |
      | 24      | 50 GB     | China           |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Total Charge                           | $125.79 |          | $125.79 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 50 GB    |
      | Computers:          | 1                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Next Billing:       | @2 years from now |
      | Total:              | $125.79           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.26 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn @qa6_dependent
  Scenario: Upgrade UK MozyHome free user to paid with 125 GB Monthly additional storage promotional code
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | coupon       | billing country |
      | 1       | 125 GB    |  7           | 10percentoff | China           |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                   | Price  | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99  | 1        | $9.99  |
      | 20 Additional Storage - Monthly               | $2.00  | 7        | $14.00 |
      | Subscription Price                            | $23.99 |          | $23.99 |
      | 24 months at 10.0% off                        | $-2.40 |          | $-2.40 |
      |Total Charge                                   | $21.59 |          | $21.59 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 140 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $23.99            |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.27 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn  
  Scenario: Upgrade UK MozyHome free user to paid with 125 GB Yearly additional Computers storage us fr cn
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl computers | addl storage | billing country |
      | 12      | 125 GB    | 2              | 2            | China           |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | 20 Additional Storage - Annual               | $22.00  | 2        | $44.00  |
      | Additional Computers - Annual                | $22.00  | 2        | $44.00  |
      | Total Charge                                 | $197.89 |          | $197.89 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 40 GB            |
      | Computers:          | 5                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $197.89          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.28 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=fr
  Scenario: Upgrade UK MozyHome free user to paid with 50 GB Two Year
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | addl computer | billing country |
      | 12      | 50 GB     | 1            | 1             | France          |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Annual   | $65.89  | 1        | $65.8 9 |
      | 20 Additional Storage - Annual         | $22.00  | 1        | $22.00  |
      | Additional Computers - Annual          | $22.00  | 1        | $22.00  |
      | Total Charge                           | $125.79 |          | $109.89 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Computers:          | 2                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $109.89          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.29 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=fr @qa6_dependent @bug
  Scenario: Upgrade UK MozyHome free user to paid with 125 GB Monthly additional storage promotional code
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | addl computers | coupon       | billing country |
      | 1       | 125 GB    |  99          | 2              | 10percentoff | France          |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                   | Price  | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99  | 1        | $9.99   |
      | 20 Additional Storage - Monthly               | $2.00  | 99       | $198.00 |
      | Additional Computers - Monthly                | $2.00  | 2        | $4.00   |
      | Subscription Price                            | $23.99 |          | $211.99 |
      | 24 months at 10.0% off                        | $-2.40 |          | $-21.20 |
      |Total Charge                                   | $21.59 |          | $190.79 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 1,980 GB          |
      | Computers:          | 5                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $211.99           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.30 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=fr
    Scenario: TC.30 Upgrade UK MozyHome free user to paid with 125 GB Yearly additional storage computers
      When I add a phoenix Free user:
        | base plan | country       |
        | free      | United States |
      Then the user is successfully added.
      And the user has activated their account
      And I login as the user on the account.
      And I upgrade my free account to:
        | period  | base plan | addl storage | billing country |
        | 12      | 125 GB    | 20           | France          |
      Then upgrade from free to paid will be successful
      Then the billing summary looks like:
        | Description                                  | Price   | Quantity | Amount   |
        | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89  |
        | 20 Additional Storage - Annual               | $22.00  | 20       | $440.00  |
        | Total Charge                                 | $197.89 |          | $549.89  |
      And the current plan summary looks like:
        | Base Plan:          | MozyHome 125 GB   |
        | Additional Storage: | 400 GB            |
        | Computers:          | 3                 |
        | Subscription:       | Yearly            |
        | Term Discount:      | 1 month free      |
        | Next Billing:       | @1 month from now |
        | Total:              | $549.89           |
      And the renewal plan summary is Same as current plan
      And I log in bus admin console as administrator
      And I search user by:
        | keywords       |
        | @mh_user_email |
      And I view user details by newly created MozyHome username
      And I delete user



#
# negative test case failed to upgrade from free to paid
#
@TC.28 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=uk  
  Scenario: Upgrade US MozyHome free user to paid failed fr uk uk
    When I add a phoenix Free user:
      | base plan | country |
      | free      | France  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl computers | addl storage | billing country |
      | 1       | 125 GB    | 2              | 2            | Royaume-Uni     |
    Then billing details page error message should be:
    """
      The country of residence you provided does not match the country of the issuing bank of your credit card.
    """


@TC.29 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=it
  Scenario: Upgrade FR MozyHome free user to paid failed fr uk it
    When I add a phoenix Free user:
      | base plan | country |
      | free      | France  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | billing country |
      | 12      | 125 Go    | Italie          |
    """
      The country of residence you provided does not match the country of the issuing bank of your credit card.
    """

 @TC.30 @phoenix @mozyhome @profile_country=fr @ip_country=us @billing_country=us
  Scenario: Upgrade FR mozyhome free user to paid failed fr us us
    When I add a phoenix Free user:
      | base plan | country |
      | free      | France  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl computers | billing country |
      | 24      | 50 Go     | 2              | États-Unis      |
  Then billing details page error message should be:
  """
    The country of residence you provided does not match the country of the issuing bank of your credit card.
  """

 @TC.31 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=fr 
  Scenario: Upgrade US MozyHome free user to paid failed us fr fr
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | billing country |
      | 12      | 50  GB    | 20           | France          |
   Then billing details page error message should be:
   """
    The country of residence you provided does not match the country of the issuing bank of your credit card.
   """

  @TC.32 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=it
  Scenario: Upgrade US MozyHome free user to paid failed us fr it
    When I add a phoenix Free user:
      | base plan | country        |
      | free      | United States  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period | base plan | billing country |
      | 1      | 50 GB     | Italy           |
    Then billing details page error message should be:
    """
     The country of residence you provided does not match the country of the issuing bank of your credit card.
    """


