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

  @TC.132001 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr @negative_test
  Scenario: 132001 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | vat number |
      | 1      | 100 Go    | France  | France          | IE9691104A |
    Then vat error message should be:
    """
     Le numéro de TVA n’est pas valide. Veuillez réessayer.
    """

  @TC.132002 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=uk @negative_test
  Scenario: 132002 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | vat number           |
      | 24     | 10 Go     | France  | United Kingdom  | FR08410091490Invalid |
    Then vat error message should be:
    """
     Le numéro de TVA n’est pas valide. Veuillez réessayer.
    """

  @TC.132003 @phoenix @mozypro @profile_country=fr @ip_country=uk @billing_country=fr @negative_test
  Scenario: 132003 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | coupon      |
      | 1      | 50 Go     | France  | France          | 5percentoff |
    Then mozy plan page error message should be:
    """
    Code du coupon non valide
    """

  @TC.132004 @phoenix @mozypro @profile_country=fr @ip_country=uk @billing_country=fr @negative_test
  Scenario: 132004 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | vat number           |
      | 1      | 250 Go    | France  | France          | FR08410091490Invalid |
    Then vat error message should be:
    """
     Le numéro de TVA n’est pas valide. Veuillez réessayer.
    """

  @TC.132005 @phoenix @mozypro @profile_country=us @ip_country=fr @billing_country=us @negative_test
  Scenario: 132005 Add a new US monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | coupon      |
      | 24     | 50 GB     | United States | United States   | 5percentoff |
    Then mozy plan page error message should be:
    """
    Invalid coupon code
    """

  @TC.132006 @phoenix @mozypro @profile_country=us @ip_country=us @billing_country=fr @negative_test
  Scenario: 132006 Add a new US monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | coupon       |
      | 24     | 50 GB     | United States | United States   | 10percentoff |
    Then mozy plan page error message should be:
    """
    Invalid coupon code
    """

  @TC.134001 @phoenix @mozypro @profile_country=fr @ip_country=uk @billing_country=uk @negative_test
  Scenario: 134001 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country |
      | 1      | 100 Go    | France  | Royaume-Uni     |
    Then payment information page error message should be:
    """
     validate country is Failed
    """

  @TC.134002 @phoenix @mozypro @profile_country=fr @ip_country=uk @billing_country=it @negative_test
  Scenario: 134002 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country |
      | 1      | 100 Go    | France  | Italie          |
    Then payment information page error message should be:
    """
     validate country is Failed
    """

  @TC.134003 @phoenix @mozypro @profile_country=fr @ip_country=us @billing_country=us @negative_test
  Scenario: 134003 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country |
      | 1      | 100 Go    | France  | États-Unis      |
    Then payment information page error message should be:
    """
     validate country is Failed
    """

  @TC.134004 @phoenix @mozypro @profile_country=us @ip_country=fr @billing_country=fr @negative_test
  Scenario: 134004 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country |
      | 1      | 100 GB    | United States | France          |
    Then payment information page error message should be:
    """
     validate country is Failed
    """

  @TC.134005 @phoenix @mozypro @profile_country=us @ip_country=fr @billing_country=it @negative_test
  Scenario: 134005 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country |
      | 1      | 100 GB    | United States | Italy           |
    Then payment information page error message should be:
    """
     validate country is Failed
    """

  @TC.134006 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 134006 Add a new FR biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 24     | 500 Go    | France  | Royaume-Uni     | 4111111111111111 |
    Then payment information page error message should be:
    """
     billing country and credit card country not match
    """

  @TC.134007 @phoenix @mozypro @profile_country=us @ip_country=us @billing_country=fr
  Scenario: 134007 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | cc number        |
      | 1      | 1 TB      | United States | France          | 4111111111111111 |
    Then payment information page error message should be:
    """
     billing country and credit card country not match
    """
