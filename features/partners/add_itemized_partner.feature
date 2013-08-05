Feature: Add a new partner

  As a Mozy Administrator
  I want to create MozyPro partners
  So that I can organize my business in a way that works for me

  #
  # base creation cases for itemized pro
  @TC.20843 @itemized @bus @2.5 @create_partner
  Scenario: 20843 Add New MozyPro Itemized Partner - US - Monthly - 10 GB
    When I log in to legacy bus01 as administrator
    And I successfully add an itemized MozyPro partner:
      | period | server licenses | server quota | desktop licenses | desktop quota |
      | 12     | 5               | 50           | 5                | 50            |
    And I log in bus admin console as administrator
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And I view partner details by newly created partner company name
    And I get the partner_id
    And I migrate the partner to aria
    And I log in bus admin console as administrator
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And Partner search results should be:
      | Partner       | Type             |
      | @company_name | MozyPro Itemized |
    And I view partner details by newly created partner company name
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent: | Next Charge: | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Autogrow: | Enable Stash: |
      | Active (change) | @root_admin (act as) | Business Root (change) | MozyPro | after 1 year | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)      | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:                   | Contact City:                   | Contact State:                          | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
      | Business      | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state_abbrev%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server Enabled         | Disabled |
      | Cloud Storage (GB)     |          |
      | Stash Users:           |          |
      | Default Stash Storage: |          |
    And Itemized partner resources should be:
      |         | Devices: | Devices Used: | Quota: | Quota Used: | Resource Policy: |
      | Desktop | 5        | 0             | 50 GB  | 0           | Enabled          |
      | Server  | 5        | 0             | 50 GB  | 0           | Enabled          |
    And Partner internal billing should be:
      | Account Type:   | Credit Card  | Current Period: | Yearly             |
      | Unpaid Balance: | $0.00        | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year | Renewal Period: | Use Current Period |
    And I delete partner account

  # RESELLERS HERE
  # base creation case for itemized reseller
  @TC.20846 @itemized @bus @2.5
  Scenario: 20846 Add New Reseller Itemized Partner - US - Monthly - 10 GB
    When I log in to legacy bus01 as administrator
    And I successfully add an itemized Reseller partner:
      | period | server licenses | server quota | desktop licenses | desktop quota |
      | 12     | 10              | 250          | 10               | 250           |
    And I log in bus admin console as administrator
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And I view partner details by newly created partner company name
    And I get the partner_id
    And I migrate the partner to aria
    And I log in bus admin console as administrator
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And Partner search results should be:
      | Partner       | Type              |
      | @company_name | Reseller Itemized |
    And I view partner details by newly created partner company name
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent: | Next Charge: | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Autogrow: | Enable Stash: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro | after 1 year | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)      | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:                   | Contact City:                   | Contact State:                          | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
      | Reseller      | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state_abbrev%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server Enabled         | Disabled |
      | Cloud Storage (GB)     |          |
      | Stash Users:           |          |
      | Default Stash Storage: |          |
    And Itemized partner resources should be:
      |         | Devices: | Devices Used: | Quota: | Quota Used: | Resource Policy: |
      | Desktop | 10       | 0             | 250 GB | 0           | Enabled          |
      | Server  | 10       | 0             | 250 GB | 0           | Enabled          |
    And Partner internal billing should be:
      | Account Type:   | Credit Card  | Current Period: | Yearly             |
      | Unpaid Balance: | $0.00        | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year | Renewal Period: | Use Current Period |
    And I delete partner account

