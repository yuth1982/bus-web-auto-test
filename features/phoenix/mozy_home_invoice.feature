Feature: Check the invoice of MozyHome user

  As a private citizen
  I should receive the invoice when I sign up / upgrade / re-subscription my MozyHome product
  So that I can have a understanding on how much vat I paid for my MozyHome service

  Background:

  @TC.300001 @phoenix @mozyhome @invoice
  Scenario: 300001 Add a new UK monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country         | billing country | cc number        |
      | 1      | 50 GB     | United Kingdom  | United Kingdom  | 4916783606275713 |
    Then the user is successfully added.
    When I search emails by keywords:
      | to               | subject                |
      | @new_admin_email | Mozy Account Statement |
    Then I should see 1 email(s)
    And I clear downloads folder
    And I download the invoice content
    And I open invoice page
    And invoice country is United Kingdom
    And Billing details of home invoice should be:
      | Billing Detail |               |          |                        |       |               |                   |             |
      | From Date      | To Date       | Quantity | Description            | Price | VAT(GB - 20%) | Percent of Period | Total Price |
      | today          | after 1 month |    1     | MozyHome 50 GB         | £4.16 | £0.83         | 100.0%            | £4.99       |
      |                |               |          | Total                  |       |               |                   | £4.99       |
      | today          |               |          | Electronic Payment     |       |               |                   | £-4.99      |
      |                |               |          | Balance                |       |               |                   | £0.00       |
    And Exchange rate table should be:
      | From Currency | To Currency | Exchange Rate  |
      | GBP           | EUR         | @exchange_rate |
    And vat charged is €1.04