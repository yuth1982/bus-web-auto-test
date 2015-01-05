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
#  4485393141463880: FR
#  4916783606275713: UK
#---------------------------------------------------------------------------------

  @TC.132001 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr @negative_test
  Scenario: 132001 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | vat number | cc number        |
      | 1      | 100 Go    | France  | France          | IE9691104A | 4485393141463880 |
    Then vat error message should be:
    """
     Le numéro de TVA n’est pas valide. Veuillez réessayer.
    """

  @TC.132002 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=uk @negative_test
  Scenario: 132002 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | vat number           | cc number        |
      | 24     | 10 Go     | France  | United Kingdom  | FR08410091490Invalid | 4485393141463880 |
    Then vat error message should be:
    """
     Le numéro de TVA n’est pas valide. Veuillez réessayer.
    """

  @TC.132003 @phoenix @mozypro @profile_country=fr @ip_country=uk @billing_country=fr @negative_test
  Scenario: 132003 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | coupon      | cc number        |
      | 1      | 50 Go     | France  | France          | 5percentoff | 4485393141463880 |
    Then mozy plan page error message should be:
    """
    Code du coupon non valide
    """

  @TC.132004 @phoenix @mozypro @profile_country=fr @ip_country=uk @billing_country=fr @negative_test
  Scenario: 132004 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | vat number           | cc number        |
      | 1      | 250 Go    | France  | France          | FR08410091490Invalid | 4485393141463880 |
    Then vat error message should be:
    """
     Le numéro de TVA n’est pas valide. Veuillez réessayer.
    """

  @TC.132005 @phoenix @mozypro @profile_country=us @ip_country=fr @billing_country=us @negative_test
  Scenario: 132005 Add a new US monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | coupon      | cc number        |
      | 24     | 50 GB     | United States | United States   | 5percentoff | 4485393141463880 |
    Then mozy plan page error message should be:
    """
    Invalid coupon code
    """

  @TC.132006 @phoenix @mozypro @profile_country=us @ip_country=us @billing_country=fr @negative_test
  Scenario: 132006 Add a new US monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | coupon       | cc number        |
      | 24     | 50 GB     | United States | United States   | 10percentoff | 4485393141463880 |
    Then mozy plan page error message should be:
    """
    Invalid coupon code
    """

  @TC.134001 @phoenix @mozypro @profile_country=fr @ip_country=uk @billing_country=uk @negative_test
  Scenario: 134001 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 100 Go    | France  | Royaume-Uni     | 4485393141463880 |
    Then payment information page error message should be:
    """
     Échec de validation du pays de contact, de facturation, et du numéro de TVA.
    """

  @TC.134002 @phoenix @mozypro @profile_country=fr @ip_country=uk @billing_country=it @negative_test
  Scenario: 134002 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country |cc number        |
      | 1      | 100 Go    | France  | Italie          |4485393141463880 |
    Then payment information page error message should be:
    """
     Échec de validation du pays de contact, de facturation, et du numéro de TVA.
    """

  @TC.134003 @phoenix @mozypro @profile_country=fr @ip_country=us @billing_country=us @negative_test
  Scenario: 134003 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country |cc number        |
      | 1      | 100 Go    | France  | États-Unis      |4485393141463880 |
    Then payment information page error message should be:
    """
     Échec de validation du pays de contact, de facturation, et du numéro de TVA.
    """

  @TC.134004 @phoenix @mozypro @profile_country=us @ip_country=fr @billing_country=fr @negative_test
  Scenario: 134004 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | cc number        |
      | 1      | 100 GB    | United States | France          | 4018121111111122 |
    Then payment information page error message should be:
    """
     Failed to validate contact country, billing country, and VAT number
    """

  @TC.134005 @phoenix @mozypro @profile_country=us @ip_country=fr @billing_country=it @negative_test
  Scenario: 134005 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | cc number        |
      | 1      | 100 GB    | United States | Italy           | 4018121111111122 |
    Then payment information page error message should be:
    """
     Failed to validate contact country, billing country, and VAT number
    """

  @TC.134006 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 134006 Add a new FR biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 24     | 500 Go    | France  | Royaume-Uni     | 4556581910687747 |
    Then payment information page error message should be:
    """
    Impossible de valider les informations de paiement. Veuillez s'il vous plait vous assurer que votre pays de résidence corresponde au pays de la banque qui a produit votre carte de crédit.
    """

  @TC.134007 @phoenix @mozypro @profile_country=us @ip_country=us @billing_country=fr
  Scenario: 134007 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | cc number        |
      | 1      | 1 TB      | United States | France          | 4485393141463880 |
    Then payment information page error message should be:
    """
    Could not validate payment information. Please make sure your country of residence matches the country of the bank which issued your credit card.
    """
  @TC.134008 @phoenix @mozypro @profile_country=de @ip_country=us @billing_country=us @negative_test
  Scenario: 134008 Add a new DE monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country    | cc number        |
      | 1      | 100 GB    | Germany | Vereinigte Staaten | 4485393141463880 |
    Then payment information page error message should be:
    """
     Das Land des Ansprechpartners, das Land der Zahlung und die Umsatzsteuer konnten nicht bestätigt werden
    """

  @TC.134009 @phoenix @mozypro @profile_country=de @ip_country=us @billing_country=de @negative_test
  Scenario: 134009 Add a new DE monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country    | cc number        |
      | 1      | 100 GB    | Germany | Deutschland        | 4485393141463880 |
    Then payment information page error message should be:
    """
     Zahlungsangaben konnten nicht bestätigt werden. Bitte überprüfen SIe, dass Ihre Rechnungsadresse mit dem Ausstellungsland Ihrer Kreditkarte übereinstimmt
    """

  @TC.134010 @phoenix @mozypro @profile_country=uk @ip_country=us @billing_country=us @negative_test
  Scenario: 134010 Add a new UK monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country        | billing country | cc number        |
      | 1      | 100 GB    | United Kingdom | United States   | 4916783606275713 |
    Then payment information page error message should be:
    """
     Failed to validate contact country, billing country, and VAT number
    """

  @TC.134011 @phoenix @mozypro @profile_country=uk @ip_country=us @billing_country=uk @negative_test
  Scenario: 134011 Add a new UK monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country        | billing country | cc number        |
      | 1      | 100 GB    | United Kingdom | United Kingdom  | 4485393141463880 |
    Then payment information page error message should be:
    """
    Could not validate payment information. Please make sure your country of residence matches the country of the bank which issued your credit card.
    """