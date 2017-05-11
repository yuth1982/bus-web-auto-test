Feature: Corporate Invoices

  As a Mozy Enterprise customer
  I want to construct my billing terms in a way that fits my needs and usage
  so that I can pay the way that makes sense to me (ex. bundles packages, minimums, per-user licensing, etc).

  Background:
    Given I log in bus admin console as administrator

  @TC.15686 @bus @2.0 @corporate_invoices @email @regression @core_function
  Scenario: 15686 Verify Aria sends email when create a new MozyPro partner
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I search emails by keywords:
      | to               | subject                  |
      | @new_admin_email | MozyPro Account Created! |
    Then I should see 1 email(s)
    And I wait for 1200 seconds
    When I search emails by keywords:
      | from        | subject                    | content          |
      | ar@mozy.com | Mozy Inc Account Statement | @company_address |
    Then I should see 1 email(s)

  @TC.15687 @bus @2.0 @corporate_invoices @email @regression @core_function
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

  @TC.17841 @bus @2.0 @corporate_invoices @email @regression @core_function
  Scenario: 17841 Verify Aria sends email when create a new MozyEnterprise partner
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I search emails by keywords:
      | to               | subject                         |
      | @new_admin_email | MozyEnterprise Account Created! |
    Then I should see 1 email(s)
    And I wait for 1200 seconds
    When I search emails by keywords:
      | from        | subject                    | content          |
      | ar@mozy.com | Mozy Inc Account Statement | @company_address |
    Then I should see 1 email(s)

  @TC.17842 @slow @javascript @bus @2.0 @corporate_invoices @email @regression @core_function
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

  @TC.124568 @bus @2.17 @corporate_invoices @MozyPro_France @tasks_p3
  Scenario: 124568 Check the invoice when adding a new EU pro partner under MozyPro France with valid vat number
    When I add a new MozyPro partner:
      | period | base plan | create under   | country | server plan | vat number  | coupon              | cc number        |
      | 12     | 1 TB      | MozyPro France | Germany | yes         | DE812321109 | 10PERCENTOFFOUTLINE | 4188181111111112 |
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

  @TC.124568 @bus @2.17 @corporate_invoices @MozyPro_France @tasks_p3
  Scenario: 124568 Check the invoice when adding a new EU pro partner under MozyPro France with valid vat number
    When I add a new MozyPro partner:
      | period | base plan | create under   | country | server plan | vat number    | coupon              | cc number        |
      | 12     | 1 TB      | MozyPro France | France  | yes         | FR08410091490 | 10PERCENTOFFOUTLINE | 4485393141463880 |
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

  @TC.124569 @bus @2.17 @corporate_invoices @MozyPro_Ireland @tasks_p3
  Scenario: 124569 Check the invoice when adding a new EU pro partner under MozyPro Ireland with valid vat number
    When I add a new MozyPro partner:
      | period | base plan | create under    | country | server plan | vat number  | coupon              | cc number        |
      | 12     | 1 TB      | MozyPro Ireland | Germany | yes         | DE812321109 | 10PERCENTOFFOUTLINE | 4188181111111112 |
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
# bug #129815
#      | From Date      | To Date                | Quantity | Description                                                         | Price      | VAT       | Percent of Period | Total Price |
      | From Date      | To Date                | Quantity | Description                                                         | Price      | VAT (23%) | Percent of Period | Total Price |
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

  @TC.124569 @bus @2.17 @corporate_invoices @MozyPro_Ireland @tasks_p3
  Scenario: 124569 Check the invoice when adding a new EU pro partner under MozyPro Ireland with valid vat number
    When I add a new MozyPro partner:
      | period | base plan | create under    | country | server plan | vat number | coupon              | cc number        |
      | 12     | 1 TB      | MozyPro Ireland | Ireland | yes         | IE9691104A | 10PERCENTOFFOUTLINE | 4319402211111113 |
    And New partner should be created
    And Partner internal billing should be:
      | Account Type:   | Credit Card  | Current Period: | Yearly             |
      | Unpaid Balance: | €0.00        | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year |                 |                    |
    And Partner billing history should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | €3,176.84 | €3,176.84  | €0.00       |
    When I click the latest date link to view the invoice
    And I navigate to new window
    Then Invoice head should include newly created partner company name
    And Billing details of partner invoice should be:
      | Billing Detail |                        |          |                                                                     |            |           |                   |             |
      | From Date      | To Date                | Quantity | Description                                                         | Price      | VAT (23%) | Percent of Period | Total Price |
      |                |                        |          | Previous Balance                                                    |            |           |                   | € 0.00      |
      | today          | after 1 year yesterday | 1        | MozyPro 1 TB Plan (Annual) MozyPro Bundle                           | € 2,654.89 | € 549.56  | 100.00%           | € 3,204.45  |
      | today          | after 1 year yesterday | 1        | MozyPro Server Add-on for 1 TB Plan (Annual) Mozy Pro Server Add On | € 214.89   | € 44.48   | 100.00%           | € 259.37    |
      | today          | after 1 year yesterday | 1        | RULE-10PERCENTOFFOUTLINE                                            | € -265.49  | € 0.00    | 100.00%           | € -265.49   |
      | today          | after 1 year yesterday | 1        | RULE-10PERCENTOFFOUTLINE                                            | € -21.49   | € 0.00    | 100.00%           | € -21.49    |
      |                |                        |          | Total                                                               |            |           |                   | € 3,176.84  |
      | today          |                        |          | Electronic Payment                                                  |            |           |                   | €-3,176.84  |
      |                |                        |          | Balance                                                             |            |           |                   | € 0.00      |
    And Exchange rate of partner invoice should be:
      | From Currency | To Currency | Exchange Rate |
      | EUR           | EUR         | 1             |
    When I close new window
    And I delete partner account

  @TC.124570 @bus @2.17 @corporate_invoices @MozyPro @tasks_p3
  Scenario: 124570 Check the invoice when adding a new EU pro partner under MozyPro with valid vat number
    When I add a new MozyPro partner:
      | period | base plan | create under | country | server plan | vat number  | coupon              | cc number        |
      | 12     | 1 TB      | MozyPro      | Germany | yes         | DE812321109 | 10PERCENTOFFOUTLINE | 4188181111111112 |
    And New partner should be created
    And Partner internal billing should be:
      | Account Type:   | Credit Card  | Current Period: | Yearly             |
      | Unpaid Balance: | $0.00        | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year |                 |                    |
    And Partner billing history should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | $2,841.10 | $2,841.10  | $0.00       |
    When I click the latest date link to view the invoice
    And I navigate to new window
    Then Invoice head should include newly created partner company name
    And Billing details of partner invoice should be:
      | Billing Detail |                        |          |                                                                     |            |           |                   |             |
# bug #129815
#      | From Date      | To Date                | Quantity | Description                                                         | Price      | VAT       | Percent of Period | Total Price |
      | From Date      | To Date                | Quantity | Description                                                         | Price      | VAT (23%) | Percent of Period | Total Price |
      |                |                        |          | Previous Balance                                                    |            |           |                   | $ 0.00      |
      | today          | after 1 year yesterday | 1        | MozyPro 1 TB Plan (Annual) MozyPro Bundle                           | $ 2,919.89 | $ 0.00    | 100.00%           | $ 2,919.89  |
      | today          | after 1 year yesterday | 1        | MozyPro Server Add-on for 1 TB Plan (Annual) Mozy Pro Server Add On | $ 236.89   | $ 0.00    | 100.00%           | $ 236.89    |
      | today          | after 1 year yesterday | 1        | RULE-10PERCENTOFFOUTLINE                                            | $ -291.99  | $ 0.00    | 100.00%           | $ -291.99   |
      | today          | after 1 year yesterday | 1        | RULE-10PERCENTOFFOUTLINE                                            | $ -23.69   | $ 0.00    | 100.00%           | $ -23.69    |
      |                |                        |          | Total                                                               |            |           |                   | $ 2,841.10  |
      | today          |                        |          | Electronic Payment                                                  |            |           |                   | $-2,841.10  |
      |                |                        |          | Balance                                                             |            |           |                   | $ 0.00      |
    And Exchange rate of partner invoice should be:
      | From Currency | To Currency | Exchange Rate |
      | USD           | EUR         | .8128         |
    When I close new window
    And I delete partner account

  @TC.124571 @bus @2.17 @corporate_invoices @MozyPro_Ireland @tasks_p3
  Scenario: 124571 Check the invoice when adding a new EU mozypro partner under MozyPro Ireland - net terms
    When I add a new MozyPro partner:
      | period | base plan | create under    | country | net terms |
      | 1      | 100 GB    | MozyPro Ireland | Belgium | yes       |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30  | Current Period: | Monthly            |
      | Unpaid Balance: | €37.50        | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month |                 |                    |
    And Partner billing history should be:
      | Date  | Amount | Total Paid | Balance Due |
      | today | €37.50 | €0.00      | €37.50      |
    When I click the latest date link to view the invoice
    And I navigate to new window
    Then Invoice head should include newly created partner company name
    And Billing details of partner invoice should be:
      | Billing Detail           |                         |          |                                              |         |           |                   |             |
# bug #129815
#      | From Date                | To Date                 | Quantity | Description                                  | Price   | VAT (21%) | Percent of Period | Total Price |
      | From Date                | To Date                 | Quantity | Description                                  | Price   | VAT       | Percent of Period | Total Price |
      |                          |                         |          | Previous Balance                             |         |           |                   | € 0.00      |
      | today                    | after 1 month yesterday | 1        | MozyPro 100 GB Plan (Monthly) MozyPro Bundle | € 30.99 | € 6.51    | 100.00%           | € 37.50     |
      |                          |                         |          | Total                                        |         |           |                   | € 37.50     |
      |                          |                         |          | Amount Due                                   |         |           |                   | € 37.50     |
      |                          |                         |          |                                              |         |           |                   |             |
      | VAT Rate applied: 21.00% |                         |          |                                              |         |           |                   |             |
    And Exchange rate of partner invoice should be:
      | From Currency | To Currency | Exchange Rate |
      | EUR           | EUR         | 1             |
    When I close new window
    And I delete partner account

  @TC.124572 @bus @2.17 @corporate_invoices @MozyPro_France @tasks_p3
  Scenario: 124572 Check the invoice when adding a new EU mozypro partner under MozyPro France - net terms
    When I add a new MozyPro partner:
      | period | base plan | create under   | country | net terms |
      | 1      | 100 GB    | MozyPro France | Belgium | yes       |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30  | Current Period: | Monthly            |
      | Unpaid Balance: | €37.50        | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month |                 |                    |
    And Partner billing history should be:
      | Date  | Amount | Total Paid | Balance Due |
      | today | €37.50 | €0.00      | €37.50      |
    When I click the latest date link to view the invoice
    And I navigate to new window
    Then Invoice head should include newly created partner company name
    And Billing details of partner invoice should be:
      | Billing Detail           |                         |          |                                              |         |           |                   |             |
# bug #129815
#      | From Date                | To Date                 | Quantity | Description                                  | Price   | VAT (21%) | Percent of Period | Total Price |
      | From Date                | To Date                 | Quantity | Description                                  | Price   | VAT       | Percent of Period | Total Price |
      |                          |                         |          | Previous Balance                             |         |           |                   | € 0.00      |
      | today                    | after 1 month yesterday | 1        | MozyPro 100 GB Plan (Monthly) MozyPro Bundle | € 30.99 | € 6.51    | 100.00%           | € 37.50     |
      |                          |                         |          | Total                                        |         |           |                   | € 37.50     |
      |                          |                         |          | Balance                                      |         |           |                   | € 37.50     |
      |                          |                         |          |                                              |         |           |                   |             |
      | VAT Rate applied: 21.00% |                         |          |                                              |         |           |                   |             |
    And Exchange rate of partner invoice should be:
      | From Currency | To Currency | Exchange Rate |
      | EUR           | EUR         | 1             |
    When I close new window
    And I delete partner account

  @TC.124573 @bus @2.17 @corporate_invoices @MozyPro_France @tasks_p3
  Scenario: 124573 Check the invoice when adding a new EU mozypro partner under MozyPro Germany - net terms
    When I add a new MozyPro partner:
      | period | base plan | create under    | country | net terms |
      | 1      | 100 GB    | MozyPro Germany | Belgium | yes       |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30  | Current Period: | Monthly            |
      | Unpaid Balance: | €37.50        | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month |                 |                    |
    And Partner billing history should be:
      | Date  | Amount | Total Paid | Balance Due |
      | today | €37.50 | €0.00      | €37.50      |
    When I click the latest date link to view the invoice
    And I navigate to new window
    Then Invoice head should include newly created partner company name
    And Billing details of partner invoice should be:
      | Billing Detail           |                         |          |                                              |         |           |                   |             |
# bug #129815
#      | From Date                | To Date                 | Quantity | Description                                  | Price   | VAT (21%) | Percent of Period | Total Price |
      | From Date                | To Date                 | Quantity | Description                                  | Price   | VAT       | Percent of Period | Total Price |
      |                          |                         |          | Previous Balance                             |         |           |                   | € 0.00      |
      | today                    | after 1 month yesterday | 1        | MozyPro 100 GB Plan (Monthly) MozyPro Bundle | € 30.99 | € 6.51    | 100.00%           | € 37.50     |
      |                          |                         |          | Total                                        |         |           |                   | € 37.50     |
      |                          |                         |          | Balance                                      |         |           |                   | € 37.50     |
      |                          |                         |          |                                              |         |           |                   |             |
      | VAT Rate applied: 21.00% |                         |          |                                              |         |           |                   |             |
    And Exchange rate of partner invoice should be:
      | From Currency | To Currency | Exchange Rate |
      | EUR           | EUR         | 1             |
    When I close new window
    And I delete partner account

  @TC.124575 @bus @2.17 @corporate_invoices @MozyPro_France @tasks_p3
  Scenario: 124575 Check the invoice when adding a new UK Reseller partner with valid vat number
    When I add a new Reseller partner:
      | period | reseller type | country        | create under | reseller quota | storage add on | coupon              | vat number  | cc number        |
      | 12     | Gold          | United Kingdom | MozyPro UK   | 1200           | 10             | 10PERCENTOFFOUTLINE | GB117223643 | 4916783606275713 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And Partner internal billing should be:
      | Account Type:   | Credit Card  | Current Period: | Yearly             |
      | Unpaid Balance: | £0.00        | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year |                 |                    |
    And Partner billing history should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | £2,721.60 | £2,721.60  | £0.00       |
    When I click the latest date link to view the invoice
    And I navigate to new window
    Then Invoice head should include newly created partner company name
    And Billing details of partner invoice should be:
      | Billing Detail |                        |          |                                                          |            |           |                   |             |
# bug #129815
#      | From Date      |  To Date               | Quantity | Description                                              |     Price  | VAT       | Percent of Period | Total Price |
      | From Date      |  To Date               | Quantity | Description                                              | Price      | VAT (23%) | Percent of Period | Total Price |
      |                |                        |          | Previous Balance                                         |            |           |                   | £ 0.00      |
      | today          | after 1 year yesterday | 1200     | Mozy Reseller GB - Gold (Annual) Mozy Reseller           | £ 2.16     | £ 0.00    | 100.00%           | £ 2,592.00  |
      | today          | after 1 year yesterday | 10       | Mozy Reseller 20 GB add-on - Gold (Annual) Mozy Reseller | £ 43.20    | £ 0.00    | 100.00%           | £ 432.00    |
      | today          | after 1 year yesterday | 1200     | RULE-10PERCENTOFFOUTLINE                                 | £ -0.22    | £ 0.00    | 100.00%           | £ -259.20   |
      | today          | after 1 year yesterday | 10       | RULE-10PERCENTOFFOUTLINE                                 | £ -4.32    | £ 0.00    | 100.00%           | £ -43.20    |
      |                |                        |          | Total                                                    |            |           |                   | £ 2,721.60  |
      | today          |                        |          | Electronic Payment                                       |            |           |                   | £-2,721.60  |
      |                |                        |          | Balance                                                  |            |           |                   | £ 0.00      |
    And Exchange rate of partner invoice should be:
      | From Currency | To Currency | Exchange Rate |
      | GBP           | EUR         | 1.274381      |
    When I close new window
    And I delete partner account

  @TC.124576 @bus @2.17 @corporate_invoices @MozyPro_France @tasks_p3
  Scenario: 124576 Check the invoice when adding a new EU Reseller partner with valid vat number - net terms
    When I add a new Reseller partner:
      | period | reseller type | country | create under   | reseller quota | server plan | storage add on | vat number    | net terms |
      | 1      | Silver        | France  | MozyPro France | 600            | yes         | 10             | FR08410091490 | yes       |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30  | Current Period: | Monthly            |
      | Unpaid Balance: | €260.00       | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month |                 |                    |
    And Partner billing history should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | €260.00 | €0.00      | €260.00     |
    When I click the latest date link to view the invoice
    And I navigate to new window
    Then Invoice head should include newly created partner company name
    And Billing details of partner invoice should be:
      | Billing Detail           |                         |          |                                                                       |         |           |                   |             |
# bug #129815
#      | From Date                | To Date                 | Quantity | Description                                                           | Price   | VAT (20%) | Percent of Period | Total Price |
      | From Date                |  To Date                | Quantity | Description                                                           | Price   | VAT       | Percent of Period | Total Price |
      |                          |                         |          | Previous Balance                                                      |         |           |                   | € 0.00      |
      | today                    | after 1 month yesterday | 600      | Mozy Reseller GB - Silver (Monthly) Mozy Reseller                     | € 0.30  | € 0.00    | 100.00%           | € 180.00    |
      | today                    | after 1 month yesterday | 10       | Mozy Reseller 20 GB add-on - Silver (Monthly) Mozy Reseller           | € 6.00  | € 0.00    | 100.00%           | € 60.00     |
      | today                    | after 1 month yesterday | 1        | Mozy Reseller Server Add-on - Silver (Monthly) Reseller Server Add On | € 20.00 | € 0.00    | 100.00%           | € 20.00     |
      |                          |                         |          | Total                                                                 |         |           |                   | € 260.00    |
      |                          |                         |          | Balance                                                               |         |           |                   | € 260.00    |
    And Exchange rate of partner invoice should be:
      | From Currency | To Currency | Exchange Rate |
      | EUR           | EUR         | 1             |
    When I close new window
    And I delete partner account

  @TC.124577 @bus @2.17 @corporate_invoices @MozyPro_France @tasks_p3
  Scenario: 124577 Check the invoice when change subscription period - EU reseller - net terms
    When I add a new Reseller partner:
      | period | reseller type | country | create under    | reseller quota | storage add on | net terms |
      | 1      | Gold          | Ireland | MozyPro Ireland | 1000           | 2              | yes       |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30  | Current Period: | Monthly            |
      | Unpaid Balance: | €319.80       | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month |                 |                    |
    And Partner billing history should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | €319.80 | €0.00      | €319.80     |
    When I click the latest date link to view the invoice
    And I navigate to new window
    Then Invoice head should include newly created partner company name
    And Billing details of partner invoice should be:
      | Billing Detail           |                         |          |                                                           |        |           |                   |             |
# bug #129815
#      | From Date                | To Date                 | Quantity | Description                                               | Price  | VAT (23%) | Percent of Period | Total Price |
      | From Date                |  To Date                | Quantity | Description                                               | Price  | VAT       | Percent of Period | Total Price |
      |                          |                         |          | Previous Balance                                          |        |           |                   | € 0.00      |
      | today                    | after 1 month yesterday | 1000     | Mozy Reseller GB - Gold (Monthly) Mozy Reseller           | € 0.25 | € 57.50   | 100.00%           | € 307.50    |
      | today                    | after 1 month yesterday | 2        | Mozy Reseller 20 GB add-on - Gold (Monthly) Mozy Reseller | € 5.00 | € 2.30    | 100.00%           | € 12.30     |
      |                          |                         |          | Total                                                     |        |           |                   | € 319.80    |
      |                          |                         |          | Amount Due                                                |        |           |                   | € 319.80    |
      |                          |                         |          |                                                           |        |           |                   |             |
      | VAT Rate applied: 23.00% |                         |          |                                                           |        |           |                   |             |
    And Exchange rate of partner invoice should be:
      | From Currency | To Currency | Exchange Rate |
      | EUR           | EUR         | 1             |
    When I close new window
    When I act as newly created partner account
    And I change account subscription to annual billing period
    Then Change subscription confirmation message should be:
    """
    Are you sure that you want to change your subscription period from monthly to yearly billing? If you choose to continue, your account will be credited for the remainder of your monthly Subscription, then charged for a new yearly subscription beginning today. By choosing yearly billing, you will receive 1 free month(s) of Mozy service. Any resources you scheduled for return in your next subscription have been deducted from the new subscription total.
    """
    And Change subscription price table should be:
      | Description                                   | Amount    |
      | Credit for remainder of monthly subscription  | €319.80   |
      | Charge for new yearly subscription            | €3,120.00 |
      | Total amount to be charged                    | €2,800.20 |
# bug #129811
#      | Charge for new yearly subscription            | €3,837.60 |
#      | Total amount to be charged                    | €3,517.80 |
    When I continue to change account subscription
    Then Subscription changed message should be Your account has been changed to yearly billing.
    Then Next renewal info table should be:
      | Period          | Date         | Amount                                |
      | Yearly (change) | after 1 year | €3,120.00 (Without taxes or discounts) |
    And I navigate to Billing History section from bus admin console page
    When I stop masquerading
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And Partner billing history should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | €147.60   | €0.00      | €3,837.60   |
      | today | €3,370.20 | €0.00      | €3,690.00   |
      | today | €319.80   | €0.00      | €319.80     |
    When I click the latest date link to view the invoice
    And I navigate to new window
    Then Invoice head should include newly created partner company name
    And Billing details of partner invoice should be:
      | Billing Detail           |                        |          |                                                          |         |           |                   |             |
# bug #129815
#      | From Date                | To Date                | Quantity | Description                                              | Price   | VAT (23%) | Percent of Period | Total Price |
      | From Date                | To Date                | Quantity | Description                                              | Price   | VAT       | Percent of Period | Total Price |
      |                          |                        |          | Previous Balance                                         |         |           |                   | € 3,690.00  |
      | today                    | after 1 year yesterday |   2      | Mozy Reseller 20 GB add-on - Gold (Annual) Mozy Reseller | € 60.00 | € 27.60   | 100.00%           | € 147.60    |
      |                          |                        |          | Total                                                    |         |           |                   | € 147.60    |
      |                          |                        |          | Amount Due                                               |         |           |                   | € 3,837.60  |
      |                          |                        |          |                                                          |         |           |                   |             |
      | VAT Rate applied: 23.00% |                        |          |                                                          |         |           |                   |             |
    And Exchange rate of partner invoice should be:
      | From Currency | To Currency | Exchange Rate |
      | EUR           | EUR         | 1             |
    When I close new window
    And I delete partner account
