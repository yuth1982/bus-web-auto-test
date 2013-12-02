Feature: Add a new partner through phoenix

As a business owner
I want to create a partner through phoenix
So that I can organize my business in a way that works for me

Background:
#---------------------------------------------------------------------------------
# base coverage section:
#   represents a balanced set of coverage
#----------------------------------------test matrix------------------------------
#	partner size:	10        | 50          | 100     | 250     | 500     | 1tb
#	monthly:		ie,sv,cp  | ie          | uk      | fr,sv   | de,sv   | us
#	yearly:			uk,sv     | de,sv,nv,cp | us,sv   | ie,nv   | fr      | fr,cp
#	biannual:		us        | fr,nv       | de,nv   | de      | uk,nv   | ie,sv
#----------------------------------------test legend------------------------------
#		entries by: country,server/dsk,novat,coupon
#
#		key: sv=server, nv=novat, cp=coupon
#		coupon code = 10PERCENTOFFOUTLINE
#
#     base smoke test = us yearly, 100gb, server
#---------------------------------------------------------------------------------

  @TC.20965 @bus @2.5 @regression_test @phoenix @mozypro
  Scenario: 20965 Add a new US yearly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country       |
    | 1      | 1 TB      | United States |
    Then the order summary looks like:
    | Description    | Price   | Quantity | Amount  |
    | 1 TB - Monthly | $379.99 | 1        | $379.99 |
    | Total Charge   | $379.99 |          | $379.99 |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                          | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent> | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)   |
    And Partner contact information should be:
    | Company Type:                  | Users: | Contact Address:                   | Contact City:                   | Contact State:                          | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state_abbrev%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Disabled |
    | Cloud Storage (GB)     |          |
    | Stash Users:           |          |
    | Default Stash Storage: |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 1024      | 1024     | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card            | Current Period: | Monthly             |
    | Unpaid Balance: | $0.00                  | Collect On:     | N/A                 |
    | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 1 month          |                 |                     |
    And I delete partner account

  @TC.20966 @bus @2.5 @regression_test @phoenix @mozypro
  Scenario: 20966 Add a new US biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country      |
    | 24     | 10 GB     | United States |
    Then the order summary looks like:
    | Description      | Price   | Quantity | Amount  |
    | 10 GB - Biennial | $209.79 | 1        | $209.79 |
    | Total Charge     | $209.79 |          | $209.79 |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                          | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent> | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)   |
    And Partner contact information should be:
    | Company Type:                  | Users: | Contact Address:                   | Contact City:                   | Contact State:                          | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state_abbrev%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Disabled |
    | Cloud Storage (GB)     |          |
    | Stash Users:           |          |
    | Default Stash Storage: |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 10        | 10       | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card            | Current Period: | Biennial            |
    | Unpaid Balance: | $0.00                  | Collect On:     | N/A                 |
    | Renewal Date:   | after 2 years          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 2 years          |                 |                     |
    And I delete partner account

  @TC.20967 @bus @2.5 @regression_test @phoenix @mozypro
  Scenario: 20967 Add a new IE monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country | vat number |
    | 1      | 50 GB     | Ireland | IE9691104A |
    Then the order summary looks like:
    | Description        | Price  | Quantity | Amount |
    | 50 GB - Monthly    | €15.99 | 1        | €15.99 |
    | Subscription Price | €15.99 |          | €15.99 |
    | VAT                | €3.68  |          | €3.68  |
    | Total Charge       | €19.67 |          | €19.67 |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                                    | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent> (MozyPro) | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)   |
    And Partner contact information should be:
    | Company Type:                  | Users: | Contact Address:                   | Contact City:                   | Contact State:                   | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Disabled |
    | Cloud Storage (GB)     |          |
    | Stash Users:           |          |
    | Default Stash Storage: |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 50        | 50       | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card            | Current Period: | Monthly             |
    | Unpaid Balance: | €0.00                  | Collect On:     | N/A                 |
    | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 1 month          |                 |                     |
    And I delete partner account

  @TC.20968 @bus @2.5 @regression_test @phoenix @mozypro
  Scenario: 20968 Add a new IE yearly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country | vat number |
    | 12     | 250 GB    | Ireland |            |
    Then the order summary looks like:
    | Description        | Price     | Quantity | Amount    |
    | 250 GB - Annual    | €824.89   | 1        | €824.89   |
    | Subscription Price | €824.89   |          | €824.89   |
    | VAT                | €189.72   |          | €189.72   |
    | Total Charge       | €1,014.61 |          | €1,014.61 |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                                    | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent> (MozyPro) | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)   |
    And Partner contact information should be:
    | Company Type:                  | Users: | Contact Address:                   | Contact City:                   | Contact State:                   | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Disabled |
    | Cloud Storage (GB)     |          |
    | Stash Users:           |          |
    | Default Stash Storage: |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 250       | 250      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card           | Current Period: | Yearly              |
    | Unpaid Balance: | €0.00                 | Collect On:     | N/A                 |
    | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 1 year          |                 |                     |
    And I delete partner account

  @TC.20969 @bus @2.5 @regression_test @phoenix @mozypro
  Scenario: 20969 Add a new IE biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country | vat number | server plan |
    | 24     | 1 TB      | Ireland | IE9691104A | yes         |
    Then the order summary looks like:
    | Description            | Price     | Quantity | Amount    |
    | 1 TB - Biennial        | €6,299.79 | 1        | €6,299.79 |
    | Server Plan - Biennial | €419.79   | 1        | €419.79   |
    | Subscription Price     | €6,719.58 |          | €6,719.58 |
    | VAT                    | €1,545.50 |          | €1,545.50 |
    | Total Charge           | €8,265.08 |          | €8,265.08 |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                                    | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent> (MozyPro) | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)   |
    And Partner contact information should be:
    | Company Type:                  | Users: | Contact Address:                   | Contact City:                   | Contact State:                   | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Enabled  |
    | Cloud Storage (GB)     |          |
    | Stash Users:           |          |
    | Default Stash Storage: |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 1024      | 1024     | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card            | Current Period: | Biennial            |
    | Unpaid Balance: | €0.00                  | Collect On:     | N/A                 |
    | Renewal Date:   | after 2 years          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 2 years          |                 |                     |
    And I delete partner account

  @TC.20970 @bus @2.5 @regression_test @phoenix @mozypro
  Scenario: 20970 Add a new UK monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country        | vat number  |
    | 1      | 100 GB    | United Kingdom | GB117223643 |
    Then the order summary looks like:
    | Description            | Price  | Quantity | Amount |
    | 100 GB - Monthly       | £26.99 | 1        | £26.99 |
    | VAT                    | Exempt |          | Exempt |
    | Total Charge           | £26.99 |          | £26.99 |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                                    | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent> (MozyPro) | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)   |
    And Partner contact information should be:
    | Company Type:                  | Users: | Contact Address:                   | Contact City:                   | Contact State:                   | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Disabled |
    | Cloud Storage (GB)     |          |
    | Stash Users:           |          |
    | Default Stash Storage: |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 100       | 100      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card            | Current Period: | Monthly             |
    | Unpaid Balance: | £0.00                  | Collect On:     | N/A                 |
    | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 1 month          |                 |                     |
    And I delete partner account

  @TC.20971 @bus @2.5 @regression_test @phoenix @mozypro
  Scenario: 20971 Add a new UK yearly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country        | vat number  | server plan |
    | 12     | 10 GB     | United Kingdom | GB117223643 | yes         |
    Then the order summary looks like:
    | Description          | Price   | Quantity | Amount  |
    | 10 GB - Annual       | £76.89  | 1        | £76.89  |
    | Server Plan - Annual | £32.89  | 1        | £32.89  |
    | VAT                  | Exempt  |          | Exempt  |
    | Total Charge         | £109.78 |          | £109.78 |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                                    | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent> (MozyPro) | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)   |
    And Partner contact information should be:
    | Company Type:                  | Users: | Contact Address:                   | Contact City:                   | Contact State:                   | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Enabled  |
    | Cloud Storage (GB)     |          |
    | Stash Users:           |          |
    | Default Stash Storage: |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 10        | 10       | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card           | Current Period: | Yearly              |
    | Unpaid Balance: | £0.00                 | Collect On:     | N/A                 |
    | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 1 year          |                 |                     |
    And I delete partner account

  @TC.20972 @bus @2.5 @regression_test @phoenix @mozypro
  Scenario: 20972 Add a new UK biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country        | vat number  |
    | 24     | 500 GB    | United Kingdom |             |
    Then the order summary looks like:
    | Description            | Price     | Quantity | Amount    |
    | 500 GB - Biennial      | £2,624.79 | 1        | £2,624.79 |
    | Subscription Price     | £2,624.79 |          | £2,624.79 |
    | VAT                    | £603.70   |          | £603.70   |
    | Total Charge           | £3,228.49 |          | £3,228.49 |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                                    | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent> (MozyPro) | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)   |
    And Partner contact information should be:
    | Company Type:                  | Users: | Contact Address:                   | Contact City:                   | Contact State:                   | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Disabled |
    | Cloud Storage (GB)     |          |
    | Stash Users:           |          |
    | Default Stash Storage: |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 500       | 500      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card            | Current Period: | Biennial            |
    | Unpaid Balance: | £0.00                  | Collect On:     | N/A                 |
    | Renewal Date:   | after 2 years          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 2 years          |                 |                     |
    And I delete partner account

  @TC.20973 @bus @2.5 @regression_test @phoenix @mozypro
  Scenario: 20973 Add a new DE monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country | vat number  | server plan |
    | 1      | 500 GB    | Germany | DE812321109 | yes         |
    Then the order summary looks like:
    | Beschreibung           | Preis   | Menge  | Betrag  |
    | 500 GB - Monatlich     | 149,99€ | 1      | 149,99€ |
    | Serverplan - Monatlich | 15,99€  | 1      | 15,99€  |
    | Umsatzsteuer           | Befreit |        | Befreit |
    | Gesamtbelastung        | 165,98€ |        | 165,98€ |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                                    | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent> (MozyPro) | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)   |
    And Partner contact information should be:
    | Company Type:                  | Users: | Contact Address:                   | Contact City:                   | Contact State:                   | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Enabled  |
    | Cloud Storage (GB)     |          |
    | Stash Users:           |          |
    | Default Stash Storage: |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 500       | 500      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card            | Current Period: | Monthly             |
    | Unpaid Balance: | €0.00                  | Collect On:     | N/A                 |
    | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 1 month          |                 |                     |
    And I delete partner account

  @TC.20974 @bus @2.5 @regression_test @phoenix @mozypro
  Scenario: 20974 Add a new DE biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country | vat number  |
    | 24     | 100 GB    | Germany |             |
    Then the order summary looks like:
    | Beschreibung           | Preis   | Menge  | Betrag  |
    | 100 GB - 2-Jahre       | 650,79€ | 1      | 650,79€ |
    | Abonnementpreis        | 650,79€ |        | 650,79€ |
    | Umsatzsteuer           | 149,68€ |        | 149,68€ |
    | Gesamtbelastung        | 800,47€ |        | 800,47€ |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                                    | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent> (MozyPro) | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)   |
    And Partner contact information should be:
    | Company Type:                  | Users: | Contact Address:                   | Contact City:                   | Contact State:                          | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Disabled |
    | Cloud Storage (GB)     |          |
    | Stash Users:           |          |
    | Default Stash Storage: |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 100       | 100      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card            | Current Period: | Biennial            |
    | Unpaid Balance: | €0.00                  | Collect On:     | N/A                 |
    | Renewal Date:   | after 2 years          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 2 years          |                 |                     |
    And I delete partner account

  @TC.20975 @bus @2.5 @regression_test @phoenix @mozypro
  Scenario: 20975 Add a new DE biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country | vat number  |
    | 24     | 250 GB    | Germany | DE812321109 |
    Then the order summary looks like:
    | Beschreibung           | Preis     | Menge  | Betrag    |
    | 250 GB - 2-Jahre       | 1.574,79€ | 1      | 1.574,79€ |
    | Umsatzsteuer           | Befreit   |        | Befreit   |
    | Gesamtbelastung        | 1.574,79€ |        | 1.574,79€ |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                                    | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent> (MozyPro) | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)   |
    And Partner contact information should be:
    | Company Type:                  | Users: | Contact Address:                   | Contact City:                   | Contact State:                          | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Disabled |
    | Cloud Storage (GB)     |          |
    | Stash Users:           |          |
    | Default Stash Storage: |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 250       | 250      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card            | Current Period: | Biennial            |
    | Unpaid Balance: | €0.00                  | Collect On:     | N/A                 |
    | Renewal Date:   | after 2 years          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 2 years          |                 |                     |
    And I delete partner account

  @TC.20976 @bus @2.5 @regression_test @phoenix @mozypro
  Scenario: 20976 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country | vat number    | server plan |
    | 1      | 250 Go    | France  | FR08410091490 | yes         |
    Then the order summary looks like:
    | Description             | Prix      | Quantité  | Montant   |
    | 250 Go - Mensuel        | 74,99€    | 1         | 74,99€    |
    | Plan serveur - Mensuel  | 12,99€    | 1         | 12,99€    |
    | TVA                     | Exemption |           | Exemption |
    | Montant total des frais | 87,98€    |           | 87,98€    |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                                    | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent> (MozyPro) | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)   |
    And Partner contact information should be:
    | Company Type:                  | Users: | Contact Address:                   | Contact City:                   | Contact State:                          | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Enabled  |
    | Cloud Storage (GB)     |          |
    | Stash Users:           |          |
    | Default Stash Storage: |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 250       | 250      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card            | Current Period: | Monthly             |
    | Unpaid Balance: | €0.00                  | Collect On:     | N/A                 |
    | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 1 month          |                 |                     |
    And I delete partner account

  @TC.20977 @bus @2.5 @regression_test @phoenix @mozypro
  Scenario: 20977 Add a new FR yearly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country | vat number    |
    | 12      | 500 Go   | France  | FR08410091490 |
    Then the order summary looks like:
    | Description             | Prix      | Quantité  | Montant   |
    | 500 Go - Annuel         | 1 649,89€ | 1         | 1 649,89€ |
    | TVA                     | Exemption |           | Exemption |
    | Montant total des frais | 1 649,89€ |           | 1 649,89€ |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                                    | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent> (MozyPro) | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)   |
    And Partner contact information should be:
    | Company Type:                  | Users: | Contact Address:                   | Contact City:                   | Contact State:                          | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Disabled |
    | Cloud Storage (GB)     |          |
    | Stash Users:           |          |
    | Default Stash Storage: |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 500       | 500      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card           | Current Period: | Yearly              |
    | Unpaid Balance: | €0.00                 | Collect On:     | N/A                 |
    | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 1 year          |                 |                     |
    And I delete partner account

  @TC.20978 @bus @2.5 @regression_test @phoenix @mozypro
  Scenario: 20978 Add a new FR biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country | vat number |
    | 24      | 50 Go    | France  |            |
    Then the order summary looks like:
    | Description              | Prix    | Quantité | Montant |
    | 50 Go - Bisannuel        | 335,79€ | 1        | 335,79€ |
    | Prix d'abonnement        | 335,79€ |          | 335,79€ |
    | TVA                      | 77,23€  |          | 77,23€  |
    | Montant total des frais  | 413,02€ |          | 413,02€ |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                                    | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent> (MozyPro) | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)   |
    And Partner contact information should be:
    | Company Type:                  | Users: | Contact Address:                   | Contact City:                   | Contact State:                          | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Disabled |
    | Cloud Storage (GB)     |          |
    | Stash Users:           |          |
    | Default Stash Storage: |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 50        | 50       | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card            | Current Period: | Biennial            |
    | Unpaid Balance: | €0.00                  | Collect On:     | N/A                 |
    | Renewal Date:   | after 2 years          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 2 years          |                 |                     |
    And I delete partner account

#---------------------------------------------------------------------------------
# coupons : new section
#---------------------------------------------------------------------------------
  @TC.20979 @bus @2.5 @regression_test @phoenix @mozypro
  Scenario: 20979 Add a new IE monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | coupon              | country | vat number | server plan |
    | 1      | 10 GB     | 10PERCENTOFFOUTLINE | Ireland | IE9691104A | yes         |
    Then the order summary looks like:
    | Description           | Price   | Quantity | Amount  |
    | 10 GB - Monthly       | €7.99   | 1        | €7.99   |
    | Server Plan - Monthly | €2.99   | 1        | €2.99   |
    | Subscription Price    | €10.98  |          | €10.98  |
    | Discounts             | - €1.10 |          | - €1.10 |
    | Subtotal              | €9.88   |          | €9.88   |
    | VAT                   | €2.53   |          | €2.53   |
    | Total Charge          | €12.41  |          | €12.41  |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                                    | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent> (MozyPro) | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)   |
    And Partner contact information should be:
    | Company Type:                  | Users: | Contact Address:                   | Contact City:                   | Contact State:                          | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Enabled  |
    | Cloud Storage (GB)     |          |
    | Stash Users:           |          |
    | Default Stash Storage: |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 10        | 10       | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card            | Current Period: | Monthly             |
    | Unpaid Balance: | €0.00                  | Collect On:     | N/A                 |
    | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 1 month          |                 |                     |
    And I delete partner account

  @TC.20980 @bus @2.5 @regression_test @phoenix @mozypro
  Scenario: 20980 Add a new DE biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | coupon              | country | vat number  | server plan |
    | 12     | 50 GB     | 10PERCENTOFFOUTLINE | Germany |             | yes         |
    Then the order summary looks like:
    | Beschreibung          | Preis    | Menge  | Betrag   |
    | 50 GB - jährlich      | 175,89€  | 1      | 175,89€  |
    | Serverplan - jährlich | 60,39€   | 1      | 60,39€   |
    | Abonnementpreis       | 236,28€  |        | 236,28€  |
    | Rabatte               | - 23,63€ |        | - 23,63€ |
    | Zwischensumme         | 212,65€  |        | 212,65€  |
    | Umsatzsteuer          | 54,34€   |        | 54,34€   |
    | Gesamtbelastung       | 266,99€  |        | 266,99€  |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                                    | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent> (MozyPro) | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)   |
    And Partner contact information should be:
    | Company Type:                  | Users: | Contact Address:                   | Contact City:                   | Contact State:                          | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Enabled  |
    | Cloud Storage (GB)     |          |
    | Stash Users:           |          |
    | Default Stash Storage: |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 50        | 50       | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card           | Current Period: | Yearly              |
    | Unpaid Balance: | €0.00                 | Collect On:     | N/A                 |
    | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 1 year          |                 |                     |
    And I delete partner account

  @TC.20982 @bus @2.5 @regression_test @phoenix @mozypro
  Scenario: 20982 Add a new FR yearly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | coupon              | country | vat number    |
    | 12     | 1 To      | 10PERCENTOFFOUTLINE | France  | FR08410091490 |
    Then the order summary looks like:
    | Description             | Prix      | Quantité  | Montant   |
    | 1 To - Annuel           | 3 299,89€ | 1         | 3 299,89€ |
    | Prix d'abonnement       | 3 299,89€ |           | 3 299,89€ |
    | Réductions              | - 329,99€ |           | - 329,99€ |
    | TVA                     | Exemption |           | Exemption |
    | Montant total des frais | 2 969,90€ |           | 2 969,90€ |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                                    | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent> (MozyPro) | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)   |
    And Partner contact information should be:
    | Company Type:                  | Users: | Contact Address:                   | Contact City:                   | Contact State:                          | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Disabled |
    | Cloud Storage (GB)     |          |
    | Stash Users:           |          |
    | Default Stash Storage: |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 1024      | 1024     | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card           | Current Period: | Yearly              |
    | Unpaid Balance: | €0.00                 | Collect On:     | N/A                 |
    | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 1 year          |                 |                     |
    And I delete partner account

#---------------------------------------------------------------------------------
# extended coverage section:
#   coverage based on changes made to UI, requirements changes, bugs, etc
#---------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#   Requirement #:  96067
#   Name: Phoenix needs to support the new account type, and sales origin partner details
#   Bug #: 97647
#   Name: Phoenix generated pro acct missing internal values
#---------------------------------------------------------------------------------

  @TC.20985 @bus @2.5 @regression_test @phoenix @mozypro @BUG.97647
  Scenario: 20985 Verification of new internal acct attributes for phoenix generated MozyPro partner
  When I am at dom selection point:
  And I add a phoenix Pro partner:
  | period | base plan | country       |
  | 12     | 250 GB    | United States |
  And the partner is successfully added.
  And I log in bus admin console as administrator
  And I search partner by:
  | name          | filter |
  | @company_name | None   |
  And I view partner details by newly created partner company name
  Then Partner general information should be:
  | Account Type  | Sales Origin  | Sales Channel         |
  | Live (change) | Web           | Inside Sales (change) |
  And I delete partner account
