Feature: Supports on BUS

  Background:
    Given I log in bus admin console as administrator

  @TC.22472 @bus @support
  Scenario: 22472:Verify that contact works for DPS admin.
    When I add a new MozyEnterprise DPS partner:
      | period | base plan | country       |
      | 12     | 2         | United States |
    And New partner should be created
    Then I act as newly created partner account
    When I navigate to Contact section from bus admin console page
    And I click Community on contact section
    Then I login my support successfully
    When I log in bus admin console as administrator
    And I act as partner by:
    | email        |
    | @admin_email |
    When I navigate to Contact section from bus admin console page
    And I click Knowledge Base on contact section
    Then I login my support successfully
    When I log in bus admin console as administrator
    And I act as partner by:
      | email        |
      | @admin_email |
    When I navigate to Contact section from bus admin console page
    And I click Documentation on contact section
    Then I login my support successfully
    When I log in bus admin console as administrator
    And I act as partner by:
      | email        |
      | @admin_email |
    When I navigate to Contact section from bus admin console page
    And I click Create or update a support case
    Then I login my support successfully
    When I log in bus admin console as administrator
    And I act as partner by:
      | email        |
      | @admin_email |
    When I navigate to Contact section from bus admin console page
    And I click 24/7 Live Chat Support on contact section
    Then I login my support successfully
    Then I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.22479 @bus @support
  Scenario: 22479:Verify that Online Help works for DPS admin.
    When I add a new MozyEnterprise DPS partner:
      | period | base plan | country       |
      | 12     | 2         | United States |
    And New partner should be created
    Then I act as newly created partner account
    When I navigate to Online Help section from bus admin console page
    Then I check link Community is exists
    And I check link Knowledge Base is exists
    And I check link Documentation is exists
    And I check link My Support is exists
    Then I search with subject test
    And The search results title should include test
    Then I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

