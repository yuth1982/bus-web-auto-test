Feature: login as admins

  Background:
    Given I log in bus admin console as administrator

#  @TC.122151 @bus @admin
#  Scenario: 122151 Trigger Authlockout
#    When I add a new MozyPro partner:
#      | period | base plan  |
#      | 24     | 500 GB     |
#    Then New partner should be created
#    And I change root role to FedID role
#    And I act as newly created partner account
#    And I navigate to Add New Admin section from bus admin console page
#    And I add a new admin newly:
#      | Name         | Roles      | User Group           |
#      | Admin_122151 | FedID role | (default user group) |
#    Then Add New Admin success message should be displayed
#    And the partner has activated the sub-admin account with default password
#    And the partner has activated the admin account with default password
#    And I log in bus admin console with user name @admin.email and password Standard password
#    Then Login page error message should be Incorrect email or password.
#    And I log in bus admin console with user name @admin.email and password Standard password
#    Then Login page error message should be Incorrect email or password.
#    And I log in bus admin console with user name @admin.email and password Standard password
#    Then Login page error message should be There have been too many failed login attempts on your account. Please try logging in again later.
#    And I log in bus admin console with user name @partner.admin_info.email and password default password
#    And I view the admin details of Admin_122151
#    And I change admin password to Standard password
#    Then I can change admin password successfully
#    And I log out bus admin console
#    And I log in bus admin console with user name @admin.email and password Standard password
#    Then I login as Admin_122151 admin successfully
#    And I log out bus admin console
#    And I log in bus admin console as administrator
#    And I search and delete partner account by newly created partner company name

#########################################################################

 #  Test Suite : Standard partner login_Sub Admin

########################################################################

  @TC.14477 @bus @admin
  Scenario: 14477 Sub-admin cannot login its account after partner was suspended from BUS
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 24     | 10 GB     | yes       |
    Then New partner should be created
    And I change root role to FedID role
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name        | Roles      | User Group           |
      | Admin_14477 | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    And the partner has activated the sub-admin account with default password
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    Then I suspend the partner
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password default password
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.
    Then I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

#########################################################################

 #  Test Suite : HIPAA partner login_Sub Admin

########################################################################

  @TC.123401 @bus @admin
  Scenario: 123401 Hipaa MozyPro login bus and phoenix after activating and changing password(admin before subadmin)
    When I add a new MozyPro partner:
      | period | base plan | net terms | security |
      | 24     | 10 GB     | yes       | HIPAA    |
    Then New partner should be created
    And I change root role to FedID role
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name           | User Group           |
      | Admin_123401_1 | (default user group) |
    Then Add New Admin success message should be displayed
    And I refresh Add New Admin section
    And I add a new admin:
      | Name           | Parent               |
      | Admin_123401_2 | <%=@admins[0].name%> |
    Then Add New Admin success message should be displayed
    And the partner has activated the <%=@admin.email%> account with Hipaa password
    And the partner has activated the <%=@admins[0].email%> account with reset password
    And I log in bus admin console as administrator
    And I act as partner by:
      | email        |
      | @admin_email |
    And I view admin details by:
      | name           |
      | Admin_123401_1 |
    And I change admin password to Hipaa password
    Then I can change Admin_123401_1 password successfully
    And I close the admin details section
    And I act as admin by:
      | email          |
      | Admin_123401_2 |
    And I click admin Admin_123401_2 on the top right
    And I change root admin password in Account Details from old password Hipaa password to reset password
    Then password changed success message should be displayed
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admins[0].email and password Hipaa password
    Then I login as Admin_123401_1 admin successfully
    And I log out bus admin console
    And I log into phoenix with username @admins[0].email and password Hipaa password
    Then I login as Admin_123401_1 admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @new_admins[0].email and password reset password
    Then I login as Admin_123401_2 admin successfully
    And I log out bus admin console
    And I log into phoenix with username @new_admins[0].email and password reset password
    Then I login as Admin_123401_2 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123402 @bus @admin
  Scenario: 123402 Hipaa Reseller EMEA login bus after activating and changing password(subadmin before admin)
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | create under | net terms | country        | security |
      | 12     | Silver        | 50             | MozyPro UK   | yes       | United Kingdom | HIPAA    |
    And New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name           | User Group           |
      | Admin_123402_1 | (default user group) |
    Then Add New Admin success message should be displayed
    And I refresh Add New Admin section
    And I add a new admin:
      | Name            | Parent               |
      | Admin_123402_2  | <%=@admins[0].name%> |
    Then Add New Admin success message should be displayed
    And the partner has activated the <%=@new_admins[0].email%> account with Hipaa password
    And the partner has activated the <%=@admins[0].email%> account with reset password
    And I log in bus admin console as administrator
    And I act as partner by:
      | email        |
      | @admin_email |
    And I view admin details by:
      | name           |
      | Admin_123402_2 |
    And I change admin password to reset password
    Then I can change Admin_123402_2 password successfully
    And I close the admin details section
    And I act as admin by:
      | email          |
      | Admin_123402_1 |
    And I click admin Admin_123402_1 on the top right
    And I change root admin password in Account Details from old password reset password to Hipaa password
    Then password changed success message should be displayed
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admins[0].email and password Hipaa password
    Then I login as Admin_123402_1 admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @new_admins[0].email and password reset password
    Then I login as Admin_123402_2 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123686 @bus @admin
  Scenario: 123686 Hipaa Sub-admin cannot login its account after partner was suspended from BUS
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | root role     | security |
      | 12     | Silver        | 100            | Reseller Root | HIPAA    |
    Then New partner should be created
    And I view the newly created partner admin details
    Then I active admin in admin details default password
    And I view partner details by newly created partner company name
    Then I suspend the partner
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name         | User Group           |
      | Admin_123686 | (default user group) |
    Then Add New Admin success message should be displayed
    And the partner has activated the sub-admin account with Hipaa password
    And the partner has activated the admin account with Hipaa password
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password Hipaa password
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.
    And I log in bus admin console with user name @partner.admin_info.email and password Hipaa password
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

#########################################################################

 #  Test Suite : Standard partners login_Root Admin

########################################################################

  @TC.123673 @bus @admin
  Scenario: 123673 Create standard for MozyPro US partner and sub-partners and admin on phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | security |
      | 24     | 10 GB     | United States | Standard |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I change root role to FedID role
    Then I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    Then I login as mozypro admin successfully
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | newrole | Partner admin |
    When I navigate to Add New Pro Plan section from bus admin console page
    Then I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     |          | yearly  | test     | false            | 1                          | 1                     |
    And I add a new sub partner:
      | Company Name          |
      | sub_partner_TC.123673 |
    And New partner should be created
    Then The security filed value is Standard
    And I search partner by newly created subpartner company name
    And I view admin details by @subpartner.admin_email_address
    And I active admin in admin details Standard password
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password Standard password
    Then I login as @subpartner.company_name admin successfully
    And I log out bus admin console
    And I log into phoenix with username @subpartner.admin_email_address and password Standard password
    Then I login as @subpartner.company_name admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created subpartner company name
    And I search and delete partner account by newly created partner company name

  @TC.123716 @bus @admin
  Scenario: 123716 Standard MozyPro login bus and phoenix after activating and changing password(admin before subadmin)
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 24     | 10 GB     | yes       |
    Then New partner should be created
    And I change root role to FedID role
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name           | User Group           |
      | Admin_123716_1 | (default user group) |
    Then Add New Admin success message should be displayed
    And I refresh Add New Admin section
    And I add a new admin:
      | Name            | Parent               |
      | Admin_123716_2  | <%=@admins[0].name%> |
    Then Add New Admin success message should be displayed
    And I view admin details by:
      | name           |
      | Admin_123716_1 |
    Then I active admin in admin details default password
    And I change admin password to Standard password
    Then I can change Admin_123716_1 password successfully
    And I close the admin details section
    And I view admin details by:
      | name           |
      | Admin_123716_2 |
    Then I active admin in admin details default password
    And I close the admin details section
    And I act as admin by:
      | email          |
      | Admin_123716_2 |
    And I click admin Admin_123716_2 on the top right
    And I change root admin password in Account Details from old password default password to reset password
    Then password changed success message should be displayed
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admins[0].email and password Standard password
    Then I login as Admin_123716_1 admin successfully
    And I log out bus admin console
    And I log into phoenix with username @admins[0].email and password Standard password
    Then I login as Admin_123716_1 admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @new_admins[0].email and password reset password
    Then I login as Admin_123716_2 admin successfully
    And I log out bus admin console
    And I log into phoenix with username @new_admins[0].email and password reset password
    Then I login as Admin_123716_2 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123717 @bus @admin
  Scenario: 123717 Standard Reseller EMEA login bus after activating and changing password(subadmin before admin)
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | storage add on | create under | net terms | country        |
      | 12     | Silver        | 500            | 10             | MozyPro UK   | yes       | United Kingdom |
    And New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name           | User Group           |
      | Admin_123717_1 | (default user group) |
    Then Add New Admin success message should be displayed
    And I refresh Add New Admin section
    And I add a new admin:
      | Name            | Parent               |
      | Admin_123717_2  | <%=@admins[0].name%> |
    Then Add New Admin success message should be displayed
    And I view admin details by:
      | name           |
      | Admin_123717_2 |
    Then I active admin in admin details default password
    And I change admin password to Standard password
    Then I can change Admin_123717_2 password successfully
    And I close the admin details section
    And I view admin details by:
      | name           |
      | Admin_123717_1 |
    Then I active admin in admin details default password
    And I close the admin details section
    And I act as admin by:
      | email          |
      | Admin_123717_1 |
    And I click admin Admin_123717_1 on the top right
    And I change root admin password in Account Details from old password default password to reset password
    Then password changed success message should be displayed
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admins[0].email and password reset password
    Then I login as Admin_123717_1 admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @new_admins[0].email and password Standard password
    Then I login as Admin_123717_2 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123718 @bus @admin
  Scenario: 123718 Standard MozyEnterprise login bus after activating and changing password
     When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 12     | 1     | 1 TB        | FedID role |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name         | Roles      | User Group           |
      | Admin_123718 | FedID role | (default user group) |
    And the partner has activated the sub-admin account with default password
    And I log in bus admin console as administrator
    And I search partner by newly created partner admin email
    And I view admin details by newly created partner admin email
    Then I active admin in admin details default password
    And I change admin password to Standard password
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password Standard password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password default password
    Then I login as Admin_123718 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123719 @bus @admin
  Scenario: 123719 Standard Mozy OEM login bus after activating and changing password
    When I act as partner by:
      | name     | including sub-partners |
      | Fortress | no                     |
    And I act as partner by:
      | name    | including sub-partners |
      | MozyOEM | no                     |
    And I add a new sub partner:
      | Security |
      | Standard |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name         | User Group           |
      | Admin_123719 | (default user group) |
    And the partner has activated the oem-admin account with default password
    And I go to account
    Then I login as @subpartner.company_name admin successfully
    And I view admin details by:
      | name         |
      | Admin_123719 |
    And I active admin in admin details default password
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password default password
    Then I login as Admin_123719 admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password default password
    Then I login as @subpartner.company_name admin successfully
    And I act as admin by:
      | email             |
      | <%=@admin.email%> |
    And I click admin Admin_123719 on the top right
    Then I change root admin password in Account Details from old password default password to reset password
    Then password changed success message should be displayed
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password reset password
    Then I login as Admin_123719 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created subpartner company name


#########################################################################

 #  Test Suite : HIPAA partner login_Root Admin

########################################################################

  @TC.120062 @TC.120063 @bus @admin
  Scenario: 120062 120063 New Hipaa admin can log in bus and phoenix after account activation
    When I add a new MozyPro partner:
      | period | base plan | net terms | security |
      | 24     | 10 GB     | yes       | HIPAA    |
    Then New partner should be created
    And the partner has activated the admin account with Hipaa password
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password Hipaa password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log into phoenix with username @partner.admin_info.email and password Hipaa password
    Then I login as mozypro admin successfully
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.120073 @busNegative @admin
  Scenario: 120073 [Negative]Hipaa admin cannot log in bus with error empty password
    When I add a new MozyPro partner:
      | period | base plan | security |
      | 12     | 500 GB    | HIPAA    |
    Then New partner should be created
    And the partner has activated the admin account with Hipaa password
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password wrongpass password
    Then Login page error message should be Incorrect email or password.
    And I log in bus admin console with user name @partner.admin_info.email and password Empty
    Then Login page error message should be Incorrect email or password.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.120076 @bus @admin
  Scenario: 120076 HIPAA for MozyPro EMEA partner and sub-partners and admin could login bus and phoenix
    When I navigate to Add New Partner section from bus admin console page
    Then Security field options on add new partner page should be:
      | | Standard | HIPAA |
    And Security field default value when add partner is blank
    And HIPPA security tool tip appears next to the security drop-down
    When I add a new MozyPro partner:
      | period | base plan | create under | net terms | country        | security |
      | 12     | 2 TB      | MozyPro UK   | yes       | United Kingdom | HIPAA    |
    Then New partner should be created
    And The security filed value is HIPAA
    And I change root role to FedID role
    And I act as newly created partner
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | newrole | Partner admin |
    When I navigate to Add New Pro Plan section from bus admin console page
    Then I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                             | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     | £ — Pound Sterling (Partner Default) | yearly  | test     | false            | 1                          | 1                     |
    And I add a new sub partner:
      | Company Name          |
      | sub_partner_TC.120076 |
    And New partner should be created
    Then The security filed value is HIPAA
    And the partner has activated the admin account with Hipaa password
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password Hipaa password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log into phoenix with username @partner.admin_info.email and password Hipaa password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created subpartner company name
    And I search and delete partner account by newly created partner company name

  @TC.120078 @bus @admin
  Scenario: 120078 HIPAA for Reseller EMEA partner and sub-partners and admin could login bus
    When I navigate to Add New Partner section from bus admin console page
    Then Security field options on add new partner page should be:
      | | Standard | HIPAA |
    And Security field default value when add partner is blank
    And HIPPA security tool tip appears next to the security drop-down
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | create under | net terms | country        | security |
      | 12     | Silver        | 100            | MozyPro UK   | yes       | United Kingdom | HIPAA    |
    Then New partner should be created
    Then The security filed value is HIPAA
    And I act as newly created partner
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | subrole | Partner admin |
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                             | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | £ — Pound Sterling (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I add a new sub partner:
      | Company Name          | Pricing Plan | Admin Name |
      | sub_partner_TC.120078 | subplan      | subadmin   |
    Then New partner should be created
    Then The security filed value is HIPAA
    And the partner has activated the admin account with Hipaa password
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password Hipaa password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log into phoenix with username @partner.admin_info.email and password Hipaa password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created subpartner company name
    And I search and delete partner account by newly created partner company name

  @TC.120083 @bus @admin
  Scenario: 120083 Hipaa admin can login bus after activated through email
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  | security |
      | 24     | 3     | 24 TB       | FedID role | HIPAA    |
    Then New partner should be created
    And the partner has activated the admin account with Hipaa password
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password Hipaa password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123404 @bus @admin
  Scenario: 123404 HIPAA MozyEnterprise login bus after activating and changing password
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  | security |
      | 12     | 1     | 12 TB       | FedID role | HIPAA    |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name         | Roles      | User Group           |
      | Admin_123404 | FedID role | (default user group) |
    And the partner has activated the sub-admin account with Hipaa password
    And I log in bus admin console as administrator
    And I search partner by newly created partner admin email
    And I view admin details by newly created partner admin email
    Then I active admin in admin details Hipaa password
    And I change admin password to reset password
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password reset password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password Hipaa password
    Then I login as Admin_123404 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123407 @bus @admin
  Scenario: 123407 Hipaa Mozy OEM login bus after activating and changing password
    When I act as partner by:
      | name     | including sub-partners |
      | Fortress | no                     |
    And I act as partner by:
      | name    | including sub-partners |
      | MozyOEM | no                     |
    And I add a new sub partner:
      | Security |
      | HIPAA    |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name         | User Group           |
      | Admin_123407 | (default user group) |
    And the partner has activated the oem-admin account with Hipaa password
    And I go to account
    Then I login as @subpartner.company_name admin successfully
    And I view admin details by:
      | name         |
      | Admin_123407 |
    Then I click here to re-send activation email in admin details section
    And the partner has activated the sub-admin account with Hipaa password
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password Hipaa password
    Then I login as Admin_123407 admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password Hipaa password
    Then I login as @subpartner.company_name admin successfully
    And I act as admin by:
      | email             |
      | <%=@admin.email%> |
    And I click admin Admin_123407 on the top right
    Then I change root admin password in Account Details from old password Hipaa password to reset password
    Then password changed success message should be displayed
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password reset password
    Then I login as Admin_123407 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created subpartner company name

  @TC.123340 @bus @admin
  Scenario: 123340 Activate a new HIPAA root admin in admin detail
     When I add a new MozyPro partner:
      | period | base plan | security |
      | 12     | 24 TB     | HIPAA    |
    Then New partner should be created
    And I change root role to FedID role
    And I act as newly created partner
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | newrole | Partner admin |
    When I navigate to Add New Pro Plan section from bus admin console page
    Then I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     |          | yearly  | test     | false            | 1                          | 1                     |
    And I add a new sub partner:
      | Company Name          |
      | sub_partner_TC.123340 |
    And New partner should be created
    Then I stop masquerading
    And I search partner by newly created partner admin email
    And I view admin details by newly created partner admin email
    Then I active admin in admin details Hipaa password
    And I close the admin details section
    And I search partner by newly created subpartner company name
    And I view admin details by @subpartner.admin_email_address
    And I active admin in admin details reset password
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password Hipaa password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log into phoenix with username @partner.admin_info.email and password Hipaa password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password reset password
    Then I login as @subpartner.company_name admin successfully
    And I log out bus admin console
    And I log into phoenix with username @subpartner.admin_email_address and password reset password
    Then I login as @subpartner.company_name admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created subpartner company name
    And I search and delete partner account by newly created partner company name

  @TC.123523 @bus @admin
  Scenario: 123523 Create HIPAA for MozyPro US partner and sub-partner and admin on phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | security |
      | 24     | 10 GB     | United States | HIPAA    |
    And the partner is successfully added.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password reset password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log into phoenix with username @partner.admin_info.email and password reset password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name







