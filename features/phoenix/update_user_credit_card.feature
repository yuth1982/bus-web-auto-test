Feature: MozyHome user update credit card in phoenix

  As a private citizen
  I want to update my credit card through phoenix


  @TC.131678 @regression_test @phoenix
  Scenario: update credit card - us to us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 1      | 50 GB     | United States | United States   | 4111111111111111 |
    And I save the partner info
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          |       |          | $5.99  |
    Then the user is successfully added.
    And the user has activated their account
    When I login as the user on the account.
    And I change my profile attributes to:
      | new_cc_num       | new_cc_type |
      | 5555555555554444 | MasterCard  |
    And user credit card updated successfully

    And I change my profile attributes to:
      | new_cc_num       | new_cc_type      |
      | 378282246310005  | American Express |
    And user credit card updated successfully

    And I change my profile attributes to:
      | new_cc_num       | new_cc_type |
      | 6011111111111117 | Discover    |
    And user credit card updated successfully

    And I change my profile attributes to:
      | new_cc_num       | new_cc_type |
      | 4018121111111122 | Visa        |
    And user credit card updated successfully

  @TC.131771 @regression_test @phoenix
  Scenario: update credit card - uk to uk
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country        | billing country | cc number        | type       |
      | 12     | 50 GB     | United Kingdom | United Kingdom  | 6759411100000008 | Maestro UK |
    And I save the partner info
    Then the billing summary looks like:
      | Description                           | Price              | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual  | £54.89\n(inc. VAT) | 1        | £54.89 |
      | Subscription Price                    |                    |          | £45.74 |
      | VAT Rate (20%)                        |                    |          | £9.15  |
      | Total Charge                          |                    |          | £54.89 |
    Then the user is successfully added.
    And the user has activated their account
    When I login as the user on the account.
    And I change my profile attributes to:
      | new_cc_num       | new_cc_type |
      | 4916783606275713 | Visa        |
    And user credit card updated successfully

    And I change my profile attributes to:
      | new_cc_num          | new_cc_type |
      | 6759560045005727054 | Maestro UK  |
    And user credit card updated successfully

    And I change my profile attributes to:
      | new_cc_num       | new_cc_type |
      | 5641821111166669 | Maestro UK  |
    And user credit card updated successfully

