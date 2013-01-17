Feature: Bus Smoke Test

  Background:
    Given I log in bus admin console as administrator

  @TC.18361 @slow
  Scenario: 18361 Mozy Enterprise Smoke Test
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on | company name | address           | city      | state abbrev | zip   | country       | phone          | admin name   | cc last name | cc first name | cc number        | expire month | expire year | cvv |
      | 24     | 10    | 100 GB      | 1             | Smoke Test   | 3401 Hillview Ave | Palo Alto | CA           | 94304 | United States | 1-877-486-9273 | vmware admin | vmware       | mozy          | 4111111111111111 | 12           | 15          | 123 |
    Then Sub-total before taxes or discounts should be $4,917.37
    And Order summary table should be:
      | Description           | Quantity | Price Each | Total Price |
      | MozyEnterprise User   | 10       | $181.00    | $1,810.00   |
      | 100 GB Server Plan    | 1        | $1,112.58  | $1,112.58   |
      | 250 GB Server Add-on  | 1        | $1,994.79  | $1,994.79   |
      | Pre-tax Subtotal      |          |            | $4,917.37   |
      | Total Charges         |          |            | $4,917.37   |
    And New partner should be created
    And Partner general information should be:
      | ID:     | External ID: | Aria ID:  | Approved:  | Status:         | Root Admin:           | Root Role:          | Parent:        | Next Charge:   | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Autogrow: |
      | @xxxxxx | (change)     | @xxxxxxx  | today      | Active (change) | vmware admin (act as) | Enterprise (change) | MozyEnterprise | after 2 years  | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)      |
    And Partner contact information should be:
      | Company Type:  | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Industry: | # of employees: | Contact Email:   |
      | MozyEnterprise | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 |           |                 | @new_admin_email |
    And Partner account attributes should be:
      | Backup Licenses         |           |
      | Backup License Soft Cap | Disabled  |
      | Server Enabled          | Disabled  |
      | Cloud Storage (GB)      |           |
      | Stash Users:            |           |
      | Default Stash Storage:  |           |
    And Partner license types should be:
      |         | Licenses: | Licenses Used: | Quota:   | Quota Used: | Resource Policy: |
      | Desktop | 10        | 0              | 250 GB   | 0 bytes     | Enabled          |
      | Server  | 200       | 0              | 350 GB   | 0 bytes     | Enabled          |
    And Partner internal billing should be:
      | Account Type:   | Credit Card   | Current Period: | Biennial            |
      | Unpaid Balance: | $0.00         | Collect On:     | N/A                 |
      | Renewal Date:   | after 2 years | Renewal Period: | Use Current Period  |
    And Partner sub admins should be empty
    When I act as newly created partner account
    And I change MozyEnterprise account plan to:
      | users | server plan | storage add-on |
      | 15    | 500 GB      | 5             |
    Then Change plan charge summary should be:
      | Description                                | Amount      |
      | Credit for remainder of 100 GB Server Plan | -$1,112.58  |
      | Charge for upgraded plans                  | $13,293.74  |
      |                                            |             |
      | Total amount to be charged                 | $12,181.16  |
    And the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan | server add-on |
      | 15    | 500 GB      | 5             |
    When I add a new user group:
      | name       | server quota | desktop quota |
      | test group | 20           | 10            |
    Then New user group should be created
    When I transfer resources from (default user group) to test group with:
    | server licenses | server quota GB | desktop licenses | desktop quota GB |
    | 2               | 20              | 2                | 20               |
    Then Resources should be transferred
    When I view newly created user group name user group details
    Then User group details should be:
      | ID:     | External ID: | Billing code: | Available Keys: | Available Quota: | Default quota for new installs:             | Default user group: |
      | @xxxxxx | (change)     | (change)      | 4               | 40 GB            | 10 GB (Desktop) and 20 GB (Server) (change) | No (make default)   |
    When I add a new user to a MozyEnterprise partner:
      | user group  | desired_user_storage | desktop licenses |
      | test group  | 10                   | 1            |
    Then New user should be created
    And I batch assign MozyEnterprise partner Server keys to (default user group) user group with send emails:
      | email                         | quota |
      | qa1+test+user+group@mozy.com  | 5     |
    And I refresh Manage User Group Resources section
    And User group license details table should be:
      |         | Active | Assigned | Unassigned |
      | Desktop | 0      | 0        | 13         |
      | Server  | 0      | 1        | 197        |
    When I change account subscription up to 3-year billing period
    Then Subscription changed message should be Your account has been changed to 3-year billing.
    When I log in aria admin console as administrator
    Then newly created partner admin email account status should be ACTIVE
    When I log in bus admin console as administrator
    Then I search and delete partner account by Smoke Test
    And I should see 3 email(s) when I search keywords:
      | content |
      | @email  |

  @TC.112
  Scenario: MozyPro France
    When I add a new MozyPro partner:
      | period | base plan | create under   | country | vat number    |
      | 12     | 50 GB     | MozyPro France | France  | BE0883236072  |
    Then Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 50 GB             | 1        | €175.89    | €175.89     |
      | Pre-tax Subtotal  |          |            | €175.89     |
      | Total Charges     |          |            | €175.89     |
    And New partner should be created
    And I delete partner account