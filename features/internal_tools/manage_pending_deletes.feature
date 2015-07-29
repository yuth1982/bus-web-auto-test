Feature: Manage Pending Deletes in Internal Tools in Admin Console

  Background:
    Given I log in bus admin console as administrator

  @TC.120569 @bus
  Scenario: 120569:Pending delete for Enterprise partner
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 5     |
    Then New partner should be created
    When I get the partner_id
    When I get partner aria id
    And I search and delete partner account by newly created partner company name
    Then I navigate to Manage Pending Deletes section from bus admin console page
    And I search partners in pending-delete not available to purge by:
      | email          | full search |
      | @admin_email | yes         |
    Then Partners in pending-delete not available to purge search results should be:
      | ID          | Aria ID  | Partner       | Created | Root Admin   | Type            | Request Date |Days Remaining |
      | @partner_id | @aria_id | @company_name | today   | @admin_email | MozyEnterprise  | today        |2 months       |