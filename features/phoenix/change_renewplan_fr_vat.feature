Feature: MozyHome user change renewal plan through phoenix

  As a MozyHome paid user
  I want to change renewal plan
  So that I can have new renewal plan

  ######### VAT applied ####
  #
  # 50 Go Cases
  #
  @TC.237001 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 237001 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 1      | 50 Go     | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                             | PriX              | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Mensuel | 4,99€\n(inc. VAT) | 1        | 4,99€   |
      | Prix d'abonnement                       |                   |          | 4,16€   |
      | Taux de TVA (20%)                       |                   |          | 0,83€   |
      | Montant total des frais                 |                   |          | 4,99€   |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period |
      | 125 Go    | 12     |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 0 x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 125 Go           |
      | Ordinateurs :                       | 3                |
      | Abonnement :                        | Annuel           |
      | Remise : 	                        | 1 mois gratuit   |
      | Montant: 	                        | 82,41€           |
      | Taux de TVA (20%):                  | 16,48€           |
      | Total : 	                        | 98,89€           |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 0 Go             |
      | Ordinateurs :                       | 3                |
      | Abonnement :                        | Annuel           |
      | Remise : 	                        | 1 mois gratuit   |
      | Montant: 	                        | 82,41€           |
      | Taux de TVA (20%):                  | 16,48€           |
      | Total : 	                        | 98,89€           |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237002 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 237002 Add a new FR yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 12     | 50 Go     | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                             | PriX               | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Annuel  | 54,89€\n(inc. VAT) | 1        | 54,89€  |
      | Prix d'abonnement                       |                    |          | 45,74€  |
      | Taux de TVA (20%)                       |                    |          | 9,15€   |
      | Montant total des frais                 |                    |          | 54,89€  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period |
      | 125 Go    | 24     |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 0 x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 125 Go           |
      | Ordinateurs :                       | 3                |
      | Abonnement :                        | Bisannuel        |
      | Remise : 	                        | 3 mois gratuits  |
      | Montant: 	                        | 157,32€          |
      | Taux de TVA (20%):                  | 31,47€           |
      | Total : 	                        | 188,79€          |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 125 Go |
      | Espace de stockage supplémentaire : | 0 Go            |
      | Ordinateurs :                       | 3               |
      | Abonnement :                        | Bisannuel       |
      | Remise : 	                        | 3 mois gratuits |
      | Montant: 	                        | 157,32€         |
      | Taux de TVA (20%):                  | 31,47€          |
      | Total : 	                        | 188,79€         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237003 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 237003 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 24     | 50 Go     | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                               | PriX                | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Bisannuel | 104,79€\n(inc. VAT) | 1        | 104,79€ |
      | Prix d'abonnement                         |                     |          | 87,32€  |
      | Taux de TVA (20%)                         |                     |          | 17,47€  |
      | Montant total des frais                   |                     |          | 104,79€ |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period |
      | 1      |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 50 Go   |
      | Espace de stockage supplémentaire : | 0 x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 50 Go            |
      | Ordinateurs :                       | 1                |
      | Abonnement :                        | Mensuel          |
      | Montant: 	                        | 4,16€            |
      | Taux de TVA (20%):                  | 0,83€            |
      | Total : 	                        | 4,99€            |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 50 Go |
      | Espace de stockage supplémentaire : | 0 Go           |
      | Ordinateurs :                       | 1              |
      | Abonnement :                        | Mensuel        |
      | Montant: 	                        | 4,16€          |
      | Taux de TVA (20%):                  | 0,83€          |
      | Total : 	                        | 4,99€          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 Go Cases
  #
  @TC.237004 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 237004 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 1      | 125 Go    | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                       | PriX                | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Mensuel | 8,99€\n(inc. VAT) | 1          | 8,99€   |
      | Prix d'abonnement                                 |                     |          | 7,49€   |
      | Taux de TVA (20%)                                 |                     |          | 1,50€   |
      | Montant total des frais                           |                     |          | 8,99€   |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | computers |
      | 24     | 5         |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 0 x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 125 Go           |
      | Ordinateurs :                       | 5                |
      | Abonnement :                        | Bisannuel        |
      | Remise : 	                        | 3 mois gratuits  |
      | Montant: 	                        | 227,32€          |
      | Taux de TVA (20%):                  | 45,47€           |
      | Total : 	                        | 272,79€          |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 125 Go |
      | Espace de stockage supplémentaire : | 0 Go            |
      | Ordinateurs :                       | 5               |
      | Abonnement :                        | Bisannuel       |
      | Remise : 	                        | 3 mois gratuits |
      | Montant: 	                        | 227,32€         |
      | Taux de TVA (20%):                  | 45,47€          |
      | Total : 	                        | 272,79€         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237005 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 237005 Add a new FR yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 12     | 125 Go    | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                       | PriX                | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Annuel  | 98,89€\n(inc. VAT)  | 1        | 98,89€  |
      | Prix d'abonnement                                 |                     |          | 82,41€  |
      | Taux de TVA (20%)                                 |                     |          | 16,48€  |
      | Montant total des frais                           |                     |          | 98,89€  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period |
      | 1     |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 0 x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 125 Go           |
      | Ordinateurs :                       | 3                |
      | Abonnement :                        | Mensuel          |
      | Montant: 	                        | 7,49€            |
      | Taux de TVA (20%):                  | 1,50€            |
      | Total : 	                        | 8,99€            |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 125 Go |
      | Espace de stockage supplémentaire : | 0 Go            |
      | Ordinateurs :                       | 3               |
      | Abonnement :                        | Mensuel         |
      | Montant: 	                        | 7,49€           |
      | Taux de TVA (20%):                  | 1,50€           |
      | Total : 	                        | 8,99€           |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237006 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 237006 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 24     | 125 Go    | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                          | PriX                | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Bisannuel  | 188,79€\n(inc. VAT) | 1        | 188,79€ |
      | Prix d'abonnement                                    |                     |          | 157,32€ |
      | Taux de TVA (20%)                                    |                     |          | 31,47€  |
      | Montant total des frais                              |                     |          | 188,79€ |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | addl storage |
      | 12     | 99           |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 125 Go       |
      | Espace de stockage supplémentaire : | 99 x 20 Go = 1 980 Go |
      | Espace total de stockage : 	        | 2 105 Go              |
      | Ordinateurs :                       | 3                     |
      | Abonnement :                        | Annuel                |
      | Remise : 	                        | 1 mois gratuit        |
      | Montant: 	                        | 1 897,41€             |
      | Taux de TVA (20%):                  | 379,48€               |
      | Total : 	                        | 2 276,89€             |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 125 Go |
      | Espace de stockage supplémentaire : | 1,9 To          |
      | Ordinateurs :                       | 3               |
      | Abonnement :                        | Annuel          |
      | Remise : 	                        | 1 mois gratuit  |
      | Montant: 	                        | 1 897,41€       |
      | Taux de TVA (20%):                  | 379,48€         |
      | Total : 	                        | 2 276,89€       |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 50 Go Cases
  #
  @TC.237007 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 237007 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl storage | cc number        |
      | 1      | 50 Go     | France  | Royaume-Uni     | 1            | 4916783606275713 |
    Then the billing summary looks like:
      | Description                             | PriX                | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Mensuel | 4,99€\n(inc. VAT)   | 1        | 4,99€   |
      | 20 Stockage supplémentaire - Mensuel    | 2,00€\n(inc. VAT)   | 1        | 2,00€   |
      | Prix d'abonnement                       |                     |          | 5,82€   |
      | Taux de TVA (20%)                       |                     |          | 1,17€   |
      | Montant total des frais                 |                     |          | 6,99€   |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | addl storage |
      | 125 Go    | 24     | 98           |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 125 Go       |
      | Espace de stockage supplémentaire : | 98 x 20 Go = 1 960 Go |
      | Espace total de stockage : 	        | 2 085 Go              |
      | Ordinateurs :                       | 3                     |
      | Abonnement :                        | Bisannuel             |
      | Remise : 	                        | 3 mois gratuits       |
      | Montant: 	                        | 3 587,32€             |
      | Taux de TVA (20%):                  | 717,47€               |
      | Total : 	                        | 4 304,79€             |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 125 Go |
      | Espace de stockage supplémentaire : | 1,9 To          |
      | Ordinateurs :                       | 3               |
      | Abonnement :                        | Bisannuel       |
      | Remise : 	                        | 3 mois gratuits |
      | Montant: 	                        | 3 587,32€       |
      | Taux de TVA (20%):                  | 717,47€         |
      | Total : 	                        | 4 304,79€       |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237008 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 237008 Add a new fr yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl computers | cc number        |
      | 12     | 50 Go     | France  | Royaume-Uni     | 1              | 4916783606275713 |
    Then the billing summary looks like:
      | Description                            | PriX               | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Annuel | 54,89€\n(inc. VAT) | 1        | 54,89€  |
      | Ordinateurs supplémentaires - Annuel   | 22,00€\n(inc. VAT) | 1        | 22,00€  |
      | Prix d'abonnement                      |                    |          | 64,07€  |
      | Taux de TVA (20%)                      |                    |          | 12,82€  |
      | Montant total des frais                |                    |          | 76,89€  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | computers |
      | 1      | 1         |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 50 Go   |
      | Espace de stockage supplémentaire : | 0 x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 50 Go            |
      | Ordinateurs :                       | 1                |
      | Abonnement :                        | Mensuel          |
      | Montant: 	                        | 4,16€            |
      | Taux de TVA (20%):                  | 0,83€            |
      | Total : 	                        | 4,99€            |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 50 Go |
      | Espace de stockage supplémentaire : | 0 Go           |
      | Ordinateurs :                       | 1              |
      | Abonnement :                        | Mensuel        |
      | Montant: 	                        | 4,16€          |
      | Taux de TVA (20%):                  | 0,83€          |
      | Total : 	                        | 4,99€          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237009 @BUG.128707 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk @qa6_dependent
  Scenario: 237009 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | coupon       | cc number        |
      | 24     | 50 Go     | France  | Royaume-Uni     | 10percentoff | 4916783606275713 |
    Then the billing summary looks like:
      | Description                               | PriX                | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Bisannuel | 104,79€\n(inc. VAT) | 1        | 104,79€ |
      | 24 mois à 10.0 % de réduction             | -10,47€\n(inc. VAT) |          | -10,47€ |
      | Prix d'abonnement                         |                     |          | 78,60€  |
      | Taux de TVA (20%)                         |                     |          | 15,72€  |
      | Montant total des frais                   |                     |          | 94,32€  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | computers |
      | 125 Go    | 5         |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 0 x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 125 Go           |
      | Ordinateurs :                       | 5                |
      | Abonnement :                        | Bisannuel        |
      | Remise : 	                        | 3 mois gratuits  |
      | Montant: 	                        | 227,32€          |
      | Taux de TVA (20%):                  | 45,47€           |
      | Total : 	                        | 272,79€          |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 125 Go |
      | Espace de stockage supplémentaire : | 0 Go            |
      | Ordinateurs :                       | 5               |
      | Abonnement :                        | Bisannuel       |
      | Remise : 	                        | 3 mois gratuits |
      | Montant: 	                        | 227,32€         |
      | Taux de TVA (20%):                  | 45,47€          |
      | Total : 	                        | 272,79€         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 Go Cases
  #
  @TC.237010 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 237010 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl storage | addl computers | cc number        |
      | 1      | 125 Go    | France  | Royaume-Uni     | 2            | 2              | 4916783606275713 |
    Then the billing summary looks like:
      | Description                                       | PriX              | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Mensuel | 8,99€\n(inc. VAT) | 1        | 8,99€   |
      | 20 Stockage supplémentaire - Mensuel              | 2,00€\n(inc. VAT) |   2      | 4,00€   |
      | Ordinateurs supplémentaires - Mensuel             | 2,00€\n(inc. VAT) |   2      | 4,00€   |
      | Prix d'abonnement                                 |                   |          | 14,16€  |
      | Taux de TVA (20%)                                 |                   |          | 2,83€   |
      | Montant total des frais                           |                   |          | 16,99€  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | addl storage | computers |
      | 50 Go     | 12     | 3            | 1         |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 50 Go    |
      | Espace de stockage supplémentaire : | 3 x 20 Go = 60 Go |
      | Espace total de stockage : 	        | 110 Go            |
      | Ordinateurs :                       | 1                 |
      | Abonnement :                        | Annuel            |
      | Remise : 	                        | 1 mois gratuit    |
      | Montant: 	                        | 100,74€           |
      | Taux de TVA (20%):                  | 20,15€            |
      | Total : 	                        | 120,89€           |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 50 Go  |
      | Espace de stockage supplémentaire : | 60 Go           |
      | Ordinateurs :                       | 1               |
      | Abonnement :                        | Annuel          |
      | Remise : 	                        | 1 mois gratuit  |
      | Montant: 	                        | 100,74€         |
      | Taux de TVA (20%):                  | 20,15€          |
      | Total : 	                        | 120,89€         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237011 @BUG.128707 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk @qa6_dependent
  Scenario: 237011 Add a new FR yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl storage | coupon       | cc number        |
      | 12     | 125 Go    | France  | Royaume-Uni     | 98           | 10percentoff | 4916783606275713 |
    Then the billing summary looks like:
      | Description                                      | PriX                 | Quantité | Montant   |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Annuel | 98,89€\n(inc. VAT)   | 1        | 98,89€    |
      | 20 Stockage supplémentaire - Annuel              | 22,00€\n(inc. VAT)   | 98       | 2 156,00€ |
      | 12 mois à 10.0 % de réduction                    | -225,48€\n(inc. VAT) |          | -225,48€  |
      | Prix d'abonnement                                |                      |          | 1 691,17€ |
      | Taux de TVA (20%)                                |                      |          | 338,24€   |
      | Montant total des frais                          |                      |          | 2 029,41€ |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | addl storage |
      | 24     | 10           |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 125 Go     |
      | Espace de stockage supplémentaire : | 10 x 20 Go = 200 Go |
      | Espace total de stockage : 	        | 325 Go              |
      | Ordinateurs :                       | 3                   |
      | Abonnement :                        | Bisannuel           |
      | Remise : 	                        | 3 mois gratuits     |
      | Montant: 	                        | 507,32€             |
      | Taux de TVA (20%):                  | 101,47€             |
      | Total : 	                        | 608,79€             |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 125 Go |
      | Espace de stockage supplémentaire : | 200 Go          |
      | Ordinateurs :                       | 3               |
      | Abonnement :                        | Bisannuel       |
      | Remise : 	                        | 3 mois gratuits |
      | Montant: 	                        | 507,32€         |
      | Taux de TVA (20%):                  | 101,47€         |
      | Total : 	                        | 608,79€         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237012 @BUG.128707 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk @qa6_dependent
  Scenario: 237012 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl computers | coupon       | cc number        |
      | 24     | 125 Go    | France  | Royaume-Uni     | 1              | 10percentoff | 4916783606275713 |
    Then the billing summary looks like:
      | Description                                         | PriX                | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Bisannuel | 188,79€\n(inc. VAT) | 1        | 188,79€ |
      | Ordinateurs supplémentaires - Bisannuel             | 42,00€\n(inc. VAT)  | 1        | 42,00€  |
      | 24 mois à 10.0 % de réduction                       | -23,07€\n(inc. VAT) |          | -23,07€ |
      | Prix d'abonnement                                   |                     |          | 173,10€ |
      | Taux de TVA (20%)                                   |                     |          | 34,62€  |
      | Montant total des frais                             |                     |          | 207,72€ |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period |
      | 50 Go     | 1      |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 50 Go   |
      | Espace de stockage supplémentaire : | 0 x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 50 Go            |
      | Ordinateurs :                       | 1                |
      | Abonnement :                        | Mensuel          |
      | Montant: 	                        | 4,16€            |
      | Taux de TVA (20%):                  | 0,83€            |
      | Total : 	                        | 4,99€            |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 50 Go |
      | Espace de stockage supplémentaire : | 0 Go           |
      | Ordinateurs :                       | 1              |
      | Abonnement :                        | Mensuel        |
      | Montant: 	                        | 4,16€          |
      | Taux de TVA (20%):                  | 0,83€          |
      | Total : 	                        | 4,99€          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 50 Go Cases
  #
  @TC.237013 @BUG.128707 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr @qa6_dependent
  Scenario: 237013 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl storage | addl computers | coupon       | cc number        |
      | 1      | 50 Go     | France  | France          | 99           | 2              | 10percentoff | 4485393141463880 |
    Then the billing summary looks like:
      | Description                             | PriX                | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Mensuel | 4,99€\n(inc. VAT)   | 1        | 4,99€   |
      | 20 Stockage supplémentaire - Mensuel    | 2,00€\n(inc. VAT)   | 99       | 198,00€ |
      | Ordinateurs supplémentaires - Mensuel   | 2,00€\n(inc. VAT)   | 2        | 4,00€   |
      | 1 mois à 10.0 % de réduction            | -20,69€\n(inc. VAT) |          | -20,69€ |
      | Prix d'abonnement                       |                     |          | 155,25€ |
      | Taux de TVA (20%)                       |                     |          | 31,05€  |
      | Montant total des frais                 |                     |          | 186,30€ |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | addl storage | computers |
      | 1            | 2         |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 50 Go    |
      | Espace de stockage supplémentaire : | 1 x 20 Go = 20 Go |
      | Espace total de stockage : 	        | 70 Go             |
      | Ordinateurs :                       | 2                 |
      | Abonnement :                        | Mensuel           |
      | Montant: 	                        | 7,49€             |
      | Taux de TVA (20%):                  | 1,50€             |
      | Total : 	                        | 8,99€             |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 50 Go |
      | Espace de stockage supplémentaire : | 20 Go          |
      | Ordinateurs :                       | 2              |
      | Abonnement :                        | Mensuel        |
      | Montant: 	                        | 7,49€          |
      | Taux de TVA (20%):                  | 1,50€          |
      | Total : 	                        | 8,99€          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237014 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 237014 Add a new FR yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 12     | 50 Go     | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                             | PriX               | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Annuel  | 54,89€\n(inc. VAT) | 1        | 54,89€  |
      | Prix d'abonnement                       |                    |          | 45,74€  |
      | Taux de TVA (20%)                       |                    |          | 9,15€   |
      | Montant total des frais                 |                    |          | 54,89€  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan |
      | 125 Go    |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 0 x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 125 Go           |
      | Ordinateurs :                       | 3                |
      | Abonnement :                        | Annuel           |
      | Remise : 	                        | 1 mois gratuit   |
      | Montant: 	                        | 82,41€           |
      | Taux de TVA (20%):                  | 16,48€           |
      | Total : 	                        | 98,89€           |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 125 Go |
      | Espace de stockage supplémentaire : | 0 Go            |
      | Ordinateurs :                       | 3               |
      | Abonnement :                        | Annuel          |
      | Remise : 	                        | 1 mois gratuit  |
      | Montant: 	                        | 82,41€          |
      | Taux de TVA (20%):                  | 16,48€          |
      | Total : 	                        | 98,89€          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237015 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 237015 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 24     | 50 Go     | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                               | PriX                | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Bisannuel | 104,79€\n(inc. VAT) | 1        | 104,79€ |
      | Prix d'abonnement                         |                     |          | 87,32€  |
      | Taux de TVA (20%)                         |                     |          | 17,47€  |
      | Montant total des frais                   |                     |          | 104,79€ |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | computers |
      | 125 Go    | 12     | 4         |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 0 x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 125 Go           |
      | Ordinateurs :                       | 4                |
      | Abonnement :                        | Annuel           |
      | Remise : 	                        | 1 mois gratuit   |
      | Montant: 	                        | 100,74€          |
      | Taux de TVA (20%):                  | 20,15€           |
      | Total : 	                        | 120,89€          |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 125 Go |
      | Espace de stockage supplémentaire : | 0 Go            |
      | Ordinateurs :                       | 4               |
      | Abonnement :                        | Annuel          |
      | Remise : 	                        | 1 mois gratuit  |
      | Montant: 	                        | 100,74€         |
      | Taux de TVA (20%):                  | 20,15€          |
      | Total : 	                        | 120,89€         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 Go Cases
  #
  @TC.237016 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 237016 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 1      | 125 Go    | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                      | PriX              | Quantité | Montant |
      |MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Mensuel | 8,99€\n(inc. VAT) | 1        | 8,99€   |
      | Prix d'abonnement                                |                   |          | 7,49€   |
      | Taux de TVA (20%)                                |                   |          | 1,50€   |
      | Montant total des frais                          |                   |          | 8,99€   |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan |
      | 50 Go     |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 50 Go   |
      | Espace de stockage supplémentaire : | 0 x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 50 Go            |
      | Ordinateurs :                       | 1                |
      | Abonnement :                        | Mensuel          |
      | Montant: 	                        | 4,16€            |
      | Taux de TVA (20%):                  | 0,83€            |
      | Total : 	                        | 4,99€            |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 50 Go |
      | Espace de stockage supplémentaire : | 0 Go           |
      | Ordinateurs :                       | 1              |
      | Abonnement :                        | Mensuel        |
      | Montant: 	                        | 4,16€          |
      | Taux de TVA (20%):                  | 0,83€          |
      | Total : 	                        | 4,99€          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237017 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 237017 Add a new FR yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 12     | 125 Go    | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                      | PriX               | Quantité | Montant |
      |MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Annuel  | 98,89€\n(inc. VAT) | 1        | 98,89€  |
      | Prix d'abonnement                                |                    |          | 82,41€  |
      | Taux de TVA (20%)                                |                    |          | 16,48€  |
      | Montant total des frais                          |                    |          | 98,89€  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | computers | addl storage |
      | 50 Go     | 12     | 3         | 10           |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 50 Go      |
      | Espace de stockage supplémentaire : | 10 x 20 Go = 200 Go |
      | Espace total de stockage : 	        | 250 Go              |
      | Ordinateurs :                       | 3                   |
      | Abonnement :                        | Annuel              |
      | Remise : 	                        | 1 mois gratuit      |
      | Montant: 	                        | 265,74€             |
      | Taux de TVA (20%):                  | 53,15€              |
      | Total : 	                        | 318,89€             |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 50 Go |
      | Espace de stockage supplémentaire : | 200 Go         |
      | Ordinateurs :                       | 3              |
      | Abonnement :                        | Annuel         |
      | Remise : 	                        | 1 mois gratuit |
      | Montant: 	                        | 265,74€        |
      | Taux de TVA (20%):                  | 53,15€         |
      | Total : 	                        | 318,89€        |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237018 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 237018 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 24     | 125 Go    | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                         | PriX                | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Bisannuel | 188,79€\n(inc. VAT) | 1        | 188,79€ |
      | Prix d'abonnement                                   |                     |          | 157,32€ |
      | Taux de TVA (20%)                                   |                     |          | 31,47€  |
      | Montant total des frais                             |                     |          | 188,79€ |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period |
      | 50 Go     | 12     |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 50 Go   |
      | Espace de stockage supplémentaire : | 0 x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 50 Go            |
      | Ordinateurs :                       | 1                |
      | Abonnement :                        | Annuel           |
      | Remise : 	                        | 1 mois gratuit   |
      | Montant: 	                        | 45,74€           |
      | Taux de TVA (20%):                  | 9,15€            |
      | Total : 	                        | 54,89€           |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 50 Go |
      | Espace de stockage supplémentaire : | 0 Go           |
      | Ordinateurs :                       | 1              |
      | Abonnement :                        | Annuel         |
      | Remise : 	                        | 1 mois gratuit |
      | Montant: 	                        | 45,74€         |
      | Taux de TVA (20%):                  | 9,15€          |
      | Total : 	                        | 54,89€         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user