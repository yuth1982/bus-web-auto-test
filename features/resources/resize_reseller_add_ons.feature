Feature: Resize Reseller Gold & Platinum Partners add-ons to 20 GB add-on

  Background:
    Given I log in bus admin console as administrator

  @TC.20180 @bus @resizing_reseller_add-ons_plan
  Scenario: 20180 Create New Gold Reseller - Monthly - US - 20 GB Add on - Net Terms
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on | net terms |
      | 1       | Gold          | 200            | 2              | yes       |
    And Order summary table should be:
      | Description             | Quantity |
      | GB - Gold Reseller      | 200      |
      | 20 GB add-on            | 2        |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |
    When I act as newly created partner
    And I navigate to Change Plan section from bus admin console page
    Then Reseller supplemental plans should be:
      | storage add on type | # storage add on | has server plan |
      | 20 GB add-on        | 2                | No              |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20181 @bus @resizing_reseller_add-ons_plan
  Scenario: 20181 Create New Platinum Reseller - Monthly - US - 20 GB Add on - Net Terms
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on | net terms |
      | 1       | Platinum      | 200            | 2              | yes       |
    And Order summary table should be:
      | Description             | Quantity |
      | GB - Platinum Reseller  | 200      |
      | 20 GB add-on            | 2        |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |
    When I act as newly created partner
    And I navigate to Change Plan section from bus admin console page
    Then Reseller supplemental plans should be:
      | storage add on type | # storage add on | has server plan |
      | 20 GB add-on        | 2                | No              |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20182 @bus @resizing_reseller_add-ons_plan
  Scenario: 20182 Create New Gold Reseller - Yearly - UK - 20 GB Add on - Net Terms
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on | country        | create under | net terms |
      | 12      | Gold          | 200            | 2              | United Kingdom | MozyPro UK   | yes       |
    And Order summary table should be:
      | Description         | Quantity |
      | GB - Gold Reseller  | 200      |
      | 20 GB add-on        | 2        |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |
    When I act as newly created partner
    And I navigate to Change Plan section from bus admin console page
    Then Reseller supplemental plans should be:
      | storage add on type | # storage add on | has server plan |
      | 20 GB add-on        | 2                | No              |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20183 @bus @resizing_reseller_add-ons_plan
  Scenario: 20183 Create New Platinum Reseller - Yearly - UK - 20 GB Add on - Net Terms
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on | country        | create under | net terms |
      | 12      | Platinum      | 200            | 2              | United Kingdom | MozyPro UK   | yes       |
    And Order summary table should be:
      | Description            | Quantity |
      | GB - Platinum Reseller | 200      |
      | 20 GB add-on           | 2        |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |
    When I act as newly created partner
    And I navigate to Change Plan section from bus admin console page
    Then Reseller supplemental plans should be:
      | storage add on type | # storage add on | has server plan |
      | 20 GB add-on        | 2                | No              |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20184 @bus @resizing_reseller_add-ons_plan
  Scenario: 20184 Create New Gold Reseller - Yearly - FR - 20 GB Add on - Net Terms
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on | country | create under   | net terms |
      | 12      | Gold          | 200            | 2              | France  | MozyPro France | yes       |
    And Order summary table should be:
      | Description         | Quantity |
      | GB - Gold Reseller  | 200      |
      | 20 GB add-on        | 2        |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |
    When I act as newly created partner
    And I navigate to Change Plan section from bus admin console page
    Then Reseller supplemental plans should be:
      | storage add on type | # storage add on | has server plan |
      | 20 GB add-on        | 2                | No              |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20185 @bus @resizing_reseller_add-ons_plan
  Scenario: 20185 Create New Platinum Reseller - Yearly - FR - 20 GB Add on - Net Terms
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on | country | create under   | net terms |
      | 12      | Platinum      | 200            | 2              | France  | MozyPro France | yes       |
    And Order summary table should be:
      | Description            | Quantity |
      | GB - Platinum Reseller | 200      |
      | 20 GB add-on           | 2        |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |
    When I act as newly created partner
    And I navigate to Change Plan section from bus admin console page
    Then Reseller supplemental plans should be:
      | storage add on type | # storage add on | has server plan |
      | 20 GB add-on        | 2                | No              |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20186 @bus @resizing_reseller_add-ons_plan
  Scenario: 20186 Assign new Gold Reseller 20 GB add on plan in Aria
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on |
      | 12      | Gold          | 200            | 2              |
    And Order summary table should be:
      | Description        | Quantity |
      | GB - Gold Reseller | 200      |
      | 20 GB add-on       | 2        |
    And New partner should be created
    When I log in aria admin console as administrator
    And I search aria account by newly created partner admin email
    And I change Mozy Reseller 20 GB add-on - Gold (Annual) plan units to 3
    Then Supplemental plan units should be changed
    When I log in bus admin console as administrator
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |
    And I delete partner account

  @TC.20187 @bus @resizing_reseller_add-ons_plan
  Scenario: 20187 Assign new Platinum Reseller 20 GB add on plan in Aria
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on |
      | 12      | Platinum      | 200            | 2              |
    And Order summary table should be:
      | Description            | Quantity |
      | GB - Platinum Reseller | 200      |
      | 20 GB add-on           | 2        |
    And New partner should be created
    When I log in aria admin console as administrator
    And I search aria account by newly created partner admin email
    And I change Mozy Reseller 20 GB add-on - Platinum (Annual) plan units to 3
    Then Supplemental plan units should be changed
    When I log in bus admin console as administrator
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |
    And I delete partner account

  @TC.20188 @bus @resizing_reseller_add-ons_plan
  Scenario: 20188 Order plan in Change Plan - Gold Reseller - US - Monthly - 20 GB add on
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on |
      | 1       | Gold          | 200            | 2              |
    And Order summary table should be:
      | Description             | Quantity |
      | GB - Gold Reseller      | 200      |
      | 20 GB add-on            | 2        |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |
    When I act as newly created partner
    When I change Reseller account plan to:
      | storage add-on |
      | 3              |
    Then Reseller supplemental plans should be:
      | storage add on type | # storage add on | has server plan |
      | 20 GB add-on        | 3                | No              |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20189 @bus @resizing_reseller_add-ons_plan
  Scenario: 20189 Order plan in Change Plan - Platinum Reseller - US - Monthly - 20 GB add on
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on |
      | 1       | Platinum      | 200            | 2              |
    And Order summary table should be:
      | Description             | Quantity |
      | GB - Platinum Reseller  | 200      |
      | 20 GB add-on            | 2        |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |
    When I act as newly created partner
    When I change Reseller account plan to:
      | storage add-on |
      | 3              |
    Then Reseller supplemental plans should be:
      | storage add on type | # storage add on | has server plan |
      | 20 GB add-on        | 3                | No              |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20190 @bus @resizing_reseller_add-ons_plan
  Scenario: 20190 Return plan in Change Plan - Gold Reseller - US - Monthly - 20 GB add on
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on |
      | 1       | Gold          | 200            | 4              |
    And Order summary table should be:
      | Description             | Quantity |
      | GB - Gold Reseller      | 200      |
      | 20 GB add-on            | 4        |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 280       | 280      | 0    | Unlimited | Unlimited |
    When I act as newly created partner
    When I change Reseller account plan to:
      | storage add-on |
      | 3              |
    Then Reseller supplemental plans should be:
      | storage add on type | # storage add on | has server plan |
      | 20 GB add-on        | 3                | No              |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20191 @bus @resizing_reseller_add-ons_plan
  Scenario: 20191 Return plan in Change Plan - Platinum Reseller - US - Monthly - 20 GB add on
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on |
      | 1       | Platinum      | 200            | 4              |
    And Order summary table should be:
      | Description             | Quantity |
      | GB - Platinum Reseller  | 200      |
      | 20 GB add-on            | 4        |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 280       | 280      | 0    | Unlimited | Unlimited |
    When I act as newly created partner
    When I change Reseller account plan to:
      | storage add-on |
      | 3              |
    Then Reseller supplemental plans should be:
      | storage add on type | # storage add on | has server plan |
      | 20 GB add-on        | 3                | No              |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20194 @bus @resizing_reseller_add-ons_plan
  Scenario: 20194 Change Subscription Period of Gold Reseller - US - 20 GB Add on - Monthly to Yearly
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on |
      | 1       | Gold          | 200            | 2              |
    And Order summary table should be:
      | Description             | Quantity |
      | GB - Gold Reseller      | 200      |
      | 20 GB add-on            | 2        |
    And New partner should be created
    When I act as newly created partner
    And I change account subscription to annual billing period!
    Then Subscription changed message should be Your account has been changed to yearly billing.
    When I stop masquerading
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |
    And I delete partner account

  @TC.20195 @bus @resizing_reseller_add-ons_plan
  Scenario: 20195 Change Subscription Period of Platinum Reseller - US - 20 GB Add on - Monthly to Yearly
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on |
      | 1       | Platinum      | 200            | 2              |
    And Order summary table should be:
      | Description             | Quantity |
      | GB - Platinum Reseller  | 200      |
      | 20 GB add-on            | 2        |
    And New partner should be created
    When I act as newly created partner
    And I change account subscription to annual billing period!
    Then Subscription changed message should be Your account has been changed to yearly billing.
    When I stop masquerading
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |
    And I delete partner account

  @TC.20196 @bus @resizing_reseller_add-ons_plan
  Scenario: 20196 Change Subscription Period of Gold Reseller - UK - 20 GB Add on - Yearly to Monthly
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on | country        | create under |
      | 12      | Gold          | 200            | 2              | United Kingdom | MozyPro UK   |
    And Order summary table should be:
      | Description             | Quantity |
      | GB - Gold Reseller      | 200      |
      | 20 GB add-on            | 2        |
    And New partner should be created
    When I act as newly created partner
    And I change account subscription to monthly billing period
    Then Subscription changed message should be Your account will be switched to monthly billing schedule at your next renewal.
    When I stop masquerading
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |
    And I delete partner account

  @TC.20197 @bus @resizing_reseller_add-ons_plan
  Scenario: 20197 Change Subscription Period of Platinum Reseller - US - 20 GB Add on - Monthly to Yearly
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on | country        | create under |
      | 12      | Platinum      | 200            | 2              | United Kingdom | MozyPro UK   |
    And Order summary table should be:
      | Description             | Quantity |
      | GB - Platinum Reseller  | 200      |
      | 20 GB add-on            | 2        |
    And New partner should be created
    When I act as newly created partner
    And I change account subscription to monthly billing period
    Then Subscription changed message should be Your account will be switched to monthly billing schedule at your next renewal.
    When I stop masquerading
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |
    And I delete partner account

  @TC.20198 @bus @resizing_reseller_add-ons_plan
  Scenario: 20198 Change Subscription Period of Gold Reseller - FR - 20 GB Add on - Yearly to Monthly
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on | country | create under   |
      | 12      | Gold          | 200            | 2              | France  | MozyPro France |
    And Order summary table should be:
      | Description             | Quantity |
      | GB - Gold Reseller      | 200      |
      | 20 GB add-on            | 2        |
    And New partner should be created
    When I act as newly created partner
    And I change account subscription to monthly billing period
    Then Subscription changed message should be Your account will be switched to monthly billing schedule at your next renewal.
    When I stop masquerading
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |
    And I delete partner account

  @TC.20199 @bus @resizing_reseller_add-ons_plan
  Scenario: 20199 Change Subscription Period of Platinum Reseller - FR - 20 GB Add on - Monthly to Yearly
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on | country | create under   |
      | 12      | Platinum      | 200            | 2              | France  | MozyPro France |
    And Order summary table should be:
      | Description             | Quantity |
      | GB - Platinum Reseller  | 200      |
      | 20 GB add-on            | 2        |
    And New partner should be created
    When I act as newly created partner
    And I change account subscription to monthly billing period
    Then Subscription changed message should be Your account will be switched to monthly billing schedule at your next renewal.
    When I stop masquerading
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |
    And I delete partner account

  @TC.20200 @bus @resizing_reseller_add-ons_plan
  Scenario: 20200 Order plan in Change Plan - Gold Reseller - US - Yearly - 20 GB add on
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on |
      | 1       | Gold          | 200            | 2              |
    And Order summary table should be:
      | Description             | Quantity |
      | GB - Gold Reseller      | 200      |
      | 20 GB add-on            | 2        |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |
    When I act as newly created partner
    When I change Reseller account plan to:
      | storage add-on |
      | 4              |
    Then Reseller supplemental plans should be:
      | storage add on type | # storage add on | has server plan |
      | 20 GB add-on        | 4                | No              |
    When I stop masquerading
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 280       | 280      | 0    | Unlimited | Unlimited |
    And I delete partner account

  @TC.20201 @bus @resizing_reseller_add-ons_plan
  Scenario: 20201 Order plan in Change Plan - Platinum Reseller - US - Yearly - 20 GB add on
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on |
      | 1       | Platinum      | 200            | 2              |
    And Order summary table should be:
      | Description             | Quantity |
      | GB - Platinum Reseller  | 200      |
      | 20 GB add-on            | 2        |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |
    When I act as newly created partner
    When I change Reseller account plan to:
      | storage add-on |
      | 4              |
    Then Reseller supplemental plans should be:
      | storage add on type | # storage add on | has server plan |
      | 20 GB add-on        | 4                | No              |
    When I stop masquerading
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 280       | 280      | 0    | Unlimited | Unlimited |
    And I delete partner account

  @TC.20202 @bus @resizing_reseller_add-ons_plan
  Scenario: 20202 Order plan in Change Plan - Gold Reseller - UK - Yearly - 20 GB add on
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on | country        | create under |
      | 1       | Gold          | 200            | 2              | United Kingdom | MozyPro UK   |
    And Order summary table should be:
      | Description             | Quantity |
      | GB - Gold Reseller      | 200      |
      | 20 GB add-on            | 2        |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |
    When I act as newly created partner
    When I change Reseller account plan to:
      | storage add-on |
      | 4              |
    Then Reseller supplemental plans should be:
      | storage add on type | # storage add on | has server plan |
      | 20 GB add-on        | 4                | No              |
    When I stop masquerading
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 280       | 280      | 0    | Unlimited | Unlimited |
    And I delete partner account

  @TC.20203 @bus @resizing_reseller_add-ons_plan
  Scenario: 20203 Order plan in Change Plan - Platinum Reseller - UK - Yearly - 20 GB add on
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on | country        | create under |
      | 1       | Platinum      | 200            | 2              | United Kingdom | MozyPro UK   |
    And Order summary table should be:
      | Description             | Quantity |
      | GB - Platinum Reseller  | 200      |
      | 20 GB add-on            | 2        |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |
    When I act as newly created partner
    When I change Reseller account plan to:
      | storage add-on |
      | 4              |
    Then Reseller supplemental plans should be:
      | storage add on type | # storage add on | has server plan |
      | 20 GB add-on        | 4                | No              |
    When I stop masquerading
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 280       | 280      | 0    | Unlimited | Unlimited |
    And I delete partner account

  @TC.20204 @bus @resizing_reseller_add-ons_plan
  Scenario: 20204 Order plan in Change Plan - Gold Reseller - FR - Yearly - 20 GB add on
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on | country | create under   |
      | 1       | Gold          | 200            | 2              | France  | MozyPro France |
    And Order summary table should be:
      | Description             | Quantity |
      | GB - Gold Reseller      | 200      |
      | 20 GB add-on            | 2        |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |
    When I act as newly created partner
    When I change Reseller account plan to:
      | storage add-on |
      | 4              |
    Then Reseller supplemental plans should be:
      | storage add on type | # storage add on | has server plan |
      | 20 GB add-on        | 4                | No              |
    When I stop masquerading
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 280       | 280      | 0    | Unlimited | Unlimited |
    And I delete partner account

  @TC.20205 @bus @resizing_reseller_add-ons_plan
  Scenario: 20205 Order plan in Change Plan - Platinum Reseller - FR - Yearly - 20 GB add on
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on | country | create under   |
      | 1       | Platinum      | 200            | 2              | France  | MozyPro France |
    And Order summary table should be:
      | Description             | Quantity |
      | GB - Platinum Reseller  | 200      |
      | 20 GB add-on            | 2        |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |
    When I act as newly created partner
    When I change Reseller account plan to:
      | storage add-on |
      | 4              |
    Then Reseller supplemental plans should be:
      | storage add on type | # storage add on | has server plan |
      | 20 GB add-on        | 4                | No              |
    When I stop masquerading
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 280       | 280      | 0    | Unlimited | Unlimited |
    And I delete partner account
