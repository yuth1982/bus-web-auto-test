Feature: Add Sub_partner

  Background:
    Given I log in bus admin console as administrator

  @TC.21268 @add_sub_partner @tasks_p2 @bus
  Scenario: 21268 Enterprise partner creates sub with pooled storage
    When I add a new MozyEnterprise partner:
      | company name        | period | users | server plan  |
      | TC.21268_partner    | 12     | 200   | 12 TB        |
    Then New partner should be created
    Then Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 4.9 TB    | 4.9 TB   | 0    | 200       | 200      |
      | Server  | 0    | 12 TB     | 12 TB    | 0    | 200       | 200      |
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | Enterprise |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole    | yearly | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name         |
      | TC.21268_sub_partner |
    Then New partner should be created
    Then Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 0         | 0        | 0    | 0         | 0        |
      | Server  | 0    | 0         | 0        | 0    | 0         | 0        |
    Then the Server and Desktop pooled resource should be editable for the subpartner
    And I stop masquerading
    And I search and delete partner account by TC.21268_sub_partner
    And I search and delete partner account by TC.21268_partner




