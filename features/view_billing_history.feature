Feature: View billing history

  As a Mozy Administrator
  I want to view itemized statements for the services I have used
  so that I can understand why I was charged what I was charged

  @billing_history_1 @smoke_test
  Scenario: Display new partner billing history table in billing history view
    Given I log in bus admin console as administrator
    When I add a MozyPro partner with 1 month(s) period, 250 GB, $94.99 plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to billing history view
    And Billing history table should be:
    | Date    | Amount  | Total Paid | Balance Due |
    | Today   | $19.99  | $19.99     | 0.00        |