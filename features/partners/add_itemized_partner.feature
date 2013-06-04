Feature: Add a new partner

  As a Mozy Administrator
  I want to create MozyPro partners
  So that I can organize my business in a way that works for me

  #
  # base creation cases for itemized pro
  @TC.20843 @itemized
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
      | Status:         | Root Admin:          | Root Role:             | Parent: | Next Charge:   | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Autogrow: | Enable Stash: |
      | Active (change) | @root_admin (act as) | Business Root (change) | MozyPro | after 1 year   | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)      | No            |
    And Partner contact information should be:
      | Company Type:    | Users: | Contact Address: | Contact City: | Contact ZIP/Postal Code: | Contact Country: | Phone: | Contact Email:   |
      | MozyPro Itemized | 0      | @address         | @city         | @zip_code                | @country         | @phone | @new_admin_email |
    And Partner account attributes should be:
      | Backup Licenses         |          |
      | Backup License Soft Cap | Disabled |
      | Server Enabled          | Disabled |
      | Cloud Storage (GB)      |          |
      | Stash Users:            |          |
      | Default Stash Storage:  |          |
    And Itemized partner resources should be:
      |         | Licenses: | Licenses Used: | Quota: | Quota Used: | Resource Policy: |
      | Desktop | 5         | 0              | 50 GB  | 0           | Enabled          |
      | Server  | 5         | 0              | 50 GB  | 0           | Enabled          |
    And Partner internal billing should be:
      | Account Type:   | Tokenized Credit Card | Current Period: | Yearly              |
      | Unpaid Balance: | $0.00                 | Collect On:     | N/A                 |
      | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period  |
    And I delete partner account

  # base creation itemized (pro) partner w/ user group
  #   & adding machine, quota to accts will be in future commits
  #   all as setup steps for verification of migration of itemized partners to pooled storage
  @TC.210XX @itemized
  Scenario: 210XX Pooled Storage - Pro Itemized - User List View - removal of assigned/used quota
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
    And I act as newly created partner
    And I add a new user group for an itemized partner:
      | name           | desktop_assigned_quota | server_assigned_quota |
      | TC210XX-Shared | 5                      | 5                     |
    And Itemized partner user group TC210XX-Shared should be created
    And I navigate to User Group List section from bus admin console page
    And Itemized user groups table should be:
      | Group Name          | Users | Server Keys | Server Quota            | Desktop Keys | Desktop Quota           |
      | (default user group)| 0     | 0 / 5       | 0.0 (0.0 active) / 50.0 | 0 / 5        | 0.0 (0.0 active) / 50.0 |
      | TC210XX-Shared      | 0     | 0 / 0       | 0.0 (0.0 active) / 0.0  | 0 / 0        | 0.0 (0.0 active) / 0.0  |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  # RESELLERS HERE
  # base creation case for itemized reseller
  @TC.20846 @itemized
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
      | Status:         | Root Admin:          | Root Role:             | Parent: | Next Charge:   | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Autogrow: | Enable Stash: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro | after 1 year   | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)      | No            |
    And Partner contact information should be:
      | Company Type:     | Users: | Contact Address: | Contact City: | Contact ZIP/Postal Code: | Contact Country: | Phone: | Contact Email:   |
      | Reseller Itemized | 0      | @address         | @city         | @zip_code                | @country         | @phone | @new_admin_email |
    And Partner account attributes should be:
      | Backup Licenses         |          |
      | Backup License Soft Cap | Disabled |
      | Server Enabled          | Disabled |
      | Cloud Storage (GB)      |          |
      | Stash Users:            |          |
      | Default Stash Storage:  |          |
    And Itemized partner resources should be:
      |         | Licenses: | Licenses Used: | Quota: | Quota Used: | Resource Policy: |
      | Desktop | 10        | 0              | 250 GB | 0           | Enabled          |
      | Server  | 10        | 0              | 250 GB | 0           | Enabled          |
    And Partner internal billing should be:
      | Account Type:   | Tokenized Credit Card | Current Period: | Yearly              |
      | Unpaid Balance: | $0.00                 | Collect On:     | N/A                 |
      | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period  |
    And I delete partner account

