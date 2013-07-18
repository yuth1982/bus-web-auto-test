Feature: Bus Smoke Test

  Background:
    Given I log in bus admin console as administrator

  @TC.18361 @slow @bus @2.5 @smoke @enterprise
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
      | Status:         | Root Admin:           | Root Role:          | Parent:        | Next Charge:   | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Autogrow: |
      | Active (change) | vmware admin (act as) | Enterprise (change) | MozyEnterprise | after 2 years  | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)      |
    And Partner contact information should be:
      | Company Type:  | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         |
      | MozyEnterprise | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 |
    And Partner account attributes should be:
      | Backup Devices         |           |
      | Backup Device Soft Cap | Disabled  |
      | Server                 | Disabled  |
      | Cloud Storage (GB)     |           |
      | Stash Users:           |           |
      | Default Stash Storage: |           |
    And Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 250       | 250      | 0    | 10        | 10       |
      | Server  | 0    | 350       | 350      | 0    | 200       | 200      |
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
    When I add a new Itemized user group:
      | name        | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | test group  | Assigned             | 10                     | 1               | Assigned            | 20                    | 2              |
    Then test group user group should be created
# It looks like there's some problems when transferring storage to target user group.
# Since those groups are using storage pooled resources. Why do we need to transfer resource at all? e.g. share/shared with max user group
# This verification needs confirm with dev / PO
#    When I view newly created Itemized user group name user group details
#    Then User group details should be:
#      | ID:     | External ID: | Billing code: | Available Keys: | Available Quota: | Default quota for new installs:             | Default user group: |
#      | @xxxxxx | (change)     | (change)      | 7               | 40 GB            | 10 GB (Desktop) and 20 GB (Server) (change) | No (make default)   |
    When I add 1 new user:
      | user_group | storage_type | storage_max | devices |
      | test group | Desktop      | 10          | 1       |
    Then 1 new user should be created
# I don't see manage resource section in 2.5, is this still valid?
#    And I batch assign MozyEnterprise partner Server keys to (default user group) user group with send emails:
#      | email                         | quota |
#      | qa1+test+user+group@mozy.com  | 5     |
#    And I refresh Manage User Group Resources section
#    And User group license details table should be:
#      |         | Active | Assigned | Unassigned |
#      | Desktop | 0      | 0        | 13         |
#      | Server  | 0      | 1        | 197        |
    When I change account subscription up to 3-year billing period
    Then Subscription changed message should be Your account has been changed to 3-year billing.
# Use Aria API to verify
#    When I log in aria admin console as administrator
#    Then newly created partner admin email account status should be ACTIVE
    When I stop masquerading
    Then I search and delete partner account by Smoke Test
#    When I search emails by keywords:
#      | content          |
#      | @new_admin_email |
#    Then I should see 3 email(s)

  @TC.112
  Scenario: 112 MozyPro France
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

   @Test_iframe
   Scenario: Test Client Configuration
     When I create a new client config:
      | name                |
      | smoke_client_config |
     When I add a new MozyPro partner:
       | period | base plan |
       | 1      | 10 GB     |
     And New partner should be created
