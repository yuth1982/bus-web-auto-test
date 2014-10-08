Feature: Add a new partner

  As a Mozy Administrator
  I want to create Reseller partners
  So that I can organize my business in a way that works for me

  Background:
    Given I log in bus admin console as administrator

  @TC.18143 @bus @2.5 @add_new_partner @reseller @env_dependent
  Scenario: 18143 Add New Reseller Partner - US - Monthly - Silver 500 GB - Server Plan - Coupon - CC
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | coupon              | country       | address           | city      | state abbrev | zip   | phone          |
      | 1      | Silver        | 500            | yes         | 10PERCENTOFFOUTLINE | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be $235.00
    And Order summary table should be:
      | Description          | Quantity | Price Each | Total Price |
      | GB - Silver Reseller | 500      | $0.42      | $210.00     |
      | Server Plan          | 1        | $25.00     | $25.00      |
      | Discounts Applied    |          |            | -$23.50     |
      | Pre-tax Subtotal     |          |            | $211.50     |
      | Total Charges        |          |            | $211.50     |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent:    | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro    | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | Reseller      | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Enabled  |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 500       | 500      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Credit Card            | Current Period: | Monthly            |
      | Unpaid Balance: | $0.00                  | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month          |                 |                    |
  And Partner billing history should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | $211.50 | $211.50    | $0.00       |
      | today | $0.00   | $0.00      | $0.00       |
    And I delete partner account

  @TC.18146 @bus @2.5 @add_new_partner @reseller @env_dependent
  Scenario: 18146 Add New Reseller Partner - FR - Yearly - Gold 500 GB - Server Plan - VAT - Coupon - CC
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | create under   | vat number    | coupon              | country | address           | city      | state | zip   | phone          |
      | 12     | Gold          | 500            | yes         | MozyPro France | FR08410091490 | 10PERCENTOFFOUTLINE | France  | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €2,420.00
    And Order summary table should be:
      | Description        | Quantity | Price Each | Total Price |
      | GB - Gold Reseller | 500      | €3.08      | €1,540.00   |
      | Server Plan        | 1        | €880.00    | €880.00     |
      | Discounts Applied  |          |            | -€242.00    |
      | Pre-tax Subtotal   |          |            | €2,178.00   |
      | Total Charges      |          |            | €2,178.00   |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent:                   | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro France (MozyPro)  | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Industry: | # of employees: | Contact Email:                 | VAT Number:   |
      | Reseller      | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | France           | 1-877-486-9273 |           |                 | <%=@partner.admin_info.email%> | FR08410091490 |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Enabled  |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 500       | 500      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Credit Card           | Current Period: | Yearly             |
      | Unpaid Balance: | €0.00                 | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | €2,178.00 | €2,178.00  | €0.00       |
      | today | €0.00     | €0.00      | €0.00       |
    And I delete partner account

  @TC.18149 @bus @2.5 @add_new_partner @reseller @env_dependent
  Scenario: 18149 Add New Reseller Partner - DE - Monthly - Platinum 500 GB - Server Plan - VAT - Coupon - CC
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | create under    | vat number  | coupon              | country | address           | city      | state | zip   | phone          |
      | 1      | Platinum      | 500            | yes         | MozyPro Germany | DE812321109 | 10PERCENTOFFOUTLINE | Germany | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €260.00
    And Order summary table should be:
      | Description            | Quantity | Price Each | Total Price |
      | GB - Platinum Reseller | 500      | €0.24      | €120.00     |
      | Server Plan            | 1        | €140.00    | €140.00     |
      | Discounts Applied      |          |            | -€26.00     |
      | Pre-tax Subtotal       |          |            | €234.00     |
      | Total Charges          |          |            | €234.00     |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent:                    | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro Germany (MozyPro)  | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Industry: | # of employees: | Contact Email:                 | VAT Number: |
      | Reseller      | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | Germany          | 1-877-486-9273 |           |                 | <%=@partner.admin_info.email%> | DE812321109 |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Enabled  |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 500       | 500      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Credit Card            | Current Period: | Monthly            |
      | Unpaid Balance: | €0.00                  | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month          |                 |                    |
  And Partner billing history should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | €234.00 | €234.00    | €0.00       |
      | today | €0.00   | €0.00      | €0.00       |
    And I delete partner account

  @TC.18152 @bus @2.5 @add_new_partner @reseller @env_dependent
  Scenario: 18152 Add New Reseller Partner - IE - Yearly - Silver 500 GB - Server Plan - 10 Add on - VAT - Coupon - CC
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | storage add on | create under    | vat number | coupon              | country | address           | city      | state | zip   | phone          |
      | 12     | Silver        | 500            | yes         | 10             | MozyPro Ireland | IE9691104A | 10PERCENTOFFOUTLINE | Ireland | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €2,761.00
    And Order summary table should be:
      | Description          | Quantity | Price Each | Total Price |
      | GB - Silver Reseller | 500      | €3.63      | €1,815.00   |
      | Server Plan          | 1        | €220.00    | €220.00     |
      | 20 GB add-on         | 10       | €72.60     | €726.00     |
      | Discounts Applied    |          |            | -€276.10    |
      | Pre-tax Subtotal     |          |            | €2,484.90   |
      | Taxes                |          |            | €635.03     |
      | Total Charges        |          |            | €3,119.93   |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent:                   | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro Ireland (MozyPro) | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 | VAT Number: |
      | Reseller      | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | Ireland          | 1-877-486-9273 | <%=@partner.admin_info.email%> | IE9691104A  |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Enabled  |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 700       | 700      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Credit Card           | Current Period: | Yearly             |
      | Unpaid Balance: | €0.00                 | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year          |                 |                    |
  And Partner billing history should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | €3,119.93 | €3,119.93  | €0.00       |
      | today | €0.00     | €0.00      | €0.00       |
    And I delete partner account

  @TC.18153 @bus @2.5 @add_new_partner @reseller @env_dependent
  Scenario: 18153 Add New Reseller Partner - UK - Monthly - Gold 500 GB - Server Plan -  10 Add on - VAT - Coupon - CC
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | storage add on | create under | vat number  | coupon              | country        | address           | city      | state | zip   | phone          |
      | 1      | Gold          | 500            | yes         | 10             | MozyPro UK   | GB117223643 | 10PERCENTOFFOUTLINE | United Kingdom | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be £226.00
    And Order summary table should be:
      | Description        | Quantity | Price Each | Total Price |
      | GB - Gold Reseller | 500      | £0.23      | £115.00     |
      | Server Plan        | 1        | £65.00     | £65.00      |
      | 20 GB add-on       | 10       | £4.60      | £46.00      |
      | Discounts Applied  |          |            | -£22.60     |
      | Pre-tax Subtotal   |          |            | £203.40     |
      | Total Charges      |          |            | £203.40     |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent:              | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro UK (MozyPro) | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 | VAT Number: |
      | Reseller      | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United Kingdom   | 1-877-486-9273 | <%=@partner.admin_info.email%> | GB117223643 |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Enabled  |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 700       | 700      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Credit Card            | Current Period: | Monthly            |
      | Unpaid Balance: | £0.00                  | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month          |                 |                    |
  And Partner billing history should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | £203.40 | £203.40    | £0.00       |
      | today | £0.00   | £0.00      | £0.00       |
    And I delete partner account

  @TC.18155 @bus @2.5 @add_new_partner @reseller
  Scenario: 18155 Add New Reseller Partner - US - Yearly - Platinum 500 GB - 10 Add on - Net Terms
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | storage add on | net terms | country       | address           | city      | state abbrev | zip   | phone          |
      | 12     | Platinum      | 500            | 10             | yes       | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be $2,310.00
    And Order summary table should be:
      | Description            | Quantity | Price Each | Total Price |
      | GB - Platinum Reseller | 500      | $3.30      | $1,650.00   |
      | 20 GB add-on           | 10       | $66.00     | $660.00     |
      | Pre-tax Subtotal       |          |            | $2,310.00   |
      | Total Charges          |          |            | $2,310.00   |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent: | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | Reseller      | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 700       | 700      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30          | Current Period: | Yearly             |
      | Unpaid Balance: | $2,310.00             | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year          |                 |                    |
  And Partner billing history should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | $2,310.00 | $0.00      | $2,310.00   |
      | today | $0.00     | $0.00      | $0.00       |
    And I delete partner account

  @TC.17970  @bus @2.5 @add_new_partner @reseller
  Scenario: 17970 Add New Reseller Partner - FR - Monthly - Silver 500 GB - Net Terms
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | create under   | net terms | country | address           | city      | state | zip   | phone          |
      | 1      | Silver        | 500            | MozyPro France | yes       | France  | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €165.00
    And Order summary table should be:
      | Description          | Quantity | Price Each | Total Price |
      | GB - Silver Reseller | 500      | €0.33      | €165.00     |
      | Pre-tax Subtotal     |          |            | €165.00     |
      | Taxes                |          |            | €37.95      |
      | Total Charges        |          |            | €202.95     |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent:                   | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro France (MozyPro)  | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | Reseller      | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | France           | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 500       | 500      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30           | Current Period: | Monthly            |
      | Unpaid Balance: | €202.95                | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month          |                 |                    |
  And Partner billing history should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | €202.95 | €0.00      | €202.95     |
      | today | €0.00   | €0.00      | €0.00       |
    And I delete partner account

  @TC.17971 @bus @2.5 @add_new_partner @reseller
  Scenario: 17971 Add New Reseller Partner - DE - Yearly - Gold 500 GB - Net Terms
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms | create under    | country | address           | city      | state | zip   | phone          |
      | 12     | Gold          | 500            | yes       | MozyPro Germany | Germany | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €1,540.00
    And Order summary table should be:
      | Description        | Quantity | Price Each | Total Price |
      | GB - Gold Reseller | 500      | €3.08      | €1,540.00   |
      | Pre-tax Subtotal   |          |            | €1,540.00   |
      | Taxes              |          |            | €354.20     |
      | Total Charges      |          |            | €1,894.20   |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent:                    | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro Germany (MozyPro)  | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | Reseller      | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | Germany          | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 500       | 500      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30          | Current Period: | Yearly             |
      | Unpaid Balance: | €1,894.20             | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | €1,894.20 | €0.00      | €1,894.20   |
      | today | €0.00     | €0.00      | €0.00       |
    And I delete partner account

  @TC.17972 @bus @2.5 @add_new_partner @reseller
  Scenario: 17972 Add New Reseller Partner - IE - Monthly - Platinum 500 GB - Net Terms
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms | create under    | country | address           | city      | state | zip   | phone          |
      | 1      | Platinum      | 500            | yes       | MozyPro Ireland | Ireland | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €120.00
    And Order summary table should be:
      | Description            | Quantity | Price Each | Total Price |
      | GB - Platinum Reseller | 500      | €0.24      | €120.00     |
      | Pre-tax Subtotal       |          |            | €120.00     |
      | Taxes                  |          |            | €27.60      |
      | Total Charges          |          |            | €147.60     |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent:                    | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro Ireland (MozyPro)  | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | Reseller      | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | Ireland          | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 500       | 500      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30           | Current Period: | Monthly            |
      | Unpaid Balance: | €147.60                | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | €147.60 | €0.00      | €147.60     |
      | today | €0.00   | €0.00      | €0.00       |
    And I delete partner account

  @TC.17973 @bus @2.5 @add_new_partner @reseller
  Scenario: 17973 Add New Reseller Partner - UK - Yearly - Silver 500 GB - 10 Add on - Net Terms
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | storage add on | create under | net terms | country        | address           | city      | state | zip   | phone          |
      | 12     | Silver        | 500            | 10             | MozyPro UK   | yes       | United Kingdom | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be £2,079.00
    And Order summary table should be:
      | Description          | Quantity | Price Each | Total Price |
      | GB - Silver Reseller | 500      | £2.97      | £1,485.00   |
      | 20 GB add-on         | 10       | £59.40     | £594.00     |
      | Pre-tax Subtotal     |          |            | £2,079.00   |
      | Taxes                |          |            | £478.17     |
      | Total Charges        |          |            | £2,557.17   |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent:               | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro UK (MozyPro)  | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | Reseller      | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United Kingdom   | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 700       | 700      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30          | Current Period: | Yearly             |
      | Unpaid Balance: | £2,557.17             | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | £2,557.17 | £0.00      | £2,557.17   |
      | today | £0.00     | £0.00      | £0.00       |
    And I delete partner account

  @TC.17974 @bus @2.5 @add_new_partner @reseller
  Scenario: 17974 Add New Reseller Partner US Without Initial Purchases
    When I add a new Reseller partner:
      | period | country       | address           | city      | state abbrev | zip   | phone          |
      | 1      | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be 0
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent:  | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro  | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | Reseller      | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 0         | 0        | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Other/None             | Current Period: | Monthly            |
      | Unpaid Balance: | $0.00                  | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount | Total Paid | Balance Due |
      | today | $0.00  | $0.00      | $0.00       |
    And I delete partner account

  @TC.18722 @bus @2.5 @add_new_partner @reseller
  Scenario: 18722 Verify Reseller partner has 2 period options
    When I navigate to Add New Partner section from bus admin console page
    Then Reseller partner subscription period options should be:
      | Monthly | Yearly |

  @TC.20379 @bus @2.5 @add_new_partner @reseller @env_dependent
  Scenario: 20379 Add New Reseller Partner - US - Monthly - Silver 500 GB - Server Plan - 100PercentDiscountCoupon - CC
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | coupon               |
      | 1      | Silver        | 500            | yes         | 100PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $235.00
    And Order summary table should be:
      | Description          | Quantity | Price Each | Total Price |
      | GB - Silver Reseller | 500      | $0.42      | $210.00     |
      | Server Plan          | 1        | $25.00     | $25.00      |
      | Discounts Applied    |          |            | -$235.00    |
      | Total Charges        |          |            | $0.00       |
    And New partner should be created
    And Partner billing history should be:
      | Date  | Amount | Total Paid | Balance Due |
      | today | $0.00  | $0.00      | $0.00       |
      | today | $0.00  | $0.00      | $0.00       |
    And I delete partner account
