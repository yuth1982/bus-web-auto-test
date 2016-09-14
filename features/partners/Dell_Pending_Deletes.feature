Feature: delete partner without setting, Mozy Inc --> Fortress (BDS) --> MozyOEM --> Mozy Dell --> MozyPro/MozyEnterprise --> Customer Tenant L1 --> Customer Tenant L2

  Background:
    Given I log in bus admin console as administrator

  @TC.144460_02_01 @bus @delete_partner
  Scenario: Mozy-144460_02_01: Delete Dell MozyPro Customer Tenant L1, check Customer Tenant L1 information
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
      | Server Storage | Server Devices |
      | 1              | 2              |

    When I get the subpartner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details default password

    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I act as newly created subpartner account
    And I add new user(s):
      | name              | storage_type | storage_limit | devices |
      | tc_144460_01_user | Server       | 1             | 2       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by tc_144460_01_user
    And I update the user password to default password
    And I activate linux machine using username newly created user email and password default password
    Then linux machine activation message should be AUTHENTICATED
#    And I use keyless activation to activate devices
#      | machine_name      | machine_type |
#      | machine_144460_01 | Server      |
#    Then activate machine result should be
#      | code | body                                  |
#      | 200  | {"license_key":"machine license key"} |
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

    When I activate linux machine using username newly created user email and password default password
    Then linux machine activation message should be Invalid credentials.  Re-enter your account information.
#    When I use keyless activation to activate devices unsuccessful
#      | machine_name      | machine_type |
#      | machine_144460_01 | Server       |
#    Then activate machine result should be
#      | code | body                          |
#      | 401  | ERROR: authorization required |

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

  @TC.144460_02_02 @bus @delete_partner
  Scenario: Mozy-144460_02_01: Delete Dell MozyEnterprise Customer Tenant L1, check Customer Tenant L1 information
    When I act as partner by:
      | email                                   |
      | mozyenterprisetestonqa12@mozy.local.com |
    And I add a new sub partner:
      | Admin Name | Company Type |
      | testadmin  | MozyOntheBox |
    Then New partner should be created
    And SubPartner general information should be:
      | Status:         |
      | Active (change) |
    And I change pooled resource for the subpartner:
      | Server Storage | Server Devices |
      | 1              | 2              |

    When I get the subpartner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details default password

    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I act as newly created subpartner account
    And I add new user(s):
      | name              | user_group           | storage_type | storage_limit | devices |
      | tc_144460_01_user | (default user group) | Server       | 1             | 2       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by tc_144460_01_user
    And I update the user password to default password
    And I activate linux machine using username newly created user email and password default password
    Then linux machine activation message should be AUTHENTICATED
#    And I use keyless activation to activate devices
#      | machine_name      | machine_type |
#      | machine_144460_01 | Server       |
#    Then activate machine result should be
#      | code | body                                  |
#      | 200  | {"license_key":"machine license key"} |
    And I build a new report:
      | type            | name                  | frequency |
      | Billing Summary | billing summary test  | Daily     |
    Then Billing summary report should be created
    And 1 report is scheduled for this partner

    When I stop masquerading
    And I search and delete partner account by newly created subpartner company name

    Then no report is scheduled for this partner

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

    When I activate linux machine using username newly created user email and password default password
    Then linux machine activation message should be Invalid credentials.  Re-enter your account information.
#    When I use keyless activation to activate devices unsuccessful
#      | machine_name      | machine_type |
#      | machine_144460_01 | Server       |
#    Then activate machine result should be
#      | code | body                          |
#      | 401  | ERROR: authorization required |

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

  @TC.144460_02_03 @bus @delete_partner
  Scenario: Mozy-144460_02_01: Delete Dell MozyEnterprise Customer Tenant L1, check Customer Tenant L2 information
    When I act as partner by:
      | email                                   |
      | mozyenterprisetestonqa12@mozy.local.com |
    And I add a new sub partner:
      | Company Name                   | Admin Name | Company Type |
      | TC.144460_02_03 parent partner | testadmin  | MozyOntheBox |
    Then New partner should be created
    And SubPartner general information should be:
      | Status:         |
      | Active (change) |
    And I change pooled resource for the subpartner:
      | Server Storage | Server Devices |
      | 1              | 2              |

    When I get the subpartner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details default password

    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I act as newly created subpartner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name         | Type          | Parent         |
      | new OEM role | Partner admin | MozyEnterprise |
    And I check all the capabilities for the new role
    And I add a new sub partner:
      | Admin Name | Company Type |
      | subadmin1  | MozyOntheBox |
    Then New partner should be created
    And SubPartner general information should be:
      | Status:         |
      | Active (change) |
    And I change pooled resource for the subpartner:
      | Server Storage | Server Devices |
      | 1              | 2              |

    When I get the subpartner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details default password

    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I act as newly created subpartner account
    And I add new user(s):
      | name              | user_group           | storage_type | storage_limit | devices |
      | tc_144460_01_user | (default user group) | Server       | 1             | 2       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by tc_144460_01_user
    And I update the user password to default password
    And I use keyless activation to activate devices
      | machine_name      | machine_type |
      | machine_144460_01 | Server      |
    Then activate machine result should be
      | code | body                                  |
      | 200  | {"license_key":"machine license key"} |
    And I build a new report:
      | type            | name                  | frequency |
      | Billing Summary | billing summary test  | Daily     |
    Then Billing summary report should be created
    And 1 report is scheduled for this partner

    When I stop masquerading
    And I search partner by TC.144460_02_03 parent partner
    And I view partner details by TC.144460_02_03 parent partner
    And I delete partner account

    Then 0 report is scheduled for this partner

#    When I navigate to Manage Pending Deletes section from bus admin console page
#    And I search partners in pending-delete not available to purge by:
#      | name          | full search |
#      | @company_name | yes         |
#    Then Partners in pending-delete not available to purge search results should be:
#      | Partner       |
#      | @company_name |

#    When I search partner by newly created subpartner company name
#    Then Partner search results should not be:
#      | Partner       |
#      | @company_name |
#    When I search partner by:
#      | name          | filter  |
#      | @company_name | Deleted |
#    Then Partner search results should not be:
#      | Partner       |
#      | @company_name |
#    When I search partner by:
#      | name          | filter         |
#      | @company_name | Pending Delete |
#    Then Partner search results should be:
#      | Partner       |
#      | @company_name |
#    When I view partner details by newly created subpartner company name
#    Then Partner general information should be:
#      | Pending | Root Admin: |
#      | today   | @root_admin |

    When I activate linux machine using username newly created user email and password default password
    Then linux machine activation message should be Invalid credentials.  Re-enter your account information.
#    When I use keyless activation to activate devices unsuccessful
#      | machine_name      | machine_type |
#      | machine_144460_01 | Server       |
#    Then activate machine result should be
#      | code | body                          |
#      | 401  | ERROR: authorization required |

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

  @TC.144460_02_04 @bus @delete_partner
  Scenario: Mozy-144460_02_01: Delete Dell MozyEnterprise Customer Tenant L2, check Customer Tenant L2 information
    When I act as partner by:
      | email                                   |
      | mozyenterprisetestonqa12@mozy.local.com |
    And I add a new sub partner:
      | Admin Name | Company Type |
      | testadmin  | MozyOntheBox |
    Then New partner should be created
    And SubPartner general information should be:
      | Status:         |
      | Active (change) |
    And I change pooled resource for the subpartner:
      | Server Storage | Server Devices |
      | 1              | 2              |
    Then New partner should be created

    When I get the subpartner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details default password

    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I act as newly created subpartner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name         | Type          | Parent         |
      | new OEM role | Partner admin | MozyEnterprise |
    And I check all the capabilities for the new role
    And I add a new sub partner:
      | Admin Name | Company Type |
      | subadmin1  | MozyOntheBox |
    Then New partner should be created
    And SubPartner general information should be:
      | Status:         |
      | Active (change) |
    And I change pooled resource for the subpartner:
      | Server Storage | Server Devices |
      | 1              | 2              |

    When I get the subpartner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details default password

    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I act as newly created subpartner account
    And I add new user(s):
      | name              | user_group           | storage_type | storage_limit | devices |
      | tc_144460_01_user | (default user group) | Server       | 1             | 2       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by tc_144460_01_user
    And I update the user password to default password
    And I use keyless activation to activate devices
      | machine_name      | machine_type |
      | machine_144460_01 | Server      |
    Then activate machine result should be
      | code | body                                  |
      | 200  | {"license_key":"machine license key"} |
    And I build a new report:
      | type            | name                  | frequency |
      | Billing Summary | billing summary test  | Daily     |
    Then Billing summary report should be created
    And 1 report is scheduled for this partner

    When I stop masquerading
    And I search and delete partner account by newly created subpartner company name

    Then no report is scheduled for this partner

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

    When I activate linux machine using username newly created user email and password default password
    Then linux machine activation message should be Invalid credentials.  Re-enter your account information.
#    When I use keyless activation to activate devices unsuccessful
#      | machine_name      | machine_type |
#      | machine_144460_01 | Server       |
#    Then activate machine result should be
#      | code | body                          |
#      | 401  | ERROR: authorization required |

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
