Feature: Add a new partner through phoenix

  As a business owner
  I want to create a partner through phoenix
  So that I can organize my business in a way that works for me

  Background:
#---------------------------------------------------------------------------------
# base coverage section:
#   represents a balanced set of coverage
#----------------------------------------test matrix------------------------------
#	partner size:	10        | 50          | 100    | 250      | 500      | 1tb
#	monthly:		ie,sv,cp  | ie          | uk     | fr,sv    | de,sv,hp | us
#	yearly:			uk,sv     | de,sv,nv,cp | us,sv  | ie,nv,hp | fr       | fr,cp
#	biannual:		us,hp     | fr,nv       | de,nv  | de       | uk,nv    | ie,sv
#----------------------------------------test legend------------------------------
#		entries by: country,server/dsk,novat,coupon,hipaa
#
#		key: sv=server, nv=novat, cp=coupon, hp=hipaa
#		coupon code = 10PERCENTOFFOUTLINE
#
#     base smoke test = us yearly, 100gb, server
#---------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
# precondition
# ssh root@phoenix01.qa6.mozyops.com  QAP@SSw0rd
# /var/www/phoenix/app/views/registration/_payment_details.rhtml
# 'ip_country' : '<%= country_with_ip(request.remote_ip)%>’
# set 'ip_country' : 'FR' if @ip_country=fr
# restart: /etc/init.d/apache2 restart
#---------------------------------------------------------------------------------

  @TC.133001 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 133001 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 10 Go     | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix  | Quantité | Montant |
      | 10 Go - Mensuel         | 7,99€ | 1        | 7,99€   |
      | Prix d'abonnement       | 7,99€ |          | 7,99€   |
      | TVA                     | 1,60€ |          | 1,60€   |
      | Montant total des frais | 9,59€ |          | 9,59€   |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133002 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 133002 Add a new FR yearly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 12     | 10 Go     | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 10 Go - Annuel          | 87,89€  | 1        | 87,89€  |
      | Prix d'abonnement       | 87,89€  |          | 87,89€  |
      | TVA                     | 17,58€  |          | 17,58€  |
      | Montant total des frais | 105,47€ |          | 105,47€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133003 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 133003 Add a new FR biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 24     | 10 Go     | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 10 Go - Bisannuel       | 167,79€ | 1        | 167,79€ |
      | Prix d'abonnement       | 167,79€ |          | 167,79€ |
      | TVA                     | 33,56€  |          | 33,56€  |
      | Montant total des frais | 201,35€ |          | 201,35€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133004 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 133004 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 50 Go     | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix   | Quantité | Montant |
      | 50 Go - Mensuel         | 15,99€ | 1        | 15,99€  |
      | Prix d'abonnement       | 15,99€ |          | 15,99€  |
      | TVA                     | 3,20€  |          | 3,20€   |
      | Montant total des frais | 19,19€ |          | 19,19€  |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133005 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 133005 Add a new FR yearly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 12     | 50 Go     | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 50 Go - Annuel          | 175,89€ | 1        | 175,89€ |
      | Prix d'abonnement       | 175,89€ |          | 175,89€ |
      | TVA                     | 35,18€  |          | 35,18€  |
      | Montant total des frais | 211,07€ |          | 211,07€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133006 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 133006 Add a new FR biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 24     | 50 Go     | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 50 Go - Bisannuel       | 335,79€ | 1        | 335,79€ |
      | Prix d'abonnement       | 335,79€ |          | 335,79€ |
      | TVA                     | 67,16€  |          | 67,16€  |
      | Montant total des frais | 402,95€ |          | 402,95€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133007 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 133007 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 100 Go    | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 100 Go - Mensuel        | 30,99€  | 1        | 30,99€  |
      | Prix d'abonnement       | 30,99€  |          | 30,99€  |
      | TVA                     | 6,20€   |          | 6,20€   |
      | Montant total des frais | 37,19€  |          | 37,19€  |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133008 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 133008 Add a new FR yearly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 12     | 100 Go    | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 100 Go - Annuel         | 340,89€ | 1        | 340,89€ |
      | Prix d'abonnement       | 340,89€ |          | 340,89€ |
      | TVA                     | 68,18€  |          | 68,18€  |
      | Montant total des frais | 409,07€ |          | 409,07€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133009 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 133009 Add a new FR biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 24     | 100 Go    | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 100 Go - Bisannuel      | 650,79€ | 1        | 650,79€ |
      | Prix d'abonnement       | 650,79€ |          | 650,79€ |
      | TVA                     | 130,16€ |          | 130,16€ |
      | Montant total des frais | 780,95€ |          | 780,95€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133010 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 133010 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 250 Go    | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix   | Quantité | Montant |
      | 250 Go - Mensuel        | 74,99€ | 1        | 74,99€  |
      | Prix d'abonnement       | 74,99€ |          | 74,99€  |
      | TVA                     | 15,00€ |          | 15,00€  |
      | Montant total des frais | 89,99€ |          | 89,99€  |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133011 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 133011 Add a new FR yearly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 12     | 250 Go    | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 250 Go - Annuel         | 824,89€ | 1        | 824,89€ |
      | Prix d'abonnement       | 824,89€ |          | 824,89€ |
      | TVA                     | 164,98€ |          | 164,98€ |
      | Montant total des frais | 989,87€ |          | 989,87€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133012 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 133012 Add a new FR biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 24     | 250 Go     | France  | France         | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 250 Go - Bisannuel      | 1 574,79€ | 1        | 1 574,79€ |
      | Prix d'abonnement       | 1 574,79€ |          | 1 574,79€ |
      | TVA                     | 314,96€   |          | 314,96€   |
      | Montant total des frais | 1 889,75€ |          | 1 889,75€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133013 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 133013 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 500 Go    | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 500 Go - Mensuel        | 149,99€ | 1        | 149,99€ |
      | Prix d'abonnement       | 149,99€ |          | 149,99€ |
      | TVA                     | 30,00€  |          | 30,00€  |
      | Montant total des frais | 179,99€ |          | 179,99€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133014 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 133014 Add a new FR yearly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 12     | 500 Go    | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 500 Go - Annuel         | 1 649,89€ | 1        | 1 649,89€ |
      | Prix d'abonnement       | 1 649,89€ |          | 1 649,89€ |
      | TVA                     | 329,98€   |          | 329,98€   |
      | Montant total des frais | 1 979,87€ |          | 1 979,87€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133015 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 133015 Add a new FR biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 24     | 500 Go    | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 500 Go - Bisannuel      | 3 149,79€ | 1        | 3 149,79€ |
      | Prix d'abonnement       | 3 149,79€ |          | 3 149,79€ |
      | TVA                     | 629,96€   |          | 629,96€   |
      | Montant total des frais | 3 779,75€ |          | 3 779,75€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133016 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 133016 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 1 To      | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 1 To - Mensuel          | 299,99€ | 1        | 299,99€ |
      | Prix d'abonnement       | 299,99€ |          | 299,99€ |
      | TVA                     | 60,00€  |          | 60,00€  |
      | Montant total des frais | 359,99€ |          | 359,99€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133017 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 133017 Add a new FR yearly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 12     | 1 To      | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 1 To - Annuel           | 3 299,89€ | 1        | 3 299,89€ |
      | Prix d'abonnement       | 3 299,89€ |          | 3 299,89€ |
      | TVA                     | 659,98€   |          | 659,98€   |
      | Montant total des frais | 3 959,87€ |          | 3 959,87€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133018 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 133018 Add a new FR biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 24     | 1 To      | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 1 To - Bisannuel        | 6 299,79€ | 1        | 6 299,79€ |
      | Prix d'abonnement       | 6 299,79€ |          | 6 299,79€ |
      | TVA                     | 1 259,96€ |          | 1 259,96€ |
      | Montant total des frais | 7 559,75€ |          | 7 559,75€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133019 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 133019 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | server plan | cc number        |
      | 1      | 10 Go     | France  | Royaume-Uni     | yes         | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix   | Quantité | Montant |
      | 10 Go - Mensuel         | 7,99€  | 1        | 7,99€   |
      | Plan serveur - Mensuel  | 2,99€  | 1        | 2,99€   |
      | Prix d'abonnement       | 10,98€ |          | 10,98€  |
      | TVA                     | 2,20€  |          | 2,20€   |
      | Montant total des frais | 13,18€ |          | 13,18€  |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133020 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 133020 Add a new FR yearly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | coupon              | cc number        |
      | 12     | 10 Go     | France  | Royaume-Uni     | 10PERCENTOFFOUTLINE | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 10 Go - Annuel          | 87,89€  | 1        | 87,89€  |
      | Prix d'abonnement       | 87,89€  |          | 87,89€  |
      | Réductions              | - 8,79€ |          | - 8,79€ |
      | Sous-total              | 79,10€  |          | 79,10€  |
      | TVA                     | 17,58€  |          | 17,58€  |
      | Montant total des frais | 96,68€  |          | 96,68€  |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133021 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 133021 Add a new FR biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | vat number    | cc number        |
      | 24     | 10 Go     | France  | Royaume-Uni     | FR08410091490 | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 10 Go - Bisannuel       | 167,79€   | 1        | 167,79€   |
      | TVA                     | Exemption |          | Exemption |
      | Montant total des frais | 167,79€   |          | 167,79€   |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133022 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 133022 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | server plan | coupon              | cc number        |
      | 1      | 50 Go     | France  | Royaume-Uni     | yes         | 10PERCENTOFFOUTLINE | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 50 Go - Mensuel         | 15,99€  | 1        | 15,99€  |
      | Plan serveur - Mensuel  | 5,49€   | 1        | 5,49€   |
      | Prix d'abonnement       | 21,48€  |          | 21,48€  |
      | Réductions              | - 2,15€ |          | - 2,15€ |
      | Sous-total              | 19,33€  |          | 19,33€  |
      | TVA                     | 4,30€   |          | 4,30€   |
      | Montant total des frais | 23,63€  |          | 23,63€  |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133023 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 133023 Add a new FR yearly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | server plan | vat number    | cc number        |
      | 12     | 50 Go     | France  | Royaume-Uni     | yes         | FR08410091490 | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 50 Go - Annuel          | 175,89€   | 1        | 175,89€   |
      | Plan serveur - Annuel   | 60,39€    | 1        | 60,39€    |
      | TVA                     | Exemption |          | Exemption |
      | Montant total des frais | 236,28€   |          | 236,28€   |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133024 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 133024 Add a new FR biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | coupon              | vat number    | cc number        |
      | 24     | 50 Go     | France  | Royaume-Uni     | 10PERCENTOFFOUTLINE | FR08410091490 | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 50 Go - Bisannuel       | 335,79€   | 1        | 335,79€   |
      | Prix d'abonnement       | 335,79€   |          | 335,79€   |
      | Réductions              | - 33,58€  |          | - 33,58€  |
      | TVA                     | Exemption |          | Exemption |
      | Montant total des frais | 302,21€   |          | 302,21€   |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133025 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 133025 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | server plan |coupon              | vat number    | cc number        |
      | 1      | 100 Go    | France  | Royaume-Uni     | yes         |10PERCENTOFFOUTLINE | FR08410091490 | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 100 Go - Mensuel        | 30,99€    | 1        | 30,99€    |
      | Plan serveur - Mensuel  | 9,99€     | 1        | 9,99€     |
      | Prix d'abonnement       | 40,98€    |          | 40,98€    |
      | Réductions              | - 4,10€   |          | - 4,10€   |
      | TVA                     | Exemption |          | Exemption |
      | Montant total des frais | 36,88€    |          | 36,88€    |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133026 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 133026 Add a new FR yearly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 12     | 1 To      | France  | Royaume-Uni     | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 1 To - Annuel           | 3 299,89€ | 1        | 3 299,89€ |
      | Prix d'abonnement       | 3 299,89€ |          | 3 299,89€ |
      | TVA                     | 659,98€   |          | 659,98€   |
      | Montant total des frais | 3 959,87€ |          | 3 959,87€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133027 @phoenix @mozypro @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 133027 Add a new FR biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 24     | 10 Go     | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 10 Go - Bisannuel       | 167,79€ | 1        | 167,79€ |
      | Prix d'abonnement       | 167,79€ |          | 167,79€ |
      | TVA                     | 33,56€  |          | 33,56€  |
      | Montant total des frais | 201,35€ |          | 201,35€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133028 @phoenix @mozypro @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 133028 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 1 To      | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 1 To - Mensuel          | 299,99€ | 1        | 299,99€ |
      | Prix d'abonnement       | 299,99€ |          | 299,99€ |
      | TVA                     | 60,00€  |          | 60,00€  |
      | Montant total des frais | 359,99€ |          | 359,99€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133029 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 133029 Add a new FR biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | vat number    | cc number        |
      | 1      | 10 Go     | France  | France          | FR08410091490 | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 10 Go - Mensuel         | 7,99€     | 1        | 7,99€     |
      | TVA                     | Exemption |          | Exemption |
      | Montant total des frais | 7,99€     |          | 7,99€     |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133030 @phoenix @mozypro @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 133030 Add a new FR biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | vat number    | cc number        |
      | 24     | 100 Go    | France  | France          | FR08410091490 | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 100 Go - Bisannuel      | 650,79€   | 1        | 650,79€   |
      | TVA                     | Exemption |          | Exemption |
      | Montant total des frais | 650,79€   |          | 650,79€   |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133031 @phoenix @mozypro @profile_country=fr @ip_country=uk @billing_country=uk
  Scenario: 133031 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | vat number    | cc number        |
      | 1      | 250 Go    | France  | Royaume-Uni     | FR08410091490 | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 250 Go - Mensuel        | 74,99€    | 1        | 74,99€    |
      | TVA                     | Exemption |          | Exemption |
      | Montant total des frais | 74,99€    |          | 74,99€    |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133032 @phoenix @mozypro @profile_country=fr @ip_country=uk @billing_country=it
  Scenario: 133032 Add a new FR yearly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | vat number    | cc number        |
      | 12     | 500 Go    | France  | Royaume-Uni     | FR08410091490 | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 500 Go - Annuel         | 1 649,89€ | 1        | 1 649,89€ |
      | TVA                     | Exemption |          | Exemption |
      | Montant total des frais | 1 649,89€ |          | 1 649,89€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133033 @phoenix @mozypro @profile_country=fr @ip_country=us @billing_country=us
  Scenario: 133033 Add a new FR biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | vat number    | cc number        |
      | 24     | 1 To      | France  | États-Unis      | FR08410091490 | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 1 To - Bisannuel        | 6 299,79€ | 1        | 6 299,79€ |
      | TVA                     | Exemption |          | Exemption |
      | Montant total des frais | 6 299,79€ |          | 6 299,79€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name
