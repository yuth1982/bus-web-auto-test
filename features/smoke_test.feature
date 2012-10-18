Feature: Bus Smoke Test

  Background:
    #Given I log in bus admin console as administrator

  @TC.18361 @slow @chrome
  Scenario: 18361 Mozy Enterprise Smoke Test
#    When I add a new MozyEnterprise partner:
#      | period | users | server plan | server add-on | address           | city      | state abbrev | zip   | country       | phone          | admin email                      | admin name   |
#      | 24     | 1     | 100 GB      | 1             | 3401 Hillview Ave | Palo Alto | CA           | 94304 | United States | 1-877-486-9273 | qa1+test+create+partner@mozy.com | vmware admin |
#    Then Order summary table should be:
#      | Description           | Quantity | Price Each | Total Price |
#      | MozyEnterprise User   | 1        | $181.00    | $181.00     |
#      | 100 GB Server Plan    | 1        | $1,112.58  | $1,112.58   |
#      | 250 GB Server Add-on  | 1        | $1,994.79  | $1,994.79   |
#      | Pre-tax Subtotal      |          |            | $3,288.37   |
#      | Total Charges         |          |            | $3,288.37   |
#    Then New partner should be created
#    And Partner general information should be:
#      | ID:     | External ID: | Aria ID:  | Approved:  | Status:         | Root Admin:           | Root Role:          | Parent:        | Next Charge:          | Marketing Referrals:                   | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Autogrow: |
#      | @xxxxxx | (change)     | @xxxxxxx  | @today     | Active (change) | vmware admin (act as) | Enterprise (change) | MozyEnterprise | +24 month(s) (extend) | @parent_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No               |
#    And Partner contact information should be:
#      | Company Type:  | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Industry: | # of employees: | Contact Email:                   |
#      | MozyEnterprise | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 |           |                 | qa1+test+create+partner@mozy.com |
#    When I act as newly created partner account
#    When I change MozyEnterprise account plan to:
#      | users | server plan | server add-on |
#      | 15    | 500 GB      | 5             |
#    Then Change plan charge summary should be:
#      | Description                                | Amount      |
#      | Credit for remainder of 100 GB Server Plan | -$1,112.58  |
#      | Charge for upgraded plans                  | $14,922.74  |
#      |                                            |             |
#      | Total amount to be charged                 | $13,810.16  |
#    And Account plan should be changed
#    And MozyEnterprise new plan should be:
#      | users | server plan | server add-on |
#      | 15    | 500 GB      | 5             |
#    When I add a new user group:
#      | name       | default server quota | default desktop quota |
#      | test group | 20                   | 10                    |
#    Then New user group should be created
#    When I transfer resources from (default user group) to test group with:
#    | server licenses | server quota GB | desktop licenses | desktop quota GB |
#    | 2               | 20              | 2                | 20               |
#    Then Resources should be transferred
#    When I navigate to the new user group details section
#    Then User group details should be:
#      | ID:     | External ID: | Billing code: | Status:         | Available Keys: | Available Quota: | Default quota for new installs:             | Default user group: |
#      | @xxxxxx | (change)     | (change)      | Active (change) | 4               | 40 GB            | 10 GB (Desktop) and 20 GB (Server) (change) | No (make default)   |
#    When I add a new user:
#      | user group  | server licenses | server quota | desktop licenses | desktop quota |
#      | test group  | 1               | 10           | 1                | 10            |
#    Then New user should be created
#    When I assign a key in user group the new user group with email qa1+test+user+group@mozy.com
#    Then Key should be assigned
    When I log in aria admin console as aria admin
    Then mozyenterprise test account account status should be ACTIVE
    Then I search and delete the new partner account
    Then I should see 3 email(s) when I search keywords:
      | content                           |
      | qa1+test+create+partner@mozy.com  |

@dl_test @chrome
  Scenario: Test
    Given I log in bus admin console as administrator
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add-on | address           | city      | state abbrev | zip   | country       | phone          | admin email                      | admin name   |
      | 24     | 1     | 100 GB      | 1             | 3401 Hillview Ave | Palo Alto | CA           | 94304 | United States | 1-877-486-9273 | qa1+test+create+partner@mozy.com | vmware admin |
    Then New partner should be created
    And Partner general information should be:
      | ID:     | External ID: | Aria ID:  | Approved:  | Status:         | Root Admin:           | Root Role:          | Parent:        | Next Charge:          | Marketing Referrals:                   | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Autogrow: |
      | @xxxxxx | (change)     | @xxxxxxx  | @today     | Active (change) | vmware admin (act as) | Enterprise (change) | MozyEnterprise | +24 month(s) (extend) | @parent_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No               |
    And Partner contact information should be:
    | Company Type:  | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Industry: | # of employees: | Contact Email:                   |
    | MozyEnterprise | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 |           |                 | qa1+test+create+partner@mozy.com |
    Then I delete partner account