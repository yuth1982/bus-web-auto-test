Feature: View billing history

  As a Mozy Administrator
  I want to view itemized statements for the services I have used
  so that I can understand why I was charged what I was charged

  @billing_history_1 @smoke_test
  Scenario: Display new partner billing history table in billing history view
    Given I log in bus admin console as administrator
    When I add a MozyPro partner with 1 month(s) period, 250 GB, $94.99 plan, no server plan, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    When I log in bus admin console as the new partner account
    And I navigate to billing history view
    Then The statements table header in billing history view should be Date,Amount,Total Paid,Balance Due
    And The number of statements in billing history view should be 1

  Scenario Outline: Display billing statements of existing partner in billing history view
    Given I log in bus admin console as <partner admin>
    When I navigate to billing history view
    Then The number of statements in billing history view should be <number>
    And The statements in billing history view should be <content>

  Scenarios:
    | partner admin     | number | content                                  |
    | polly kuhn admin  | 1      | 02/14/12 $725.85 $0.00 $725.85 123857955 |

  Scenario: Display billing history table header in partner details view
    Given I log in bus admin console as root admin
    When I search partner by qa6+Polly+Kuhn@mozy.com
    And I view partner details by Grady-Hegmann
    Then The statements table header in partner details view should be Date,Amount,Total Paid,Balance Due

  Scenario Outline: Display billing history of existing partner in partner details view
    Given I log in bus admin console as root admin
    When I search partner by <user name>
    And I view partner details by <partner name>
    Then The number of statements in partner details view should be <number>
    And The statements in partner details view should be <content>

  Scenarios:
    | user name               | partner name    | number | content                                  |
    | qa6+Polly+Kuhn@mozy.com | Grady-Hegmann   | 1      | 02/14/12 $725.85 $0.00 $725.85 123857955 |