Feature: Corporate Invoices

  As a Mozy Enterprise customer
  I want to construct my billing terms in a way that fits my needs and usage
  so that I can pay the way that makes sense to me (ex. bundles packages, minimums, per-user licensing, etc).

  Background:
    Given I log in bus admin console as administrator

  @TC.15686 @bus @2.0 @corporate_invoices @email @regression
  Scenario: 15686 Verify Aria sends email when create a new MozyPro partner
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I search emails by keywords:
      | to               | subject                  |
      | @new_admin_email | MozyPro Account Created! |
    Then I should see 1 email(s)
    When I search emails by keywords:
      | from        | subject                    | content          |
      | ar@mozy.com | Mozy Inc Account Statement | @company_address |
    Then I should see 1 email(s)

  @TC.15687 @bus @2.0 @corporate_invoices @email @regression
  Scenario: 15687 Verify Aria sends invoice email when change subscription period of a MozyPro partner
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to annual billing period!
    Then Subscription changed message should be Your account has been changed to yearly billing.
    #QA12's billing email will delay many minutes
    And I wait for 1200 seconds
    When I search emails by keywords:
      | from        | subject                    | content          |
      | ar@mozy.com | Mozy Inc Account Statement | @company_address |
    Then I should see 2 email(s)

  @TC.17841 @bus @2.0 @corporate_invoices @email @regression
  Scenario: 17841 Verify Aria sends email when create a new MozyEnterprise partner
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I search emails by keywords:
      | to               | subject                         |
      | @new_admin_email | MozyEnterprise Account Created! |
    Then I should see 1 email(s)
    When I search emails by keywords:
      | from        | subject                    | content          |
      | ar@mozy.com | Mozy Inc Account Statement | @company_address |
    Then I should see 1 email(s)

  @TC.17842 @slow @javascript @bus @2.0 @corporate_invoices @email @regression
  Scenario: 17842 Verify Aria sends invoice email when change subscription period of a MozyEnterprise partner
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to biennial billing period!
    Then Subscription changed message should be Your account has been changed to biennial billing.
    #QA12's billing email will delay many minutes
    And I wait for 1200 seconds
    When I search emails by keywords:
      | from        | subject                    | content          |
      | ar@mozy.com | Mozy Inc Account Statement | @company_address |
    Then I should see 2 email(s)

  @TC.124658 @bus @2.17 @corporate_invoices @MozyPro_Germany @tasks_p3
  Scenario: 124658 Check the invoice when adding a new EU pro partner under MozyPro Germany with valid vat number
    When I add a new MozyPro partner:
      | period | base plan | create under    | country | server plan | vat number  | coupon              | cc number        |
      | 12     | 1 TB      | MozyPro Germany | Germany | yes         | DE812321109 | 10PERCENTOFFOUTLINE | 4188181111111112 |
    And New partner should be created
    And Partner internal billing should be:
      | Account Type:   | Credit Card  | Current Period: | Yearly             |
      | Unpaid Balance: | €0.00        | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year |                 |                    |
    And Partner billing history should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | €2,582.80 | €2,582.80  | €0.00       |
    When I click the latest date link to view the invoice
    And I navigate to new window
    Then Invoice head should include newly created partner company name
    And Billing details of partner invoice should be:
      | Billing Detail |                        |          |                                                                     |            |           |                   |             |
      | From Date      | To Date                | Quantity | Description                                                         | Price      | VAT       | Percent of Period | Total Price |
      |                |                        |          | Previous Balance                                                    |            |           |                   | € 0.00      |
      | today          | after 1 year yesterday | 1        | MozyPro 1 TB Plan (Annual) MozyPro Bundle                           | € 2,654.89 | € 0.00    | 100.00%           | € 2,654.89  |
      | today          | after 1 year yesterday | 1        | MozyPro Server Add-on for 1 TB Plan (Annual) Mozy Pro Server Add On | € 214.89   | € 0.00    | 100.00%           | € 214.89    |
      | today          | after 1 year yesterday | 1        | RULE-10PERCENTOFFOUTLINE                                            | € -265.49  | € 0.00    | 100.00%           | € -265.49   |
      | today          | after 1 year yesterday | 1        | RULE-10PERCENTOFFOUTLINE                                            | € -21.49   | € 0.00    | 100.00%           | € -21.49    |
      |                |                        |          | Total                                                               |            |           |                   | € 2,582.80  |
      | today          |                        |          | Electronic Payment                                                  |            |           |                   | €-2,582.80  |
      |                |                        |          | Balance                                                             |            |           |                   | € 0.00      |
    And Exchange rate of partner invoice should be:
      | From Currency | To Currency | Exchange Rate |
      | EUR           | EUR         | 1             |
    When I close new window
    And I delete partner account
