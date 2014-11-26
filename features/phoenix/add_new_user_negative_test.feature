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
    | 24     | 125 GB    | United States | United States   | 4111111111111111 |
  Then billing details page error message should be:
  """
   billing country and credit card country not match
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
      | period | base plan | country | billing country | cc number        |
      | 1      | 125 Go    | France  | France          | 4111111111111111 |
    Then billing details page error message should be:
    """
     billing country and credit card country not match
    """

  @TC.150001 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=uk @negative_test
  Scenario: 150001 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 Go    | France  | Royaume-Uni     |
    Then billing details page error message should be:
    """
     There is an inconsistency between the country info you provided and the bank country of you card that matches your current chosen location.
    """

  @TC.150002 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=it @negative_test
  Scenario: 150002 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 Go    | France  | Italie          |
    Then billing details page error message should be:
    """
     There is an inconsistency between the country info you provided and the bank country of you card that matches your current chosen location.
    """

  @TC.150003 @phoenix @mozyhome @profile_country=fr @ip_country=us @billing_country=us @negative_test
  Scenario: 150003 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 Go    | France  | États-Unis      |
    Then billing details page error message should be:
    """
     There is an inconsistency between the country info you provided and the bank country of you card that matches your current chosen location.
    """

  @TC.150004 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=fr @negative_test
  Scenario: 150004 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 12     | 125 GB    | United States | France          |
    Then billing details page error message should be:
    """
     There is an inconsistency between the country info you provided and the bank country of you card that matches your current chosen location.
    """

  @TC.150005 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=it @negative_test
  Scenario: 150005 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 12     | 125 GB    | United States | Italy           |
    Then billing details page error message should be:
    """
     There is an inconsistency between the country info you provided and the bank country of you card that matches your current chosen location.
    """
