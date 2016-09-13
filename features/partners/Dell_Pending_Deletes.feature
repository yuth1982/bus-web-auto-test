Feature: delete partner without setting, Mozy Inc --> Fortress (BDS) --> MozyOEM --> Mozy Dell --> MozyPro/MozyEnterprise --> Customer Tenant L1 --> Customer Tenant L2

  Background:
    Given I log in bus admin console as administrator

  @TC.144460_02_01 @bus @delete_partner
  Scenario: Mozy-144460_02_01: Delete Dell Customer Tenant L1, check Customer Tenant L1 information
    When I act as partner by:
      | email                            |
      | mozyprotestonqa12@mozy.local.com |
    And I add a new sub partner:
      | Admin Name | Company Type |
      | testadmin  | MozyOntheBox |
    Then New partner should be created
    And SubPartner general information should be:
      | Status:         |
      | Active (change) |
    And I change pooled resource for the subpartner:
      | Desktop Storage | Desktop Devices |
      | 10              | 3               |

    When I get the subpartner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details default password

    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name


    When I act as newly created subpartner account

    And I add new user(s):
      | name              | storage_type | storage_limit | devices |
      | tc_144460_01_user | Desktop      | 10            | 3       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by tc_144460_01_user
    And I update the user password to default password
    And I use keyless activation to activate devices
      | machine_name      | machine_type |
      | machine_144460_01 | Desktop      |
    Then activate machine result should be
      | code | body                                  |
      | 200  | {"license_key":"machine license key"} |
#    And I build a new report:
#      | type            | name                  | frequency |
#      | Billing Summary | billing summary test  | Daily     |
#    Then Billing summary report should be created

    When I stop masquerading
    And I search and delete partner account by newly created subpartner company name

#    When I navigate to Manage Pending Deletes section from bus admin console page
#    And I search partners in pending-delete not available to purge by:
#      | name          |
#      | @company_name |
#    Then Partners in pending-delete not available to purge search results should be:
#      | Partner       |
#      | @company_name |

    When I search partner by newly created subpartner company name
    Then Partner search results should not be:
      | Partner       |
      | @company_name |
    When I search partner by:
      | name          | filter         |
      | @company_name | Pending Delete |
    Then Partner search results should not be:
      | Partner       |
      | @company_name |
    When I search partner by:
      | name          | filter  |
      | @company_name | Deleted |
    Then Partner search results should be:
      | Partner       |
      | @company_name |
    When I view partner details by newly created subpartner company name
    Then Partner general information should be:
      | Deleted: | Root Admin: |
      | today    | @root_admin |

    When I use keyless activation to activate devices unsuccessful
      | machine_name      | machine_type |
      | machine_144460_01 | Desktop      |
    Then activate machine result should be
      | code | body                      |
      | 401  | ERROR: COULD NOT FIND KEY |

#    When I navigate to user login page with partner ID oem.partners.com
#    And I log in bus admin console with user name @new_users[0].email and password reset password
#    Then Login page error message should be Your account has been suspended and cannot currently be accessed.

    When I navigate to user login page with partner ID oem.partners.com
    And I log in bus admin console with user name @new_users[0].email and password reset password
    Then Login page error message should be Incorrect email or password.

#    When I navigate to bus admin console login page
#    And I log in bus admin console with user name @subpartner.admin_email_address and password reset password
#    Then Login page error message should be Your account has been suspended and cannot currently be accessed.

    When I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password reset password
    Then Login page error message should be Incorrect email or password.

#    When I wait for 86460 seconds
#    And I search emails by keywords:
#      | to               | content           |
#      | @new_admin_email | <%=@report.name%> |
#    Then I should see 0 email(s)
