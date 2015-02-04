
Feature: Add a new EU reseller partner

  As a Mozy Administrator
  I want to create Reseller EU partners
  So that I can organize my business in a way that works for me

  Background:
    Given I log in bus admin console as administrator


  @TC.70000 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 40301 Add New Reseller Partner - US - Monthly - Silver 780 GB - Server Plan - Coupon - CC
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | storage add on | coupon              | country       |
      | 1      | Silver        | 780            | yes         |     10         | 10PERCENTOFFOUTLINE | United States |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70001 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70001 Add New Reseller Partner  -- Monthly -- Silver -- IE -- 1000 GB -- Server Plan -- Net Terms
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  net terms |
      |   1    |  Silver          | Ireland         | MozyPro Ireland  | 1000            |      yes     |      yes   |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:zero]%>  |
    And I search and delete partner account by newly created partner company name

  @TC.70002 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70002 Add New Reseller Partner  -- Monthly -- Gold -- IT -- 1000 GB -- CC -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota | storage add on | cc number        |
      |   1    |  Gold            | Italy           | MozyPro Germany  | 1000            |     10         | 4916921703777575 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70003 @bus @2.17 @add_new_partner @reseller @env_dependent @coupon
  Scenario: 70003 Add New Reseller Partner  -- Monthly -- Platinum -- FR -- 2000 GB -- Server Plan -- Coupon -- CC -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  coupon              | storage add on | cc number        |
      |   1    |  Platinum        | France          | MozyPro France   | 2000            |      yes     |  10PERCENTOFFOUTLINE |     10         | 4485393141463880 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                                                            | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70004 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70004 Add New Reseller Partner  -- Monthly -- Silver -- SE -- 1000 GB -- Server Plan -- Net Terms
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  net terms |
      |   1    |  Silver          | Sweden          | MozyPro Germany  | 1000            |      yes     |      yes   |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:zero]%>  |
    And I search and delete partner account by newly created partner company name

  @TC.70005 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70005 Add New Reseller Partner  -- Monthly -- Gold -- DE -- 1024 GB -- CC -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota | storage add on | cc number        |
      |   1    |  Gold            | Germany         | MozyPro Germany  | 1024            |     10         | 4188181111111112 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70006 @bus @2.17 @add_new_partner @reseller @env_dependent @coupon
  Scenario: 70006 Add New Reseller Partner  -- Monthly -- Platinum -- PL -- 3500 GB -- Server Plan -- Coupon -- CC -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  coupon              | storage add on | cc number        |
      |   1    |  Platinum        | Poland          | MozyPro France   | 3500            |      yes     |  10PERCENTOFFOUTLINE |     10         | 4023581211111111 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70007 @bus @2.17 @add_new_partner @reseller @env_dependent @coupon
  Scenario: 70007 Add New Reseller Partner  -- Monthly -- Silver -- ES -- 500 GB -- Server Plan -- Coupon -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  coupon              | cc number        |
      |   1    |  Silver          | Spain           | MozyPro Ireland  | 500             |      yes     |  10PERCENTOFFOUTLINE | 4328191211111111 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70008 @bus @2.17 @add_new_partner @reseller @vat @env_dependent @coupon
  Scenario: 70008 Add New Reseller Partner  -- Monthly -- Gold -- FR -- 600 GB -- Server Plan -- Coupon -- CC -- VAT -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  coupon              | vat number    | storage add on | cc number        |
      |   1    |  Gold            | France          | MozyPro France   | 600             |      yes     |  10PERCENTOFFOUTLINE | FR08410091490 |     10         | 4485393141463880 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70009 @bus @2.17 @add_new_partner @reseller @vat @env_dependent @coupon
  Scenario: 70009 Add New Reseller Partner  -- Monthly -- Platinum -- IT -- 400 GB -- Server Plan -- Coupon -- CC -- VAT
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  coupon              | vat number    | cc number        |
      |   1    |  Platinum        | Italy           | MozyPro UK       | 400             |      yes     |  10PERCENTOFFOUTLINE | IT03018900245 | 4916921703777575 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70010 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70010 Add New Reseller Partner  -- Monthly -- Silver -- AT -- 400 GB -- Net Terms
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  net terms |
      |   1    |  Silver          | Austria         | MozyPro France   | 400             |      yes   |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:zero]%>  |
    And I search and delete partner account by newly created partner company name

  @TC.70011 @bus @2.17 @add_new_partner @reseller @vat @env_dependent @coupon
  Scenario: 70011 Add New Reseller Partner  -- Monthly -- Gold -- BE -- 550 GB -- Server Plan -- Coupon -- Net Terms -- VAT
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  coupon              |  net terms | vat number   |
      |   1    |  Gold            | Belgium         | MozyPro UK       | 550             |      yes     |  10PERCENTOFFOUTLINE |      yes   | BE0883236072 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:zero]%>  |
    And I search and delete partner account by newly created partner company name

  @TC.70012 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70012 Add New Reseller Partner  -- Monthly -- Platinum -- FI -- 2048 GB -- Net Terms
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  net terms |
      |   1    |  Platinum        | Finland         | MozyPro France   | 2048            |      yes   |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:zero]%>  |
    And I search and delete partner account by newly created partner company name

  @TC.70013 @bus @2.17 @add_new_partner @reseller @env_dependent @coupon
  Scenario: 70013 Add New Reseller Partner  -- Yearly -- Silver -- PT -- 2000 GB -- Server Plan -- Coupon -- Net Terms -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  coupon              |  net terms | storage add on |
      |   12   |  Silver          | Portugal        | MozyPro Ireland  | 2000            |      yes     |  10PERCENTOFFOUTLINE |      yes   |     10         |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:zero]%>  |
    And I search and delete partner account by newly created partner company name

  @TC.70014 @bus @2.17 @add_new_partner @reseller @vat @env_dependent @coupon
  Scenario: 70014 Add New Reseller Partner  -- Yearly -- Gold -- IE -- 1000 GB -- Server Plan -- Coupon -- Net Terms -- VAT
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  coupon              |  net terms | vat number |
      |   12   |  Gold            | Ireland         | MozyPro Ireland  | 1000            |      yes     |  10PERCENTOFFOUTLINE |      yes   | IE9691104A |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:zero]%>  |
    And I search and delete partner account by newly created partner company name

  @TC.70015 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70015 Add New Reseller Partner  -- Yearly -- Platinum -- SE -- 1200 GB -- CC -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota | storage add on | cc number        |
      |   12   |  Platinum        | Sweden          | MozyPro Germany  | 1200            |     10         | 4581092111111122 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70016 @bus @2.17 @add_new_partner @reseller @vat @env_dependent @coupon
  Scenario: 70016 Add New Reseller Partner  -- Yearly -- Silver -- UK -- 500 GB -- Server Plan -- Coupon -- CC -- VAT -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under |  reseller quota |  server plan |  coupon              | vat number  | storage add on | cc number        |
      |   12   |  Silver          | United Kingdom  | MozyPro UK   | 500             |      yes     |  10PERCENTOFFOUTLINE | GB117223643 |     10         | 4916783606275713 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70017 @bus @2.17 @add_new_partner @reseller @vat @env_dependent @coupon
  Scenario: 70017 Add New Reseller Partner  -- Yearly -- Gold -- IT -- 800 GB -- Server Plan -- Coupon -- CC -- VAT
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  coupon              | vat number    | cc number        |
      |   12   |  Gold            | Italy           | MozyPro UK       | 800             |      yes     |  10PERCENTOFFOUTLINE | IT03018900245 | 4916921703777575 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

@TC.70018 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70018 Add New Reseller Partner  -- Yearly -- Platinum -- BG -- 600 GB -- Net Terms -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  net terms | storage add on |
      |   12   |  Platinum        | Bulgaria        | MozyPro Germany  | 600             |      yes   |     10         |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:zero]%>  |
    And I search and delete partner account by newly created partner company name

  @TC.70019 @bus @2.17 @add_new_partner @reseller @env_dependent @coupon
  Scenario: 70019 Add New Reseller Partner  -- Yearly -- Silver -- DE -- 2000 GB -- Server Plan -- Coupon -- Net Terms -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  coupon              |  net terms | storage add on |
      |   12   |  Silver          | Germany         | MozyPro Germany  | 2000            |      yes     |  10PERCENTOFFOUTLINE |      yes   |     10         |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:zero]%>  |
    And I search and delete partner account by newly created partner company name

  @TC.70020 @bus @2.17 @add_new_partner @reseller @vat @env_dependent @coupon
  Scenario: 70020 Add New Reseller Partner  -- Yearly -- Gold -- UK -- 600 GB -- Server Plan -- Coupon -- Net Terms -- VAT
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under |  reseller quota |  server plan |  coupon              |  net terms | vat number  |
      |   12   |  Gold            | United Kingdom  | MozyPro UK   | 600             |      yes     |  10PERCENTOFFOUTLINE |      yes   | GB117223643 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:zero]%>  |
    And I search and delete partner account by newly created partner company name

  @TC.70021 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70021 Add New Reseller Partner  -- Yearly -- Platinum -- UK -- 3000 GB -- CC -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under |  reseller quota | storage add on | billing country | cc number        |
      |   12   |  Platinum        | United Kingdom  | MozyPro UK   | 3000            |     10         | United Kingdom  | 4916783606275713 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70022 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70022 Add New Reseller Partner  -- Yearly -- Silver -- EL -- 600 GB -- Net Terms -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  net terms | storage add on |
      |   12   |  Silver          | Greece          | MozyPro France   | 600             |      yes   |     10         |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:zero]%>  |
    And I search and delete partner account by newly created partner company name

  @TC.70023 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70023 Add New Reseller Partner  -- Yearly -- Gold -- DK -- 850 GB -- Net Terms
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  net terms |
      |   12   |  Gold            | Denmark         | MozyPro UK       | 850             |      yes   |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:zero]%>  |
    And I search and delete partner account by newly created partner company name

  @TC.70024 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70024 Add New Reseller Partner  -- Yearly -- Platinum -- LU -- 2600 GB -- CC -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota | storage add on | cc number        |
      |   12   |  Platinum        | Luxembourg      | MozyPro Ireland  | 2600            |     10         | 4779531111111121 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70025 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70025 Add New Reseller Partner  -- BE -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Belgium         | MozyPro France   |     800        |      yes     | 5413271111111222 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70026 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70026 Add New Reseller Partner  -- BG -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Bulgaria        | MozyPro UK       |     800        |      yes     | 4169912111111121 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70027 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70027 Add New Reseller Partner  -- CZ -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Czech Republic  | MozyPro France   |     800        |      yes     | 5101420111111222 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70028 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70028 Add New Reseller Partner  -- DK -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Denmark         | MozyPro Ireland  |     800        |      yes     | 5578922111111122 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70029 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70029 Add New Reseller Partner  -- DE -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Germany         | MozyPro Germany  |     800        |      yes     | 4188181111111112 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70030 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70030 Add New Reseller Partner  -- EE -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Estonia         | MozyPro France   |     800        |      yes     | 4238370111111111 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70031 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70031 Add New Reseller Partner  -- EL -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Greece          | MozyPro France   |     800        |      yes     | 4532121111111111 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70032 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70032 Add New Reseller Partner  -- ES -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Spain           | MozyPro Ireland  |     800        |      yes     | 4328191211111111 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70033 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70033 Add New Reseller Partner  -- FR -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under    | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | France          | MozyPro France  |     800        |      yes     | 4485393141463880 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70034 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70034 Add New Reseller Partner  -- HR -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Croatia         | MozyPro Germany  |     800        |      yes     | 5437781111111222 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70035 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70035 Add New Reseller Partner  -- IE -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Ireland         | MozyPro Ireland  |     800        |      yes     | 4319402211111113 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70036 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70036 Add New Reseller Partner  -- IT -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Italy           | MozyPro France   |     800        |      yes     | 4916921703777575 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70037 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70037 Add New Reseller Partner  -- CY -- Yearly -- Gold -- 800 GB -- Server Plan -- Net Terms
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | net terms |
      |   12   |   Gold           | Cyprus          | MozyPro Germany  |     800        |      yes     |   yes     |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:zero]%>  |
    And I search and delete partner account by newly created partner company name

  @TC.70038 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70038 Add New Reseller Partner  -- LV -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Latvia          | MozyPro Ireland  |     800        |      yes     | 4405211111111122 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70039 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70039 Add New Reseller Partner  -- LT -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Lithuania       | MozyPro France   |     800        |      yes     | 4797121111111111 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70040 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70040 Add New Reseller Partner  -- LU -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Luxembourg      | MozyPro Ireland  |     800        |      yes     | 4779531111111121 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70041 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70041 Add New Reseller Partner  -- HU -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Hungary         | MozyPro Germany  |     800        |      yes     | 4333112111111111 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70042 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70042 Add New Reseller Partner  -- MT -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Malta           | MozyPro UK       |     800        |      yes     | 4313801111111121 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70043 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70043 Add New Reseller Partner  -- NL -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Netherlands     | MozyPro Ireland  |     800        |      yes     | 5100291111111111 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70044 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70044 Add New Reseller Partner  -- AT -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Austria         | MozyPro Ireland  |     800        |      yes     | 4548181211111124 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70045 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70045 Add New Reseller Partner  -- PL -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Poland          | MozyPro Ireland  |     800        |      yes     | 4023581211111111 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70046 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70046 Add New Reseller Partner  -- PT -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Portugal        | MozyPro France   |     800        |      yes     | 4556581910687747 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70047 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70047 Add New Reseller Partner  -- RO -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Romania         | MozyPro France   |     800        |      yes     | 4493590111111122 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70048 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70048 Add New Reseller Partner  -- SI -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Slovenia        | MozyPro Germany  |     800        |      yes     | 4493690111111112 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70049 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70049 Add New Reseller Partner  -- SK -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Slovakia        | MozyPro Ireland  |     800        |      yes     | 4544170111111122 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70050 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70050 Add New Reseller Partner  -- FI -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Finland         | MozyPro Ireland  |     800        |      yes     | 4920111111111112 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70051 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70051 Add New Reseller Partner  -- SE -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan |   cc number      |
      |   12   |   Gold           | Sweden          | MozyPro Germany  |     800        |      yes     | 4581092111111122 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.70052 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 70052 Add New Reseller Partner  -- UK -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | United Kingdom  | MozyPro UK   |     800        |      yes     | 4916783606275713 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      | today | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%>   | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name
