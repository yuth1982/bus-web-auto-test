Feature: manage price schedules - billed partner

  Background:
   Given I log in bus admin console as administrator


  @TC.15666 @bus @aria @tasks_p2
  Scenario: 15666:BILL.18004 Verify that MozyPro Plans are migrated into Aria with the appropriate plan names
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 1      | 250 GB    | yes         |
    Then New partner should be created
    And I get partner aria id
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
     | aria plan                                       |
     | Monthly EN                                      |
     | MozyPro 250 GB Plan (Monthly)                   |
     | MozyPro Server Add-on for 250 GB Plan (Monthly) |
    And I delete partner account
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on | create under    | net terms | country |
      | 12      | Gold          | 200            | 2              | MozyPro Germany | yes       | Germany |
    Then New partner should be created
    And I get partner aria id
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | aria plan                                  |
      | Annual DE                                  |
      | Mozy Reseller GB - Gold (Annual)           |
      | Mozy Reseller 20 GB add-on - Gold (Annual) |
    And I delete partner account
    When I add a new MozyPro partner:
      | period | base plan | server plan | create under   | net terms |  country |
      | 24     | 250 GB    | yes         | MozyPro France | yes       |  France  |
    Then New partner should be created
    And I get partner aria id
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | aria plan                                        |
      | Biennial FR                                      |
      | MozyPro 250 GB Plan (Biennial)                   |
      | MozyPro Server Add-on for 250 GB Plan (Biennial) |
    And I delete partner account
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | storage add on | net terms |
      | 1      | Platinum      | 500            | 10             | yes       |
    Then New partner should be created
    And I get partner aria id
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | aria plan                                       |
      | Monthly EN                                      |
      | Mozy Reseller GB - Platinum (Monthly)           |
      | Mozy Reseller 20 GB add-on - Platinum (Monthly) |
    And I delete partner account

  @TC.15666 @bus @aria @tasks_p2
  Scenario: 15666:BILL.18004 Verify that MozyPro UK Ireland Plans are migrated into Aria with the appropriate plan names
    When I add a new MozyPro partner:
      | period | base plan | server plan | create under | net terms | country        |
      | 12     | 32 TB     | yes         | MozyPro UK   | yes       | United Kingdom |
    Then New partner should be created
    And I get partner aria id
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | aria plan                                     |
      | Annual EN                                     |
      | MozyPro 32 TB Plan (Annual)                   |
      | MozyPro Server Add-on for 32 TB Plan (Annual) |
    And I delete partner account
    When I add a new MozyPro partner:
      | period | base plan | create under    | net terms | country |
      | 1      | 16 TB     | MozyPro Ireland | yes       | Ireland |
    Then New partner should be created
    And I get partner aria id
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | aria plan                    |
      | Monthly EN                   |
      | MozyPro 16 TB Plan (Monthly) |
    And I delete partner account
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | create under | net terms | country        |
      | 12      | Silver        | 10             | MozyPro UK   | yes       | United Kingdom |
    Then New partner should be created
    And I get partner aria id
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | aria plan                          |
      | Annual EN                          |
      | Mozy Reseller GB - Silver (Annual) |
    And I delete partner account
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | storage add on | create under    | net terms | country |
      | 1      | Gold          | 10             | yes         | 10             | MozyPro Ireland | yes       | Ireland |
    Then New partner should be created
    And I get partner aria id
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | aria plan                                    |
      | Monthly EN                                   |
      | Mozy Reseller GB - Gold (Monthly)            |
      | Mozy Reseller Server Add-on - Gold (Monthly) |
      | Mozy Reseller 20 GB add-on - Gold (Monthly)  |
    And I delete partner account

  @TC.15666 @bus @aria @tasks_p2
  Scenario: 15666:BILL.18004 Verify that MozyEnterprise DPS Plans are migrated into Aria with the appropriate plan names
    When I add a new MozyEnterprise DPS partner:
      | period | base plan | country       | sales channel |
      | 12     | 2         | United States | Velocity      |
    Then New partner should be created
    And I get partner aria id
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | aria plan                            |
      | Annual EN                            |
      | MozyEnterprise for DPS 1 TB (Annual) |
    And I delete partner account
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on | country       |
      | 24     | 200   | 250 GB      | 10            | United States |
    Then New partner should be created
    And I get partner aria id
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | aria plan                                               |
      | Biennial EN                                             |
      | MozyEnterprise User (Biennial)                          |
      | MozyEnterprise 250 GB Server Plan (Biennial)            |
      | 250 GB Add-on for MozyEnterprise Server Plan (Biennial) |
    And I delete partner account

  @TC.18752 @bus @aria @tasks_p2
  Scenario: 18752 Change plan will reflect the price schedule for a partner
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 1      | 50 GB     | yes         |
    Then New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                             |
      | 10 GB, $9.99                     |
      | 50 GB, $19.99 (current purchase) |
      | 100 GB, $39.99                   |
      | 250 GB, $94.99                   |
      | 500 GB, $189.99                  |
      | 1 TB, $379.99                    |
      | 2 TB, $749.99                    |
      | 4 TB, $1,439.99                  |
      | 8 TB, $2,879.98                  |
      | 12 TB, $4,319.97                 |
      | 16 TB, $5,759.96                 |
      | 20 TB, $7,199.95                 |
      | 24 TB, $8,639.94                 |
      | 28 TB, $10,079.93                |
      | 32 TB, $11,519.92                |
    And Add-ons price should be Server Plan, $6.99
    When API* I change aria supplemental plan for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency |
      | MozyPro 50 GB Plan (Monthly)                   | Non-profit Discount | usd               |
      | MozyPro Server Add-on for 50 GB Plan (Monthly) | Non-profit Discount | usd               |
    And I wait for 10 seconds
    And I refresh Change Plan section
    Then MozyPro available base plans and price should be:
      | plan                             |
      | 10 GB, $8.00                     |
      | 50 GB, $17.99 (current purchase) |
      | 100 GB, $35.99                   |
      | 250 GB, $85.49                   |
      | 500 GB, $170.99                  |
      | 1 TB, $341.99                    |
      | 2 TB, $674.99                    |
      | 4 TB, $1,295.99                  |
      | 8 TB, $2,591.98                  |
      | 12 TB, $3,887.97                 |
      | 16 TB, $5,183.96                 |
      | 20 TB, $6,479.96                 |
      | 24 TB, $7,775.95                 |
      | 28 TB, $9,071.94                 |
      | 32 TB, $10,367.93                |
    And Add-ons price should be Server Plan, $6.29
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.18753 @bus @aria @tasks_p2
  Scenario: 18753 Billing History will reflect the price schedule for a partner
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 12     | 250 GB    | yes         |
    Then New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I navigate to Billing History section from bus admin console page
    And Billing history table should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | $1,220.78 | $1,220.78  | $0.00       |
    When API* I change aria supplemental plan for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 250 GB Plan (Annual)                   | Non-profit Discount | usd               | 2              |
      | MozyPro Server Add-on for 250 GB Plan (Annual) | Non-profit Discount | usd               | 3              |
    When I navigate to Billing Information section from bus admin console page
    Then Next renewal info table should be:
      | Period          | Date          | Amount                                 | Payment Type                  |
      | Yearly (change) | after 1 years | $2,355.70 (Without taxes or discounts) | Visa ending in @XXXX (change) |
    Then Next renewal supplemental plan details should be:
      | Number purchased | Price each | Total price for 250 GB |
      | 2                | $940.40    | $1,880.80              |
    Then Next renewal supplemental plan server plan details should be:
      | Number purchased | Price each | Total price for Server Plan |
      | 3                | $158.30    | $474.90                     |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18788 @bus @aria @tasks_p2
  Scenario: 18788 Price schedules and tiers cannot be chosen for a given customer within the Mozy
    When I navigate to Add New Partner section from bus admin console page
    Then Rate schedule can not be choosen when add partner
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 12     | 250 GB    | yes         |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then Rate schedule can not be choosen when change plan
    When I stop masquerading
    And I search and delete partner account by newly created partner company name