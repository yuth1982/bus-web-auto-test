Feature: View billing history

  As a Mozy Administrator
  I want to view itemized statements for the services I have used
  so that I can understand why I was charged what I was charged

  @TC.18898 @smoke @bus @2.0 @view_billing_history
  Scenario: 18898 Verify billing history after create MozyPro partner
    Given I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 250 GB    |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing History section from bus admin console page
    And Billing history table should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | $94.99  | $94.99     | $0.00       |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name