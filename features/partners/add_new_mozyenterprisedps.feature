Feature: Add a new partner

  As a Mozy Administrator
  I want to create MozyEnterprise DPS partners
  So that I can organize my business in a way that works for me

  Background:
    Given I log in bus admin console as administrator

  @TC.22365 @bus @2.7 @add_new_partner @mozyenterprisedps
Scenario: 22365 Add New MozyEnterprise DPS Partner - US - Yearly - 2 TB
  When I add a new MozyEnterprise DPS partner:
    | period | base plan | country       | address           | city      | state abbrev | zip   | phone          | sales channel |
    | 12     | 2         | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 | Velocity      |
  Then Sub-total before taxes or discounts should be $0.00
  And Order summary table should be:
    | Description             | Quantity | Price Each | Total Price |
    | TB - MozyEnterprise DPS | 2        | $0.00      | $0.00       |
    | Total Charges           |          |            | $0.00       |
  And New partner should be created
  And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:          | Parent:        | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: |
    | Active (change) | @root_admin (act as) | Enterprise (change) | MozyEnterprise | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         |
  And Partner contact information should be:
    | Company Type:      | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
    | MozyEnterprise DPS | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
  And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Enabled  |
    | Cloud Storage (GB)     |          |
    | Sync Users:            | -1       |
    | Default Sync Storage:  |          |
  And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 2 TB      | 2 TB     | 0    | Unlimited | Unlimited |
  And Partner stash info should be:
    | Users:         | 0 |
    | Storage Usage: | 0 |
  And Partner internal billing should be:
    | Account Type:   | Credit Card           | Current Period: | Yearly             |
    | Unpaid Balance: | $0.00                 | Collect On:     | N/A                |
    | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period |
    | Next Charge:    | after 1 year          |                 |                    |
  And Partner billing history should be:
    | Date  | Amount    | Total Paid | Balance Due |
    | today | $0.00     | $0.00      | $0.00       |
    | today | $0.00     | $0.00      | $0.00       |
  And I delete partner account
