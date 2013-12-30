Feature: The capabilities that govern the HIPAA compliant root admin role should not allow admin to create a sub admin and activate them in the admin console. The only option is for admin to send email to the sub admin to require them to activate their account

  Background:
    Given I log in bus admin console as administrator

  @TC.120082
  Scenario: 120082 [MozyEnterprise]Hipaa sub admin cannot see the activate admin link in admin console
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | root role  | security |
      | 12     | 18    | 100 GB      | yes       | FedID role | HIPAA    |
    Then New partner should be created
    When I view the newly created partner admin details
    Then I will see the activate admin link
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name   | Roles      |
      | ATC695 | FedID role |
    When I view the admin details of ATC695
    Then I will not see the activate admin link
    And I close the admin details section
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name | Type                            | Parent     |
      | role | <%=@partner.company_info.name%> | FedID role |
    And I check all the capabilities for the new role
    And I close the role details section
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name   | Roles |
      | ATC696 | role  |
    When I view the admin details of ATC696
    Then I will not see the activate admin link
    And I close the admin details section

    And I refresh the add new role section
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes | Desktop Price per key | Desktop Min keys | Desktop Price per gigabyte | Desktop Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                    | 1               | 1                         | 1                    | 1                     | 1                | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I add a new sub partner:
      | Company Name | Pricing Plan | Admin Name |
      | subpartner   | subplan      | subadmin   |
    Then New partner should be created
    When I view the newly created subpartner admin details
    Then I will not see the activate admin link
    And I act as newly created subpartner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name   | Roles   |
      | ATC696 | subrole |
    When I view the admin details of ATC696
    Then I will not see the activate admin link
    Then I stop masquerading from subpartner
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.120087
  Scenario: [Reseller]120087 Hipaa sub admin cannot see the activate admin link in admin console
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms | security |
      | 12     | Silver        | 100            | yes       | HIPAA    |
    Then New partner should be created
    When I view the newly created partner admin details
    Then I will see the activate admin link
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name   | Roles         |
      | ATC695 | Reseller Root |
    When I view the admin details of ATC695
    Then I will not see the activate admin link
    And I close the admin details section
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name | Type                            | Parent        |
      | role | <%=@partner.company_info.name%> | Reseller Root |
    And I check all the capabilities for the new role
    And I close the role details section
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name   | Roles |
      | ATC696 | role  |
    When I view the admin details of ATC696
    Then I will not see the activate admin link
    And I close the admin details section

    And I refresh the add new role section
    And I add a new role:
      | Name    | Type          | Parent        |
      | subrole | Partner admin | Reseller Root |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I add a new sub partner:
      | Company Name | Pricing Plan | Admin Name |
      | subpartner   | subplan      | subadmin   |
    Then New partner should be created
    When I view the newly created subpartner admin details
    Then I will not see the activate admin link
    And I act as newly created subpartner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name   | Roles   |
      | ATC696 | subrole |
    When I view the admin details of ATC696
    Then I will not see the activate admin link
    Then I stop masquerading from subpartner
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name
    
  @TC.120085
  Scenario: 120085 [OEM]Hippa admin cannot see the activate admin link in admin console
    When I add a new OEM partner:
      | Root role     | Security | Company Type |
      | ITOK OEM Root | HIPAA    | OEM          |
    Then New partner should be created
    When I view the newly created subpartner admin details
    Then I will see the activate admin link
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name   | Roles    |
      | ATC695 | ITOK OEM Root |
    When I view the admin details of ATC695
    Then I will not see the activate admin link
    And I close the admin details section
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name | Type                          | Parent        |
      | role | <%=@subpartner.company_name%> | ITOK OEM Root |
    And I check all the capabilities for the new role
    And I close the role details section
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name   | Roles |
      | ATC696 | role  |
    When I view the admin details of ATC696
    Then I will not see the activate admin link
    And I close the admin details section

    And I refresh the add new role section
    And I add a new role:
      | Name    | Type          | Parent        |
      | subrole | Partner admin | ITOK OEM Root |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for OEM partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes | Desktop Price per key | Desktop Min keys | Desktop Price per gigabyte | Desktop Min gigabytes | Grandfathered Price per key | Grandfathered Min keys | Grandfathered Price per gigabyte | Grandfathered Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                    | 1               | 1                         | 1                    | 1                     | 1                | 1                          | 1                     | 1                           | 1                      | 1                                | 1                           |
    And I add a new sub partner:
      | Company Name | Pricing Plan | Admin Name |
      | subpartner   | subplan      | subadmin   |
    Then New partner should be created
    When I view the newly created subpartner admin details
    Then I will not see the activate admin link
    And I act as newly created subpartner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name   | Roles   |
      | ATC696 | subrole |
    When I view the admin details of ATC696
    Then I will not see the activate admin link
    Then I stop masquerading from subpartner
    And I search and delete partner account by newly created subpartner company name

  @TC.120088
  Scenario: 120088 [MozyEnterprise]Hipaa admin cannot see the password policy link in admin console
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | root role  | security |
      | 12     | 18    | 100 GB      | yes       | FedID role | HIPAA    |
    Then New partner should be created
    When I act as newly created partner account
    Then I will not see the Password Policy link from navigation links
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I add a new sub partner:
      | Company Name | Pricing Plan | Admin Name |
      | subpartner   | subplan      | subadmin   |
    Then New partner should be created
    And I act as newly created subpartner account
    Then I will not see the Password Policy link from navigation links
    Then I stop masquerading from subpartner
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.120089
  Scenario: [Reseller]120089 Hipaa admin cannot see the password policy link in admin console
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms | security |
      | 12     | Silver        | 100            | yes       | HIPAA    |
    Then New partner should be created
    And I act as newly created partner account
    Then I will not see the Password Policy link from navigation links
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent        |
      | subrole | Partner admin | Reseller Root |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I add a new sub partner:
      | Company Name | Pricing Plan | Admin Name |
      | subpartner   | subplan      | subadmin   |
    Then New partner should be created
    And I act as newly created subpartner account
    Then I will not see the Password Policy link from navigation links
    Then I stop masquerading from subpartner
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.120090
  Scenario: 120090 [OEM]Hippa admin cannot see the password policy link in admin console
    When I add a new OEM partner:
      | Security |
      | HIPAA    |
    Then New partner should be created
    When I view the newly created subpartner admin details
    And I act as newly created partner account
    Then I will not see the Password Policy link from navigation links
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | subrole | Partner admin |
    And I check all the capabilities for the new role
    And I add a new sub partner:
      | Company Name | Admin Name |
      | subpartner   | subadmin   |
    Then New partner should be created
    And I act as newly created subpartner account
    Then I will not see the Password Policy link from navigation links
    Then I stop masquerading from subpartner
    And I search and delete partner account by newly created subpartner company name
