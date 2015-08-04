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
      | ID          | Aria ID  | Partner       | Created | Root Admin   | Type            | Request Date | Days Remaining |
      | @partner_id | @aria_id | @company_name | today   | @admin_email | MozyEnterprise  | today        | 2 months       |

  @TC.119214 @bus
  Scenario: 119214:Verify that purged partners appear in the "Partners who have been purged" table
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 12     |  Silver       | 100            | yes       |
    Then New partner should be created
    And I get the partner_id
    When I get partner aria id
    And I search and delete partner account by newly created partner company name
    Then I navigate to Manage Pending Deletes section from bus admin console page
    And I search partners in pending-delete not available to purge by:
      | name          |
      | @company_name |
    Then Partners in pending-delete not available to purge search results should be:
      | ID          | Aria ID  | Partner       | Created | Root Admin   | Type      | Request Date |
      | @partner_id | @aria_id | @company_name | today   | @admin_email | Reseller  | today        |
    Then I change to 0 days to purge account after delete
    And I verify days to purge account after delete should be 0
    And I search partners in pending-delete available to purge by:
      | name          | full search |
      | @company_name | yes         |
    Then Partners in pending-delete available to purge search results should be:
      | ID          | Aria ID  | Partner       | Created | Root Admin   | Type      | Request Date | Days Pending |
      | @partner_id | @aria_id | @company_name | today   | @admin_email | Reseller  | today        | 1 minute     |
    And I purge partner by newly created partner company name
    And I search partners in who have been purged by:
      | name          | full search |
      | @company_name | yes         |
    Then Partners in who have been purged search results should be:
      | ID          | Aria ID  | Partner       | Created | Root Admin   | Type      | Request Date | Date Purged |
      | @partner_id | @aria_id | @company_name | today   | @admin_email | Reseller  | today        | today       |
    Then I change to 60 days to purge account after delete
    And I verify days to purge account after delete should be 60