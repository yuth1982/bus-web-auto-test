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

  @TC.136001 @phoenix @mozypro @profile_country=at @ip_country=at @billing_country=at
  Scenario: 136001 Add a new AT monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 100 GB    | Austria | Österreich      | 4548181211111124 |
    Then the order summary looks like:
      | Beschreibung       | Preis  | Menge  | Betrag |
      | 100 GB - Monatlich | 30,99€ | 1      | 30,99€ |
      | Abonnementpreis    | 30,99€ |        | 30,99€ |
      | Umsatzsteuer       | 6,20€  |        | 6,20€  |
      | Gesamtbelastung    | 37,19€ |        | 37,19€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136002 @phoenix @mozypro @profile_country=be @ip_country=be @billing_country=be
  Scenario: 136002 Add a new BE monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | type       |cc number        |
      | 1      | 100 Go    | Belgium | Belgique        | Mastercard |5413271111111222 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 100 Go - Mensuel        | 30,99€  | 1        | 30,99€  |
      | Prix d'abonnement       | 30,99€  |          | 30,99€  |
      | TVA                     | 6,51€   |          | 6,51€   |
      | Montant total des frais | 37,50€  |          | 37,50€  |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136003 @phoenix @mozypro @profile_country=bg @ip_country=bg @billing_country=bg
  Scenario: 136003 Add a new BG monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country  | billing country | cc number        |
      | 1      | 100 GB    | Bulgaria | Bulgaria        | 4169912111111121 |
    Then the order summary looks like:
      | Description        | Price  | Quantity | Amount |
      | 100 GB - Monthly   | €30.99 | 1        | €30.99 |
      | Subscription Price | €30.99 |          | €30.99 |
      | VAT                | €6.20  |          | €6.20  |
      | Total Charge       | €37.19 |          | €37.19 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136004 @phoenix @mozypro @profile_country=hr @ip_country=hr @billing_country=hr
  Scenario: 136004 Add a new HR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 100 GB    | Croatia | Croatia         | 5437781111111222 |
    Then the order summary looks like:
      | Description        | Price  | Quantity | Amount |
      | 100 GB - Monthly   | €30.99 | 1        | €30.99 |
      | Subscription Price | €30.99 |          | €30.99 |
      | VAT                | €7.75  |          | €7.75  |
      | Total Charge       | €38.74 |          | €38.74 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

   # comment out since there is no valid credit card for CY country
#  @TC.136005 @phoenix @mozypro @profile_country=cy @ip_country=cy @billing_country=cy
#  Scenario: 136005 Add a new CY monthly basic MozyPro partner
#    When I am at dom selection point:
#    And I add a phoenix Pro partner:
#      | period | base plan | country | billing country |
#      | 1      | 100 GB    | Cyprus  | Cyprus          |
#    Then the order summary looks like:
#      | Description        | Price  | Quantity | Amount |
#      | 100 GB - Monthly   | €30.99 | 1        | €30.99 |
#      | Subscription Price | €30.99 |          | €30.99 |
#      | VAT                | €5.89  |          | €5.89  |
#      | Total Charge       | €36.88 |          | €36.88 |
#    And the partner is successfully added.
#    And I log in bus admin console as administrator
#    And I search and delete partner account by newly created partner company name

  @TC.136006 @phoenix @mozypro @profile_country=cz @ip_country=cz @billing_country=cz
  Scenario: 136006 Add a new DK monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country        | billing country | cc number        |
      | 1      | 100 GB    | Czech Republic | Czech Republic  | 5101420111111222 |
    Then the order summary looks like:
      | Description        | Price  | Quantity | Amount |
      | 100 GB - Monthly   | €30.99 | 1        | €30.99 |
      | Subscription Price | €30.99 |          | €30.99 |
      | VAT                | €6.51  |          | €6.51  |
      | Total Charge       | €37.50 |          | €37.50 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136007 @phoenix @mozypro @profile_country=dk @ip_country=dk @billing_country=dk
  Scenario: 136007 Add a new DK monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 100 GB    | Denmark | Denmark         | 5578922111111122 |
    Then the order summary looks like:
      | Description        | Price  | Quantity | Amount |
      | 100 GB - Monthly   | €30.99 | 1        | €30.99 |
      | Subscription Price | €30.99 |          | €30.99 |
      | VAT                | €7.75  |          | €7.75  |
      | Total Charge       | €38.74 |          | €38.74 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136008 @phoenix @mozypro @profile_country=ee @ip_country=ee @billing_country=ee
  Scenario: 136008 Add a new EE monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 100 GB    | Estonia | Estonia         | 4238370111111111 |
    Then the order summary looks like:
      | Description        | Price  | Quantity | Amount |
      | 100 GB - Monthly   | €30.99 | 1        | €30.99 |
      | Subscription Price | €30.99 |          | €30.99 |
      | VAT                | €6.20  |          | €6.20  |
      | Total Charge       | €37.19 |          | €37.19 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136009 @phoenix @mozypro @profile_country=fi @ip_country=fi @billing_country=fi
  Scenario: 136009 Add a new FI monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 100 GB    | Finland | Finland         | 4920111111111112 |
    Then the order summary looks like:
      | Description        | Price  | Quantity | Amount |
      | 100 GB - Monthly   | €30.99 | 1        | €30.99 |
      | Subscription Price | €30.99 |          | €30.99 |
      | VAT                | €7.44  |          | €7.44  |
      | Total Charge       | €38.43 |          | €38.43 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136010 @phoenix @mozypro @profile_country=de @ip_country=de @billing_country=de
  Scenario: 136010 Add a new DE monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 100 GB    | Germany | Deutschland     | 4188181111111112 |
    Then the order summary looks like:
      | Beschreibung       | Preis  | Menge  | Betrag |
      | 100 GB - Monatlich | 30,99€ | 1      | 30,99€ |
      | Abonnementpreis    | 30,99€ |        | 30,99€ |
      | Umsatzsteuer       | 5,89€  |        | 5,89€  |
      | Gesamtbelastung    | 36,88€ |        | 36,88€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136011 @phoenix @mozypro @profile_country=el @ip_country=el @billing_country=el
  Scenario: 136011 Add a new EL monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 100 GB    | Greece  | Greece          | 4532121111111111 |
    Then the order summary looks like:
      | Description        | Price  | Quantity | Amount |
      | 100 GB - Monthly   | €30.99 | 1        | €30.99 |
      | Subscription Price | €30.99 |          | €30.99 |
      | VAT                | €7.13  |          | €7.13  |
      | Total Charge       | €38.12 |          | €38.12 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136012 @phoenix @mozypro @profile_country=hu @ip_country=hu @billing_country=hu
  Scenario: 136012 Add a new HU monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 100 GB    | Hungary | Hungary         | 4333112111111111 |
    Then the order summary looks like:
      | Description        | Price  | Quantity | Amount |
      | 100 GB - Monthly   | €30.99 | 1        | €30.99 |
      | Subscription Price | €30.99 |          | €30.99 |
      | VAT                | €8.37  |          | €8.37  |
      | Total Charge       | €39.36 |          | €39.36 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136013 @phoenix @mozypro @profile_country=ie @ip_country=ie @billing_country=ie
  Scenario: 136013 Add a new IE monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 100 GB    | Ireland | Ireland         | 4319402211111113 |
    Then the order summary looks like:
      | Description        | Price  | Quantity | Amount |
      | 100 GB - Monthly   | €30.99 | 1        | €30.99 |
      | Subscription Price | €30.99 |          | €30.99 |
      | VAT                | €7.13  |          | €7.13  |
      | Total Charge       | €38.12 |          | €38.12 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136014 @phoenix @mozypro @profile_country=it @ip_country=it @billing_country=it
  Scenario: 136014 Add a new IE monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 100 GB    | Italy   | Italy           | 4916921703777575 |
    Then the order summary looks like:
      | Description        | Price  | Quantity | Amount |
      | 100 GB - Monthly   | €30.99 | 1        | €30.99 |
      | Subscription Price | €30.99 |          | €30.99 |
      | VAT                | €6.82  |          | €6.82  |
      | Total Charge       | €37.81 |          | €37.81 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136015 @phoenix @mozypro @profile_country=lv @ip_country=lv @billing_country=lv
  Scenario: 136015 Add a new LV monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 100 GB    | Latvia  | Latvia          | 4405211111111122 |
    Then the order summary looks like:
      | Description        | Price  | Quantity | Amount |
      | 100 GB - Monthly   | €30.99 | 1        | €30.99 |
      | Subscription Price | €30.99 |          | €30.99 |
      | VAT                | €6.51  |          | €6.51  |
      | Total Charge       | €37.50 |          | €37.50 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136016 @phoenix @mozypro @profile_country=lt @ip_country=lt @billing_country=lt
  Scenario: 136016 Add a new LT monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country   | billing country | cc number        |
      | 1      | 100 GB    | Lithuania | Lithuania       | 4797121111111111 |
    Then the order summary looks like:
      | Description        | Price  | Quantity | Amount |
      | 100 GB - Monthly   | €30.99 | 1        | €30.99 |
      | Subscription Price | €30.99 |          | €30.99 |
      | VAT                | €6.51  |          | €6.51  |
      | Total Charge       | €37.50 |          | €37.50 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136017 @phoenix @mozypro @profile_country=lu @ip_country=lu @billing_country=lu
  Scenario: 136017 Add a new LU monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country    | billing country | cc number        |
      | 1      | 100 Go    | Luxembourg | Luxembourg      | 4779531111111121 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 100 Go - Mensuel        | 30,99€  | 1        | 30,99€  |
      | Prix d'abonnement       | 30,99€  |          | 30,99€  |
      | TVA                     | 4,65€   |          | 4,65€   |
      | Montant total des frais | 35,64€  |          | 35,64€  |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136018 @phoenix @mozypro @profile_country=mt @ip_country=mt @billing_country=mt
  Scenario: 136018 Add a new MT monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 100 GB    | Malta   | Malta           | 4313801111111121 |
    Then the order summary looks like:
      | Description        | Price  | Quantity | Amount |
      | 100 GB - Monthly   | €30.99 | 1        | €30.99 |
      | Subscription Price | €30.99 |          | €30.99 |
      | VAT                | €5.58  |          | €5.58  |
      | Total Charge       | €36.57 |          | €36.57 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136019 @phoenix @mozypro @profile_country=nl @ip_country=nl @billing_country=nl
  Scenario: 136019 Add a new NL monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country     | billing country | cc number        |
      | 1      | 100 GB    | Netherlands | Netherlands     | 5100291111111111 |
    Then the order summary looks like:
      | Description        | Price  | Quantity | Amount |
      | 100 GB - Monthly   | €30.99 | 1        | €30.99 |
      | Subscription Price | €30.99 |          | €30.99 |
      | VAT                | €6.51  |          | €6.51  |
      | Total Charge       | €37.50 |          | €37.50 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136020 @phoenix @mozypro @profile_country=pl @ip_country=pl @billing_country=pl
  Scenario: 136020 Add a new PL monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 100 GB    | Poland  | Poland          | 4056702111111122 |
    Then the order summary looks like:
      | Description        | Price  | Quantity | Amount |
      | 100 GB - Monthly   | €30.99 | 1        | €30.99 |
      | Subscription Price | €30.99 |          | €30.99 |
      | VAT                | €7.13  |          | €7.13  |
      | Total Charge       | €38.12 |          | €38.12 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136021 @phoenix @mozypro @profile_country=pt @ip_country=pt @billing_country=pt
  Scenario: 136021 Add a new PT monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country  | billing country | cc number        |
      | 1      | 100 GB    | Portugal | Portugal        | 4556581910687747 |
    Then the order summary looks like:
      | Description        | Price  | Quantity | Amount |
      | 100 GB - Monthly   | €30.99 | 1        | €30.99 |
      | Subscription Price | €30.99 |          | €30.99 |
      | VAT                | €7.13  |          | €7.13  |
      | Total Charge       | €38.12 |          | €38.12 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136022 @phoenix @mozypro @profile_country=ro @ip_country=ro @billing_country=ro
  Scenario: 136022 Add a new RO monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 100 GB    | Romania | Romania         | 4493590111111122 |
    Then the order summary looks like:
      | Description        | Price  | Quantity | Amount |
      | 100 GB - Monthly   | €30.99 | 1        | €30.99 |
      | Subscription Price | €30.99 |          | €30.99 |
      | VAT                | €7.44  |          | €7.44  |
      | Total Charge       | €38.43 |          | €38.43 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136023 @phoenix @mozypro @profile_country=sk @ip_country=sk @billing_country=sk
  Scenario: 136023 Add a new SK monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country  | billing country | cc number        |
      | 1      | 100 GB    | Slovakia | Slovakia        | 4544170111111122 |
    Then the order summary looks like:
      | Description        | Price  | Quantity | Amount |
      | 100 GB - Monthly   | €30.99 | 1        | €30.99 |
      | Subscription Price | €30.99 |          | €30.99 |
      | VAT                | €6.20  |          | €6.20  |
      | Total Charge       | €37.19 |          | €37.19 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136024 @phoenix @mozypro @profile_country=si @ip_country=si @billing_country=si
  Scenario: 136024 Add a new SI monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country  | billing country | cc number        |
      | 1      | 100 GB    | Slovenia | Slovenia        | 4493690111111112 |
    Then the order summary looks like:
      | Description        | Price  | Quantity | Amount |
      | 100 GB - Monthly   | €30.99 | 1        | €30.99 |
      | Subscription Price | €30.99 |          | €30.99 |
      | VAT                | €6.82  |          | €6.82  |
      | Total Charge       | €37.81 |          | €37.81 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136025 @phoenix @mozypro @profile_country=es @ip_country=es @billing_country=es
  Scenario: 136025 Add a new ES monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 100 GB    | Spain   | Spain           | 4328191211111111 |
    Then the order summary looks like:
      | Description        | Price  | Quantity | Amount |
      | 100 GB - Monthly   | €30.99 | 1        | €30.99 |
      | Subscription Price | €30.99 |          | €30.99 |
      | VAT                | €6.51  |          | €6.51  |
      | Total Charge       | €37.50 |          | €37.50 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136026 @phoenix @mozypro @profile_country=se @ip_country=se @billing_country=se
  Scenario: 136026 Add a new SE monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 100 GB    | Sweden  | Sweden          | 4581092111111122 |
    Then the order summary looks like:
      | Description        | Price  | Quantity | Amount |
      | 100 GB - Monthly   | €30.99 | 1        | €30.99 |
      | Subscription Price | €30.99 |          | €30.99 |
      | VAT                | €7.75  |          | €7.75  |
      | Total Charge       | €38.74 |          | €38.74 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.136027 @phoenix @mozypro @profile_country=uk @ip_country=uk @billing_country=uk
  Scenario: 136027 Add a new UK monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country        | billing country | cc number        |
      | 1      | 100 GB    | United Kingdom | United Kingdom  | 4916783606275713 |
    Then the order summary looks like:
      | Description        | Price  | Quantity | Amount |
      | 100 GB - Monthly   | £26.99 | 1        | £26.99 |
      | Subscription Price | £26.99 |          | £26.99 |
      | VAT                | £5.40  |          | £5.40  |
      | Total Charge       | £32.39 |          | £32.39 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name
