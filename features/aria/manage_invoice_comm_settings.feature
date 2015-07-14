Feature:
  As a Mozy Administrator
  I want to configure whether or not I want to receive account statements by email
  so that I'm not bothered by extra email

  Background:
    Given I log in bus admin console as administrator

  @TC.15229 @bus @2.0 @manage_invoice_communication_settings
  Scenario: 15229 Verify Receive Mozy Account Statements set to Yes for new partner in Bus
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Account Details section from bus admin console page
    Then Account details table should be:
      | description                       | value             |
      | Name:                             | @name (change)    |
      | Username/Email:                   | @email (change)   |
      | Password:                         | (hidden) (change) |
      | Receive Mozy Pro Newsletter?      | No (change)       |
      | Receive Mozy Email Notifications? | No (change)       |
      | Receive Mozy Account Statements?  | Yes (change)      |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.15230 @firefox @bus @2.0 @manage_invoice_communication_settings
  Scenario: 15230 Alter notification method between HTML email and Printable no email in Aria
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I wait for 10 seconds
    And I get partner aria id
    And API* I set newly created partner aria id account notification method to 8
    And I wait for 10 seconds
    Then API* Aria account should be:
      | notify_method_name   |
      | Printable (no Email) |
    When API* I set newly created partner aria id account notification method to 1
    And I wait for 10 seconds
    Then API* Aria account should be:
      | notify_method_name   |
      | HTML Email           |
    Then I search and delete partner account by newly created partner company name

  @TC.15495 @firefox @bus @2.0 @manage_invoice_communication_settings
  Scenario: 15495 Verify aria notification method when set Receive Mozy Account Statements to No
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I wait for 10 seconds
    And I get partner aria id
    When I act as newly created partner account
    And I set account Receive Mozy Account Statements option to No
    Then Account statement preference should be changed
    And I wait for 10 seconds
    And API* Aria account should be:
      | notify_method_name   |
      | HTML Email           |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.15718 @firefox @bus @2.0 @manage_invoice_communication_settings
  Scenario: 15718 Verify notification method set to HTML Email for new Monthly MozyPro partner
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I wait for 10 seconds
    And I get partner aria id
    And API* Aria account should be:
      | notify_method_name |
      | HTML Email         |
    Then I search and delete partner account by newly created partner company name

  @TC.17590 @firefox @bus @2.0 @manage_invoice_communication_settings
  Scenario: 17590 Verify notification method set to HTML Email for new Monthly MozyEnterprise partner
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    And I wait for 10 seconds
    And I get partner aria id
    And API* Aria account should be:
      | notify_method_name |
      | HTML Email         |
    Then I search and delete partner account by newly created partner company name

  @TC.17591 @firefox  @bus @2.0 @manage_invoice_communication_settings
  Scenario: 17591 Verify notification method set to HTML Email for new Monthly Reseller partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 100            |
    Then New partner should be created
    And I wait for 10 seconds
    And I get partner aria id
    And API* Aria account should be:
      | notify_method_name |
      | HTML Email         |
    Then I search and delete partner account by newly created partner company name





