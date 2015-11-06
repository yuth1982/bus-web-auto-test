Feature: View/Edit Details: Account Details

  Background:
    Given I log in bus admin console as administrator

# Edit partner info
  @TC.122386 @edit_account_details @tasks_p2 @bus
  Scenario: 122386 Edit a partners contact info
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 4 TB      | yes       |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    And I open partner details by partner name in header
    And I change contact country and VAT number default password
      | Country |
      | China   |
    Then Change contact country and VAT number should succeed and the message should be:
    """
    Your contact country was successfully updated.
    """
    And I expand contact info from partner details section
    When I change the partner contact information default password
      | Contact Address: | Contact Email:              | Contact City: | Contact ZIP/Postal Code: | Phone:     | Contact State: | Industry:    | # of employees: |
      | test address     | mozybus+auto+chg1@gmail.com | test city     | 5214                     | 1234567890 | BC             | Accounting   | 6-20            |
    Then Partner contact information is changed
    And Partner contact information should be:
      | Contact Address: | Contact Email:              | Contact Country:    | Contact City: | Contact ZIP/Postal Code: | Phone:     | Contact State: | Industry:    | # of employees: |
      | test address     | mozybus+auto+chg1@gmail.com | China               | test city     | 5214                     | 1234567890 | BC             | Accounting   | 6-20            |
    And I log out bus admin console
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

# Parent can modify sub partner resources#99625
  @TC.21174 @edit_account_details @tasks_p2 @bus
  Scenario: 21174 Enterprise Partner with Sub add storage to Sub
    When I add a new MozyEnterprise partner:
      | company name        | period | users | server plan | net terms | root role  |
      | TC.21174_partner    | 12     | 18    | 100 GB      | yes       | FedID role |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name         |
      | TC.21174_sub_partner |
    Then New partner should be created
    And I change pooled resource for the subpartner:
      | Server Storage |
      | 101            |
    Then pooled resource shouldn't be changed and the error message should be:
    """
    Validation failed: Pool policy assigned Server storage can only be assigned between 0 and 100 GB.
    """
    And I change pooled resource for the subpartner:
      | Server Storage |
      | 99             |
    Then Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 0         | 0        | 0    | 0         | 0        |
      | Server  | 0    | 99 GB     | 99 GB    | 0    | 0         | 0        |
    And I stop masquerading
    When I search partner by:
      | name              |
      | TC.21174_partner  |
    And I view partner details by TC.21174_partner
    And I expand contact info from partner details section
    Then Partner pooled storage information should be:
      |         | Used | Available | Subpartner | Assigned  | Used | Available | Assigned |
      | Desktop | 0    | 450 GB    | 0          | 450 GB    | 0    | 18        | 18        |
      | Server  | 0    | 1 GB      | 99 GB      | 100 GB    | 0    | 200       | 200      |
    And I act as partner by:
      | name               |
      | TC.21174_partner   |
    When I search partner by:
      | name                  |
      | TC.21174_sub_partner  |
    And I view partner details by TC.21174_sub_partner
    And I change pooled resource for the subpartner:
      | Server Devices |
      | 201            |
    Then pooled resource shouldn't be changed and the error message should be:
    """
    You can not assign more licenses than are available in your parent.
    """
    And I change pooled resource for the subpartner:
      | Server Devices |
      | 199            |
    Then Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 0         | 0        | 0    | 0         | 0        |
      | Server  | 0    | 99 GB     | 99 GB    | 0    | 199       | 199      |
    And I stop masquerading
    When I search partner by:
      | name              |
      | TC.21174_partner  |
    And I view partner details by TC.21174_partner
    And I expand contact info from partner details section
    Then Partner pooled storage information should be:
      |         | Used | Available | Subpartner | Assigned  | Used | Available | Subpartner | Assigned |
      | Desktop | 0    | 450 GB    | 0          | 450 GB    | 0    | 18        | 0          | 18       |
      | Server  | 0    | 1 GB      | 99 GB      | 100 GB    | 0    | 1         | 199        | 200      |
    And I delete partner account
    And I search and delete partner account by TC.21174_sub_partner


