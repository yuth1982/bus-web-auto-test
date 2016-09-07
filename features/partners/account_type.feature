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

  @TC.20925 @BUG.98477 @v.2.4.3 @bus @regression
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

  @TC.20923 @BUG.98477 @v.2.4.3 @bus @regression
  Scenario: Mozy-20923:Create a New Internal Test Partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | company name                   | account type  |
      | 1      | Silver        | 10             | Reseller Internal Test Partner | Internal Test |
    Then New partner should be created
    When I search partner by Reseller Internal Test Partner
    And I view partner details by Reseller Internal Test Partner
    Then partner account details should be:
      | Account Type           | Sales Origin |
      | Internal Test (change) | Sales        |
    And I delete partner account

  @TC.20698 @BUG.98477 @v.2.4.3 @bus @regression
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

  @TC.20707 @BUG.98491 @BUG.98477 @v.2.4.3  @bus @regression
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

  @TC.20702
  Scenario: Mozy-20702: Create a New Mozypro Internal Test Partner
    When I add a new MozyPro partner:
      | period | base plan | account type  | sales channel |
      | 1      | 10 GB     | Internal Test | Inside Sales  |
    Then New partner should be created
    And I check partner's root role should be SMB Bundle Limited
    And I search and delete partner account by newly created partner company name

  @TC.20703
  Scenario: Mozy-20703: Create a New MozyPro Trial Partner
    When I add a new MozyPro partner:
      | period | base plan | account type | sales channel |
      | 1      | 10 GB     | Trial        | Inside Sales  |
    Then New partner should be created
    And I check partner's root role should be SMB Bundle Limited
    And I search and delete partner account by newly created partner company name

  @TC.20705
  Scenario: Mozy-20705: Create a New Enterprise Internal Velocity Test Partner
    When I add a new MozyEnterprise partner:
      | period | account type  | sales channel | Root role     |
      | 12     | Internal Test | Inside Sales  | Velocity Root |
    Then New partner should be created
    And I check partner's root role should be Enterprise
    And I search and delete partner account by newly created partner company name

  @TC.20922
  Scenario: Mozy-20922: Create a New Reseller Trial Partner
    When I add a new Reseller partner:
      | period | base plan | account type | sales channel |
      | 1      | 10 GB     | Trial        | Reseller      |
    Then New partner should be created
    And I check partner's root role should be Reseller Root
    And I search and delete partner account by newly created partner company name

  @TC.20924
  Scenario: Mozy-20924: Create a New Reseller Live Partner
    When I add a new Reseller partner:
      | period | base plan | account type | sales channel |
      | 1      | 10 GB     | Live         | Reseller      |
    Then New partner should be created
    And I check partner's root role should be Reseller Root
    And I search and delete partner account by newly created partner company name

  @TC.20926
  Scenario: Mozy-20926: Create a New Enterprise Internal Test Partner
    When I add a new MozyEnterprise partner:
      | period | users | account type  | sales channel |
      | 12     | 5     | Internal Test | Inside Sales  |
    Then New partner should be created
    And I check partner's root role should be Enterprise
    And I search and delete partner account by newly created partner company name

  @TC.20927
  Scenario: Mozy-20927: Create a New Enterprise Live Partner
    When I add a new MozyEnterprise partner:
      | period | users | account type  | sales channel |
      | 12     | 5     | Live          | Inside Sales  |
    Then New partner should be created
    And I check partner's root role should be Enterprise
    And I search and delete partner account by newly created partner company name

  @TC.22138
  Scenario: Mozy-22138: Order Summary for Enterprise Velocity partner
    When I add a new MozyEnterprise partner:
      | period | users | account type  | sales channel |
      | 12     | 5     | Live          | Velocity      |
    Then New partner should be created
    And I get partner aria id
    When API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | balance |
      | 0       |
    And I search and delete partner account by newly created partner company name

  @TC.131834
  Scenario: Mozy-131834: Add Value Lifetime Free to Account Type Picklist
    When I add a new MozyPro partner:
      | period | base plan | account type  | sales channel |
      | 1      | 10 GB     | Internal Test | Inside Sales  |
    Then New partner should be created
    When I log in bus admin console as administrator
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then I change account type to Lifetime Free
    Then account type should be changed to Lifetime Free successfully
    And I search and delete partner account by newly created partner company name