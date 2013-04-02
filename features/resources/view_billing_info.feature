Feature: View billing information 

  Background:
    Given I log in bus admin console as administrator

  @TC.15253
  Scenario: 15253 Verify MozyPro partner master plan section details
    When I add a new MozyPro partner:
      | period | base plan |
      | 24     | 250 GB    |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal info table should be:
      | Period            | Date          | Amount                                 | Payment Type                  |
      | Biennial (change) | after 2 years | $1,994.79 (Without taxes or discounts) | Visa ending in @XXXX (change) |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.17976
  Scenario: 17976 Verify Reseller partner master plan section details
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal info table should be:
      | Period          | Date          | Amount                               | Payment Type                  |
      | Yearly (change) | after 1 years | $462.00 (Without taxes or discounts) | Visa ending in @XXXX (change) |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.15254
  Scenario: 15254 Verify MozyEnterprise partner master plan section details
    When I add a new MozyEnterprise partner:
      | period | users |
      | 36     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal info table should be:
      | Period          | Date          | Amount                               | Payment Type                  |
      | 3-year (change) | after 3 years | $259.00 (Without taxes or discounts) | Visa ending in @XXXX (change) |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.16658
  Scenario: 16658 Verify MozyPro partner supplemental plan section details
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 250 GB    |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal supplemental plan details should be:
      | Total price for 250 GB |
      | $94.99                 |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.15359
  Scenario: 15359 Verify MozyEnterprise Autogrow status is set to disabled by default
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then Autogrow details should be:
      | Status               |
      | Disabled (more info) |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.15360
  Scenario: 15360 Verify Reseller Autogrow status is set to disabled by default
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 100            |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then Autogrow details should be:
      | Status               |
      | Disabled (more info) |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.16659
  Scenario: 16659 Verify MozyEnterprise partner supplemental plan section details
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal supplemental plan details should be:
      | Total price for MozyEnterprise User |
      | $95.00                              |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.16660
  Scenario: 16660 Verify Reseller partner supplemental plan section details
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 100            |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal supplemental plan details should be:
      | Number purchased | Price each | Total price for GB - Silver Reseller |
      | 100              | $0.42      | $42.00                               |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.17517
  Scenario: 17517 Verify MozyPro VAT information in the billing information view
    When I add a new MozyPro partner:
      | period | base plan | server plan | country | vat number    |
      | 12     | 500 GB    | yes         | Italy   | IT03018900245 |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then VAT info should be:
      | VAT Number    |
      | IT03018900245 |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name