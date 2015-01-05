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
  # 125 GB Cases
  #
  @TC.140001 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us @negative_test @invalid_coupon
  Scenario: 140001 Add a new US monthly basic MozyHome user
  When I am at dom selection point:
  And I add a phoenix Home user:
    | period | base plan | country       | billing country | coupon      |
    | 12     | 125 GB    | United States | United States   | 5percentoff |
  Then mozy plan page error message should be:
  """
   The promotion code 5percentoff is invalid or has expired.
  """

  @TC.140002 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us @negative_test @billing_cc_not_match
  Scenario: 140002 Add a new US monthly basic MozyHome user
  When I am at dom selection point:
  And I add a phoenix Home user:
    | period | base plan | country       | billing country | cc number        |
    | 24     | 125 GB    | United States | United States   | 4916783606275713 |
  Then billing details page error message should be:
  """
   The billing country you provided does not match the country of the bank which issued your credit card.
  """

  @TC.140003 @BUG.128707 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 140003 Add a new FR yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl storage | coupon              |
      | 12     | 125 Go    | France  | Royaume-Uni     | 98           | 10percentoffInvalid |
    Then mozy plan page error message should be:
    """
     Le code de promotion 10percentoffInvalid est incorrect ou a expiré.
    """

  @TC.140004 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 140004 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number       |
      | 1      | 125 Go    | France  | France          | 4916783606275713|
    Then billing details page error message should be:
    """
     Le pays de facturation indiqué ne correspond pas au pays de la banque ayant fourni votre carte de crédit.
    """

  @TC.150001 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=uk @negative_test
  Scenario: 150001 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number       |
      | 12     | 125 Go    | France  | Royaume-Uni     | 4916783606275713|
    Then billing details page error message should be:
    """
     Le pays de résidence que vous avez fourni ne correspond pas au pays de la banque qui a émis votre carte de crédit. Veuillez changer le pays que vous avez choisi comme pays de résidence, ou saisissez une carte de crédit qui correspond à votre pays de résidence.
    """

  @TC.150002 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=it @negative_test
  Scenario: 150002 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 12     | 125 Go    | France  | Italie          | 4111111111111111 |
    Then billing details page error message should be:
    """
     Le pays de facturation indiqué ne correspond pas au pays de la banque ayant fourni votre carte de crédit.
    """

  @TC.150003 @phoenix @mozyhome @profile_country=fr @ip_country=us @billing_country=us @negative_test
  Scenario: 150003 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 12     | 125 Go    | France  | États-Unis      | 4018121111111122 |
    Then billing details page error message should be:
    """
     Le pays de résidence que vous avez fourni ne correspond pas au pays de la banque qui a émis votre carte de crédit. Veuillez changer le pays que vous avez choisi comme pays de résidence, ou saisissez une carte de crédit qui correspond à votre pays de résidence.
    """

  @TC.150004 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=fr @negative_test
  Scenario: 150004 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number       |
      | 12     | 125 GB    | United States | France          | 4485393141463880|
    Then billing details page error message should be:
    """
     The country of residence you provided does not match the country of the bank which issued your credit card. Please review the country you chose as your country of residence, or enter a credit card which matches your country of residence.
    """

  @TC.150005 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=it @negative_test
  Scenario: 150005 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 12     | 125 GB    | United States | Italy           | 4916921703777575 |
    Then billing details page error message should be:
    """
     The country of residence you provided does not match the country of the bank which issued your credit card. Please review the country you chose as your country of residence, or enter a credit card which matches your country of residence.
    """

  @TC.150006 @phoenix @mozyhome @profile_country=de @ip_country=fr @billing_country=us @negative_test
  Scenario: 150006 Add a new DE yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country    | cc number        |
      | 12     | 125 GB    | Germany | Vereinigte Staaten | 4018121111111122 |
    Then billing details page error message should be:
    """
    Das Land des Firmensitzes, das Sie angegeben haben, stimmt nicht mit dem Land der Bank, die Ihre Kreditkarte verwaltet, überein. Bitte prüfen Sie das Land noch einmal, das Sie als Land Ihres Firmensitzes angegeben haben, oder geben Sie eine Kreditkarte an, die mit dem Land Ihres Firmensitzes übereinstimmt.
    """
  @TC.150007 @phoenix @mozyhome @profile_country=de @ip_country=fr @billing_country=de @negative_test
  Scenario: 150007 Add a new IE yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 12     | 125 GB    | Germany |  Deutschland    | 4018121111111122 |
    Then billing details page error message should be:
    """
     Ihre Kreditkarte wurde in einem anderen Land ausgestellt als das, in dem sich Ihre Rechnungsadresse befindet
    """

  @TC.150008 @phoenix @mozyhome @profile_country=uk @ip_country=fr @billing_country=us @negative_test
  Scenario: 150008 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country        | billing country | cc number        |
      | 12     | 125 GB    | United Kingdom | United States   | 4018121111111122 |
    Then billing details page error message should be:
    """
     The country of residence you provided does not match the country of the bank which issued your credit card. Please review the country you chose as your country of residence, or enter a credit card which matches your country of residence.
    """

  @TC.150009 @phoenix @mozyhome @profile_country=uk @ip_country=fr @billing_country=uk @negative_test
  Scenario: 150009 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country        | billing country | cc number        |
      | 12     | 125 GB    | United Kingdom | United Kingdom  | 4111111111111111 |
    Then billing details page error message should be:
    """
     The billing country you provided does not match the country of the bank which issued your credit card.
    """