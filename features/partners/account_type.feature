Feature: Account Type

  As a Business Analyst,
  I would like to tell the difference between trial, internal test and live accounts,
  So that I can filter out non-paying and temporary accounts for reports.

  Success Criteria:
  - Add an "account type" attribute. The values are: Live, Internal Test, or Trial.
  - Add a "sales origin" attribute. The values are: Web or Sales.
  - Add a "sales channel" attribute. Values are: Inside Sales, Velocity, Reseller.

  Background:
    Given I log in bus admin console as administrator

  @TC.20925 @BUG.98477 @v.2.4.3
  Scenario: Mozy-20925:Create a New Trial Partner
    When I add a new MozyEnterprise partner:
      | period | users | company name             | account type | sales channel |
      | 12     | 5     | Enterprise Trial Partner | Trial        | Inside Sales  |
    Then New partner should be created
    When I search partner by Enterprise Trial Partner
    And I view partner details by Enterprise Trial Partner
    Then partner account details should be:
    # No Sales Channel in partner details anymore for partners with ARIA id
      | Account Type   | Sales Origin |
      | Trial (change) | Sales        |
    And I delete partner account

  @TC.20923 @BUG.98477 @v.2.4.3
  Scenario: Mozy-20923:Create a New Internal Test Partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | company name                   | account type  |
      | 1      | Silver        | 10             | Reseller Internal Test Partner | Internal Test |
    Then New partner should be created
    When I search partner by Reseller Internal Test Partner
    And I view partner details by Internal Test - Reseller Internal Test Partner
    Then partner account details should be:
      | Account Type           | Sales Origin |
      | Internal Test (change) | Sales        |
    And I delete partner account

  @TC.20698 @BUG.98477 @v.2.4.3
  Scenario: Mozy-20698:Create a New Live Partner
    When I add a new MozyPro partner:
      | period | base plan | company name         | account type  | sales channel |
      | 1      | 10 GB     | MozyPro Live Partner | Live          | Inside Sales  |
    Then New partner should be created
    When I search partner by MozyPro Live Partner
    And I view partner details by MozyPro Live Partner
    Then partner account details should be:
      | Account Type  | Sales Origin |
      | Live (change) | Sales        |
    And I delete partner account

  @TC.20707 @BUG.98491 @BUG.98477 @v.2.4.3
  Scenario: Mozy-20707:Create a New Fortress Internal Test Sub Partner
    When I act as partner by:
      | name     | including sub-partners |
      | Fortress | no                     |
    And I add a new sub partner:
      | Company Name                       |
      | Fortress Internal Test Sub Partner |
    Then New partner should be created
    When I stop masquerading
    And I search partner by Fortress Internal Test Sub Partner
    And I view partner details by Fortress Internal Test Sub Partner
    Then partner account details should be:
      | Account Type | Sales Origin | Sales Channel |
      | N/A (change) | Sales        | N/A (change)  |
    And I delete partner account
