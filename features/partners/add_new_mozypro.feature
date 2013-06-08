Feature: Add a new partner

  As a Mozy Administrator
  I want to create MozyPro partners
  So that I can organize my business in a way that works for me

  Background:
    Given I log in bus admin console as administrator

  @TC.17942 @create_partner_sample
  Scenario: 17942 Add New MozyPro Partner - US - Monthly - 10 GB - Coupon - CC
    When I add a new MozyPro partner:
      | period | base plan | coupon              | country       | address           | city      | state abbrev | zip   | phone          |
      | 1      | 10 GB     | 10PERCENTOFFOUTLINE | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be $9.99
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | $9.99      | $9.99       |
      | Discounts Applied |          |            | -$1.00      |
      | Pre-tax Subtotal  |          |            | $8.99       |
      | Total Charges     |          |            | $8.99       |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent: | Next Charge:  | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro | after 1 month | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Keys            |          |
      | Backup Key Soft Cap    | Disabled |
      | Server Enabled         | Disabled |
      | Cloud Storage (GB)     |          |
      | Stash Users:           |          |
      | Default Stash Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 10        | 10       | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Credit Card   | Current Period: | Monthly            |
      | Unpaid Balance: | $0.00         | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month | Renewal Period: | Use Current Period |
    And Partner billing history should be:
      | Date  | Amount | Total Paid | Balance Due |
      | today | $8.99  | $8.99      | $0.00       |
      | today | $0.00  | $0.00      | $0.00       |
    And I delete partner account

  @TC.17955
  Scenario: 17955 Add New MozyPro Partner - FR - Yearly - 50 GB - VAT - Coupon - CC
    When I add a new MozyPro partner:
      | period | base plan | create under   | vat number    | coupon              | country | address           | city      | state | zip   | phone          |
      | 12     | 50 GB     | MozyPro France | FR08410091490 | 10PERCENTOFFOUTLINE | France  | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €175.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 50 GB             | 1        | €175.89    | €175.89     |
      | Discounts Applied |          |            | -€17.59     |
      | Pre-tax Subtotal  |          |            | €158.30     |
      | Total Charges     |          |            | €158.30     |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent:                  | Next Charge: | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro France (MozyPro) | after 1 year | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 | VAT Number:   |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | France           | 1-877-486-9273 | <%=@partner.admin_info.email%> | FR08410091490 |
    And Partner account attributes should be:
      | Backup Keys            |          |
      | Backup Key Soft Cap    | Disabled |
      | Server Enabled         | Disabled |
      | Cloud Storage (GB)     |          |
      | Stash Users:           |          |
      | Default Stash Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 50        | 50       | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Credit Card  | Current Period: | Yearly             |
      | Unpaid Balance: | €0.00        | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year | Renewal Period: | Use Current Period |
    And Partner billing history should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | €158.30 | €158.30    | €0.00       |
      | today | €0.00   | €0.00      | €0.00       |
    And I delete partner account

  @TC.18142
  Scenario: 18142 Add New MozyPro Partner - DE - Biennially - 100 GB - VAT - Coupon CC
    When I add a new MozyPro partner:
      | period | base plan | create under    | vat number  | coupon              | country | address           | city      | state | zip   | phone          |
      | 24     | 100 GB    | MozyPro Germany | DE812321109 | 10PERCENTOFFOUTLINE | Germany | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €650.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 100 GB            | 1        | €650.79    | €650.79     |
      | Discounts Applied |          |            | -€65.08     |
      | Pre-tax Subtotal  |          |            | €585.71     |
      | Total Charges     |          |            | €585.71     |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent:                   | Next Charge:  | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro Germany (MozyPro) | after 2 years | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 | VAT Number: |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | Germany          | 1-877-486-9273 | <%=@partner.admin_info.email%> | DE812321109 |
    And Partner account attributes should be:
      | Backup Keys            |          |
      | Backup Key Soft Cap    | Disabled |
      | Server Enabled         | Disabled |
      | Cloud Storage (GB)     |          |
      | Stash Users:           |          |
      | Default Stash Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 100       | 100      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Credit Card   | Current Period: | Biennial           |
      | Unpaid Balance: | €0.00         | Collect On:     | N/A                |
      | Renewal Date:   | after 2 years | Renewal Period: | Use Current Period |
    And Partner billing history should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | €585.71 | €585.71    | €0.00       |
      | today | €0.00   | €0.00      | €0.00       |
    And I delete partner account

  @TC.18145
  Scenario: 18145 Add New MozyPro Partner - IE - Monthly - 250 GB - VAT - Coupon - CC
    When I add a new MozyPro partner:
      | period | base plan | create under    | vat number | coupon              | country | address           | city      | state | zip   | phone          |
      | 1      | 250 GB    | MozyPro Ireland | IE9691104A | 10PERCENTOFFOUTLINE | Ireland | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €74.99
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €74.99     | €74.99      |
      | Discounts Applied |          |            | -€7.50      |
      | Pre-tax Subtotal  |          |            | €67.49      |
      | Taxes             |          |            | €17.25      |
      | Total Charges     |          |            | €84.74      |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent:                   | Next Charge:  | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro Ireland (MozyPro) | after 1 month | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 | VAT Number: |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | Ireland          | 1-877-486-9273 | <%=@partner.admin_info.email%> | IE9691104A  |
    And Partner account attributes should be:
      | Backup Keys            |          |
      | Backup Key Soft Cap    | Disabled |
      | Server Enabled         | Disabled |
      | Cloud Storage (GB)     |          |
      | Stash Users:           |          |
      | Default Stash Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 250       | 250      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Credit Card   | Current Period: | Monthly            |
      | Unpaid Balance: | €0.00         | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month | Renewal Period: | Use Current Period |
    And Partner billing history should be:
      | Date  | Amount | Total Paid | Balance Due |
      | today | €84.74 | €84.74     | €0.00       |
      | today | €0.00  | €0.00      | €0.00       |
    And I delete partner account

  @TC.18148
  Scenario: 18148 Add New MozyPro Partner - UK - Yearly - 500 GB - VAT - Coupon - CC
    When I add a new MozyPro partner:
      | period | base plan | create under | vat number  | coupon              | country        | address           | city      | state | zip   | phone          |
      | 12     | 500 GB    | MozyPro UK   | GB117223643 | 10PERCENTOFFOUTLINE | United Kingdom | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be £1,374.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | £1,374.89  | £1,374.89   |
      | Discounts Applied |          |            | -£137.49    |
      | Pre-tax Subtotal  |          |            | £1,237.40   |
      | Total Charges     |          |            | £1,237.40   |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent:              | Next Charge: | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro UK (MozyPro) | after 1 year | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 | VAT Number: |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United Kingdom   | 1-877-486-9273 | <%=@partner.admin_info.email%> | GB117223643 |
    And Partner account attributes should be:
      | Backup Keys            |          |
      | Backup Key Soft Cap    | Disabled |
      | Server Enabled         | Disabled |
      | Cloud Storage (GB)     |          |
      | Stash Users:           |          |
      | Default Stash Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 500       | 500      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Credit Card  | Current Period: | Yearly             |
      | Unpaid Balance: | £0.00        | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year | Renewal Period: | Use Current Period |
    And Partner billing history should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | £1,237.40 | £1,237.40  | £0.00       |
      | today | £0.00     | £0.00      | £0.00       |
    And I delete partner account

  @TC.18151
  Scenario: 18151 Add New MozyPro Partner US - Biennially - 1 TB - Server Plan - 10 Add on - Net Terms
    When I add a new MozyPro partner:
      | period | base plan | server plan | storage add on | net terms | country       | address           | city      | state abbrev | zip   | phone          |
      | 24     | 1 TB      | yes         | 10             | yes       | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be $28,557.48
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 1 TB             | 1        | $7,979.79  | $7,979.79   |
      | Server Plan      | 1        | $629.79    | $629.79     |
      | 250 GB Add-on    | 10       | $1,994.79  | $19,947.90  |
      | Pre-tax Subtotal |          |            | $28,557.48  |
      | Total Charges    |          |            | $28,557.48  |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent: | Next Charge:  | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro | after 2 years | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Keys            |          |
      | Backup Key Soft Cap    | Disabled |
      | Server Enabled         | Enabled  |
      | Cloud Storage (GB)     |          |
      | Stash Users:           |          |
      | Default Stash Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 3524      | 3524     | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30  | Current Period: | Biennial           |
      | Unpaid Balance: | $28,557.48    | Collect On:     | N/A                |
      | Renewal Date:   | after 2 years | Renewal Period: | Use Current Period |
    And Partner billing history should be:
      | Date  | Amount     | Total Paid | Balance Due |
      | today | $28,557.48 | $0.00      | $28,557.48  |
      | today | $0.00      | $0.00      | $0.00       |
    And I delete partner account

  @TC.18154
  Scenario: 18154 Add New MozyPro Partner - FR - Monthly - 2 TB - Server Plan - Net Terms
    When I add a new MozyPro partner:
      | period | base plan | create under   | server plan | net terms | country | address           | city      | state | zip   | phone          |
      | 1      | 2 TB      | MozyPro France | yes         | yes       | France  | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €609.98
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 2 TB             | 1        | €579.99    | €579.99     |
      | Server Plan      | 1        | €29.99     | €29.99      |
      | Pre-tax Subtotal |          |            | €609.98     |
      | Taxes            |          |            | €140.30     |
      | Total Charges    |          |            | €750.28     |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent:                  | Next Charge:  | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro France (MozyPro) | after 1 month | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | France           | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Keys            |          |
      | Backup Key Soft Cap    | Disabled |
      | Server Enabled         | Enabled  |
      | Cloud Storage (GB)     |          |
      | Stash Users:           |          |
      | Default Stash Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 2048      | 2048     | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30  | Current Period: | Monthly            |
      | Unpaid Balance: | €750.28       | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month | Renewal Period: | Use Current Period |
    And Partner billing history should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | €750.28 | €0.00      | €750.28     |
      | today | €0.00   | €0.00      | €0.00       |
    And I delete partner account

  @TC.18851
  Scenario: 18851 Add New MozyPro Partner - DE - Yearly - 4 TB - Server Plan - Net Terms
    When I add a new MozyPro partner:
      | period | base plan | create under    | server plan | net terms | country | address           | city      | state | zip   | phone          |
      | 12     | 4 TB      | MozyPro Germany | yes         | yes       | Germany | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €12,649.78
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 4 TB             | 1        | €12,209.89 | €12,209.89  |
      | Server Plan      | 1        | €439.89    | €439.89     |
      | Pre-tax Subtotal |          |            | €12,649.78  |
      | Taxes            |          |            | €2,909.44   |
      | Total Charges    |          |            | €15,559.22  |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent:                   | Next Charge: | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro Germany (MozyPro) | after 1 year | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | Germany          | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Keys            |          |
      | Backup Key Soft Cap    | Disabled |
      | Server Enabled         | Enabled  |
      | Cloud Storage (GB)     |          |
      | Stash Users:           |          |
      | Default Stash Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 4096      | 4096     | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30 | Current Period: | Yearly             |
      | Unpaid Balance: | €15,559.22   | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year | Renewal Period: | Use Current Period |
    And Partner billing history should be:
      | Date  | Amount     | Total Paid | Balance Due |
      | today | €15,559.22 | €0.00      | €15,559.22  |
      | today | €0.00      | €0.00      | €0.00       |
    And I delete partner account

  @TC.18852
  Scenario: 18852 Add New MozyPro Partner - IE - Biennially - 8 TB - Server Plan - Net Terms
    When I add a new MozyPro partner:
      | period | base plan | create under    | server plan | net terms | country | address           | city      | state | zip   | phone          |
      | 24     | 8 TB      | MozyPro Ireland | yes         | yes       | Ireland | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €48,299.16
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 8 TB             | 1        | €46,619.58 | €46,619.58  |
      | Server Plan      | 1        | €1,679.58  | €1,679.58   |
      | Pre-tax Subtotal |          |            | €48,299.16  |
      | Taxes            |          |            | €11,108.80  |
      | Total Charges    |          |            | €59,407.96  |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent:                   | Next Charge:  | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro Ireland (MozyPro) | after 2 years | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | Ireland          | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Keys            |          |
      | Backup Key Soft Cap    | Disabled |
      | Server Enabled         | Enabled  |
      | Cloud Storage (GB)     |          |
      | Stash Users:           |          |
      | Default Stash Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 8192      | 8192     | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30  | Current Period: | Biennial           |
      | Unpaid Balance: | €59,407.96    | Collect On:     | N/A                |
      | Renewal Date:   | after 2 years | Renewal Period: | Use Current Period |
    And Partner billing history should be:
      | Date  | Amount     | Total Paid | Balance Due |
      | today | €59,407.96 | €0.00      | €59,407.96  |
      | today | €0.00      | €0.00      | €0.00       |
    And I delete partner account

  @TC.18853
  Scenario: 18853 Add New MozyPro Partner - UK - Monthly - 12 TB - Server Plan - Net Terms
    When I add a new MozyPro partner:
      | period | base plan | create under | server plan | net terms | country        | address           | city      | state | zip   | phone          |
      | 1      | 12 TB     | MozyPro UK   | yes         | yes       | United Kingdom | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be £2,837.94
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 12 TB            | 1        | £2,732.97  | £2,732.97   |
      | Server Plan      | 1        | £104.97    | £104.97     |
      | Pre-tax Subtotal |          |            | £2,837.94   |
      | Taxes            |          |            | £652.72     |
      | Total Charges    |          |            | £3,490.66   |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent:              | Next Charge:  | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro UK (MozyPro) | after 1 month | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United Kingdom   | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Keys            |          |
      | Backup Key Soft Cap    | Disabled |
      | Server Enabled         | Enabled  |
      | Cloud Storage (GB)     |          |
      | Stash Users:           |          |
      | Default Stash Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 12288     | 12288    | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30  | Current Period: | Monthly            |
      | Unpaid Balance: | £3,490.66     | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month | Renewal Period: | Use Current Period |
    And Partner billing history should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | £3,490.66 | £0.00      | £3,490.66   |
      | today | £0.00     | £0.00      | £0.00       |
    And I delete partner account

  @TC.17956
  Scenario: 17956 Add New MozyPro Partner - US - Yearly - 16 TB - Server Plan - 10 Storage Add on - CC
    When I add a new MozyPro partner:
      | period | base plan | server plan | storage add on | country       | address           | city      | state abbrev | zip   | phone          |
      | 12     | 16 TB     | yes         | 10             | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be $76,008.02
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 16 TB            | 1        | $63,359.56 | $63,359.56  |
      | Server Plan      | 1        | $2,199.56  | $2,199.56   |
      | 250 GB Add-on    | 10       | $1,044.89  | $10,448.90  |
      | Pre-tax Subtotal |          |            | $76,008.02  |
      | Total Charges    |          |            | $76,008.02  |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent: | Next Charge: | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro | after 1 year | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Keys            |          |
      | Backup Key Soft Cap    | Disabled |
      | Server Enabled         | Enabled  |
      | Cloud Storage (GB)     |          |
      | Stash Users:           |          |
      | Default Stash Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 18884     | 18884    | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Credit Card  | Current Period: | Yearly             |
      | Unpaid Balance: | $0.00        | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year | Renewal Period: | Use Current Period |
    And Partner billing history should be:
      | Date  | Amount     | Total Paid | Balance Due |
      | today | $76,008.02 | $76,008.02 | $0.00       |
      | today | $0.00      | $0.00      | $0.00       |
    And I delete partner account

  @TC.17957
  Scenario: 17957 Add New MozyPro Partner - FR - Biennially - 20 TB - Server Plan - 10 Storage Add on - VAT - Coupon - Net Terms
    When I add a new MozyPro partner:
      | period | base plan | create under   | server plan | storage add on | net terms | vat number    | coupon              | country | address           | city      | state | zip   | phone          |
      | 24     | 20 TB     | MozyPro France | yes         | 10             | yes       | FR08410091490 | 10PERCENTOFFOUTLINE | France  | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €136,495.80
    And Order summary table should be:
      | Description       | Quantity | Price Each  | Total Price |
      | 20 TB             | 1        | €116,548.95 | €116,548.95 |
      | Server Plan       | 1        | €4,198.95   | €4,198.95   |
      | 250 GB Add-on     | 10       | €1,574.79   | €15,747.90  |
      | Discounts Applied |          |             | -€13,649.59 |
      | Pre-tax Subtotal  |          |             | €122,846.21 |
      | Total Charges     |          |             | €122,846.21 |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent:                  | Next Charge:  | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro France (MozyPro) | after 2 years | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | France           | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Keys            |          |
      | Backup Key Soft Cap    | Disabled |
      | Server Enabled         | Enabled  |
      | Cloud Storage (GB)     |          |
      | Stash Users:           |          |
      | Default Stash Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 22980     | 22980    | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30  | Current Period: | Biennial           |
      | Unpaid Balance: | €122,846.21   | Collect On:     | N/A                |
      | Renewal Date:   | after 2 years | Renewal Period: | Use Current Period |
    And Partner billing history should be:
      | Date  | Amount      | Total Paid | Balance Due |
      | today | €122,846.21 | €0.00      | €122,846.21 |
      | today | €0.00       | €0.00      | €0.00       |
    And I delete partner account

  @TC.17979
  Scenario: 17979 Add New MozyPro Partner Without Initial Purchases
    When I add a new MozyPro partner:
      | period | country       | address           | city      | state abbrev | zip   | phone          |
      | 1      | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be 0
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent: | Next Charge:  | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro | after 1 month | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Keys            |          |
      | Backup Key Soft Cap    | Disabled |
      | Server Enabled         | Disabled |
      | Cloud Storage (GB)     |          |
      | Stash Users:           |          |
      | Default Stash Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 0         | 0        | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Other/None    | Current Period: | Monthly            |
      | Unpaid Balance: | $0.00         | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month | Renewal Period: | Use Current Period |
    And Partner billing history should be:
      | Date  | Amount | Total Paid | Balance Due |
      | today | $0.00  | $0.00      | $0.00       |
    And I delete partner account

  @TC.18720
  Scenario: 18720 Verify MozyPro partner has 3 period options
    When I navigate to Add New Partner section from bus admin console page
    Then MozyPro partner subscription period options should be:
      | Monthly | Yearly | Biennially |

  @TC.20377
  Scenario: 20377 Add New MozyPro Partner - US - Monthly - 50 GB - Server Plan - 100PercentDiscountCoupon - CC
    When I add a new MozyPro partner:
      | period | base plan | server plan | coupon               |
      | 1      | 50 GB     | yes         | 100PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $26.98
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 50 GB             | 1        | $19.99     | $19.99      |
      | Server Plan       | 1        | $6.99      | $6.99       |
      | Discounts Applied |          |            | -$26.98     |
      | Total Charges     |          |            | $0.00       |
    And New partner should be created
    And Partner billing history should be:
      | Date  | Amount | Total Paid | Balance Due |
      | today | $0.00  | $0.00      | $0.00       |
      | today | $0.00  | $0.00      | $0.00       |
    And I delete partner account
