Feature: Add a new partner through phoenix

  As a business owner
  I want to create a partner through phoenix
  So that I can organize my business in a way that works for me

  Background:
    Given I am at dom selection point:
    #---------------------------------------------------------------------------------
    # base coverage section:
    #   represents a balanced set of coverage
    #----------------------------------------test matrix------------------------------
    #	partner size:	10        | 50          | 100     | 250     | 500     | 1tb
    #		entries by: country,server/dsk,novat,coupon
    #	monthly:		ie,sv,cp  | ie          | uk      | fr,sv   | de,sv   | us
    #	yearly:			uk,sv     | de,sv,nv,cp | us,sv   | ie,nv   | fr      | fr,cp
    #	biannual:		us        | fr,nv       | de,nv   | de      | uk,nv   | ie,sv
    #		key: server=sv, nv=novat, cp=coupon
    #		coupon code = 10PERCENTOFFOUTLINE
    #       us yearly, 100gb, server = base smoke test
    #----------------------------------------test matrix------------------------------

  @TC.20965 @month
  Scenario: 20965 Add a new US yearly basic MozyPro partner
    When I add a phoenix Pro partner:
      | period | base plan | country       |
      | 1      | 1 TB      | United States |
    Then the order summary looks like:
      | Description   | Price   | Quantity | Amount  |
      | 1 TB - Annual | $379.99 | 1        | $379.99 |
      | Total Charge  | $379.99 |          | $379.99 |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent:           | Next Charge:  | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro (MozyPro) | after 1 month | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Contact Email:   |
      | MozyPro       | 0      | @address          | @city         | @state         | @zip_code                | @country         | @new_admin_email |
    And Partner account attributes should be:
      | Backup Licenses         | 400      |
      | Backup License Soft Cap | Enabled  |
      | Server Enabled          | Disabled |
      | Cloud Storage (GB)      | 1000     |
      | Stash Users:            |          |
      | Default Stash Storage:  |          |
    And Partner resources should be:
      |                     | Used     | Allocated | Limit |
      | Backup Licenses     | 0        | 20        | 400   |
      | Cloud Storage (GB)  | 0        | 1000      | 1000  |
      | Server Enabled      | Disabled |           |       |
    And Partner internal billing should be:
      | Account Type:   | Credit Card   | Current Period: | Monthly             |
      | Unpaid Balance: | $0.00         | Collect On:     | N/A                 |
      | Renewal Date:   | after 1 month | Renewal Period: | Use Current Period  |
    And I delete partner account

  @TC.20966 @biennial
  Scenario: 20966 Add a new US biennial basic MozyPro partner
    When I add a phoenix Pro partner:
      | period | base plan | country      |
      | 24     | 10 GB    | United States |
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
      | Status:         | Root Admin:          | Root Role:                  | Parent:           | Next Charge:  | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro (MozyPro) | after 2 years | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Contact Email:   |
      | MozyPro       | 0      | @address          | @city         | @state         | @zip_code                | @country         | @new_admin_email |
    And Partner account attributes should be:
      | Backup Licenses         | 400      |
      | Backup License Soft Cap | Enabled  |
      | Server Enabled          | Disabled |
      | Cloud Storage (GB)      | 100      |
      | Stash Users:            |          |
      | Default Stash Storage:  |          |
    And Partner resources should be:
      |                     | Used      | Allocated | Limit |
      | Backup Licenses     | 0         | 20        | 400   |
      | Cloud Storage (GB)  | 0         | 100       | 100   |
      | Server Enabled      | Disabled  |           |       |
    And Partner internal billing should be:
      | Account Type:   | Credit Card   | Current Period: | Monthly             |
      | Unpaid Balance: | $0.00         | Collect On:     | N/A                 |
      | Renewal Date:   | after 2 years | Renewal Period: | Use Current Period  |
    And I delete partner account

  @TC.20967 @month @IE
  Scenario: 20967 Add a new IE monthly basic MozyPro partner
    When I add a phoenix Pro partner:
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
      | Status:         | Root Admin:          | Root Role:                  | Parent:                   | Next Charge:  | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro Ireland (MozyPro) | after 1 month | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Contact Email:   |
      | MozyPro       | 0      | @address          | @city         | @state         | @zip_code                | @country         | @new_admin_email |
    And Partner account attributes should be:
      | Backup Licenses         | 400      |
      | Backup License Soft Cap | Enabled  |
      | Server Enabled          | Disabled |
      | Cloud Storage (GB)      | 50       |
      | Stash Users:            |          |
      | Default Stash Storage:  |          |
    And Partner resources should be:
      |                     | Used     | Allocated | Limit |
      | Backup Licenses     | 0        | 20        | 400   |
      | Cloud Storage (GB)  | 0        | 50        | 50    |
      | Server Enabled      | Disabled |           |       |
    And Partner internal billing should be:
      | Account Type:   | Credit Card   | Current Period: | Monthly             |
      | Unpaid Balance: | €0.00         | Collect On:     | N/A                 |
      | Renewal Date:   | after 1 month | Renewal Period: | Use Current Period  |
    And I delete partner account

  @TC.20968 @year @IE @novat
  Scenario: 20968 Add a new IE yearly basic MozyPro partner
    When I add a phoenix Pro partner:
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
      | Status:         | Root Admin:          | Root Role:                  | Parent:                   | Next Charge: | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro Ireland (MozyPro) | after 1 year | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Contact Email:   |
      | MozyPro       | 0      | @address          | @city         | @state         | @zip_code                | @country         | @new_admin_email |
    And Partner account attributes should be:
      | Backup Licenses         | 400      |
      | Backup License Soft Cap | Enabled  |
      | Server Enabled          | Disabled |
      | Cloud Storage (GB)      | 250      |
      | Stash Users:            |          |
      | Default Stash Storage:  |          |
    And Partner resources should be:
      |                     | Used      | Allocated | Limit |
      | Backup Licenses     | 0         | 20        | 400   |
      | Cloud Storage (GB)  | 0         | 250       | 250   |
      | Server Enabled      | Disabled  |           |       |
    And Partner internal billing should be:
      | Account Type:   | Credit Card  | Current Period: | Monthly             |
      | Unpaid Balance: | €0.00        | Collect On:     | N/A                 |
      | Renewal Date:   | after 1 year | Renewal Period: | Use Current Period  |
    And I delete partner account

  @TC.20969 @biennial @IE
  Scenario: 20969 Add a new IE biennial basic MozyPro partner
    When I add a phoenix Pro partner:
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
      | Status:         | Root Admin:          | Root Role:                  | Parent:                   | Next Charge:  | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro Ireland (MozyPro) | after 2 years | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Contact Email:   |
      | MozyPro       | 0      | @address          | @city         | @state         | @zip_code                | @country         | @new_admin_email |
    And Partner account attributes should be:
      | Backup Licenses         | 400      |
      | Backup License Soft Cap | Enabled  |
      | Server Enabled          | Enabled  |
      | Cloud Storage (GB)      | 1000     |
      | Stash Users:            |          |
      | Default Stash Storage:  |          |
    And Partner resources should be:
      |                     | Used      | Allocated | Limit |
      | Backup Licenses     | 0         | 20        | 400   |
      | Cloud Storage (GB)  | 0         | 1000      | 1000  |
      | Server Enabled      | Disabled  |           |       |
    And Partner internal billing should be:
      | Account Type:   | Credit Card   | Current Period: | Monthly             |
      | Unpaid Balance: | €0.00         | Collect On:     | N/A                 |
      | Renewal Date:   | after 2 years | Renewal Period: | Use Current Period  |
    And I delete partner account

  @TC.20970 @month @UK
  Scenario: 20970 Add a new UK monthly basic MozyPro partner
    When I add a phoenix Pro partner:
      | period | base plan | country        | vat number  |
      | 1      | 100 GB    | United Kingdom | GB117223643 |
    Then the order summary looks like:
      | Description            | Price  | Quantity | Amount |
      | 100 GB - Monthly       | £26.99 | 1        | £26.99 |
      | Subscription Price     | £26.99 |          | £26.99 |
      | VAT                    | Exempt |          | Exempt |
      | Total Charge           | £26.99 |          | £26.99 |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I log in bus admin console as administrator
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent:              | Next Charge:  | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro UK (MozyPro) | after 1 month | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Contact Email:   |
      | MozyPro       | 0      | @address          | @city         | @state         | @zip_code                | @country         | @new_admin_email |
    And Partner account attributes should be:
      | Backup Licenses         | 400      |
      | Backup License Soft Cap | Enabled  |
      | Server Enabled          | Disabled |
      | Cloud Storage (GB)      | 100      |
      | Stash Users:            |          |
      | Default Stash Storage:  |          |
    And Partner resources should be:
      |                     | Used     | Allocated | Limit |
      | Backup Licenses     | 0        | 20        | 400   |
      | Cloud Storage (GB)  | 0        | 100       | 100   |
      | Server Enabled      | Disabled |           |       |
    And Partner internal billing should be:
      | Account Type:   | Credit Card   | Current Period: | Monthly             |
      | Unpaid Balance: | £0.00         | Collect On:     | N/A                 |
      | Renewal Date:   | after 1 month | Renewal Period: | Use Current Period  |
    And I delete partner account

  @TC.20971 @year @UK
  Scenario: 20971 Add a new UK yearly basic MozyPro partner
    When I add a phoenix Pro partner:
      | period | base plan | country        | vat number  | server plan |
      | 12     | 10 GB     | United Kingdom | GB117223643 | yes         |
    Then the order summary looks like:
      | Description          | Price  | Quantity | Amount |
      | 10 GB - Annual       | £6.99  | 1        | £6.99  |
      | Server Plan - Annual | £8.99  | 1        | £8.99  |
      | Subscription Price   | £15.98 |          | £15.98 |
      | VAT                  | Exempt |          | Exempt |
      | Total Charge         | £15.98 |          | £15.98 |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent:              | Next Charge: | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro UK (MozyPro) | after 1 year | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Contact Email:   |
      | MozyPro       | 0      | @address          | @city         | @state         | @zip_code                | @country         | @new_admin_email |
    And Partner account attributes should be:
      | Backup Licenses         | 400     |
      | Backup License Soft Cap | Enabled |
      | Server Enabled          | Enabled |
      | Cloud Storage (GB)      | 10      |
      | Stash Users:            |         |
      | Default Stash Storage:  |         |
    And Partner resources should be:
      |                     | Used      | Allocated | Limit |
      | Backup Licenses     | 0         | 20        | 400   |
      | Cloud Storage (GB)  | 0         | 10        | 10    |
      | Server Enabled      | Disabled  |           |       |
    And Partner internal billing should be:
      | Account Type:   | Credit Card  | Current Period: | Monthly             |
      | Unpaid Balance: | £0.00        | Collect On:     | N/A                 |
      | Renewal Date:   | after 1 year | Renewal Period: | Use Current Period  |
    And I delete partner account

  @TC.20972 @biennial @UK @novat
    Scenario: 20972 Add a new UK biennial basic MozyPro partner
      When I add a phoenix Pro partner:
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
        | Status:         | Root Admin:          | Root Role:                  | Parent:              | Next Charge:  | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
        | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro UK (MozyPro) | after 2 years | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
      And Partner contact information should be:
        | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Contact Email:   |
        | MozyPro       | 0      | @address          | @city         | @state         | @zip_code                | @country         | @new_admin_email |
      And Partner account attributes should be:
        | Backup Licenses         | 400      |
        | Backup License Soft Cap | Enabled  |
        | Server Enabled          | Disabled |
        | Cloud Storage (GB)      | 500      |
        | Stash Users:            |          |
        | Default Stash Storage:  |          |
      And Partner resources should be:
        |                     | Used      | Allocated | Limit |
        | Backup Licenses     | 0         | 20        | 400   |
        | Cloud Storage (GB)  | 0         | 500       | 500   |
        | Server Enabled      | Disabled  |           |       |
      And Partner internal billing should be:
        | Account Type:   | Credit Card   | Current Period: | Monthly             |
        | Unpaid Balance: | £0.00         | Collect On:     | N/A                 |
        | Renewal Date:   | after 2 years | Renewal Period: | Use Current Period  |
      And I delete partner account


    #---------------------------------------------------------------------------------
    # extended coverage section:
    #---------------------------------------------------------------------------------
    #   coverage based on changes made to UI, requirements changes, bugs, etc
    #----------------------------------------test matrix------------------------------
