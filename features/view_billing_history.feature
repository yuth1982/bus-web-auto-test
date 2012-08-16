Feature: View billing history

  As a Mozy Administrator
  I want to view itemized statements for the services I have used
  so that I can understand why I was charged what I was charged

  @billing_history_1 @smoke_test
  Scenario: Display new partner billing history table in billing history view
    Given I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan      |
      | 1      | 250 GB, $94.99 |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing History section from bus admin console page
    And Billing history table should be:
      | Date    | Amount  | Total Paid | Balance Due |
      | @today  | $94.99  | $94.99     | $0.00       |