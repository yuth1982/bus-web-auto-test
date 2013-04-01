Feature: Add a new partner through phoenix

  As a business owner
  I want to create a partner through phoenix
  So that I can organize my business in a way that works for me

  Background:
    Given I am at dom selection point:
  #-- phoenix smoke test --
  #   adding bus smoke test line items to a phoenix test
  #   and verifying that they will work without any problem, once tweaked.
  @TC.13502 @smoke
  Scenario: 13502 Add a new US monthly MozyPro partner
    When I add a phoenix Pro partner:
      | period | base plan | country       | server plan |
      | 1      | 100 GB    | United States | yes         |
    Then the order summary looks like:
      | Description           | Price  | Quantity | Amount |
      | 100 GB - Monthly      | $39.99 | 1        | $39.99 |
      | Server Plan - Monthly | $12.99 | 1        | $12.99 |
      | Total Charge          | $52.98 |          | $52.98 |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent: | Next Charge:   | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro | after 1 month  | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Contact Email:   |
      | MozyPro       | 0      | @address          | @city         | @state         | @zip_code                | @country         | @new_admin_email |
    And Partner account attributes should be:
      | Backup Licenses         | 400     |
      | Backup License Soft Cap | Enabled |
      | Server Enabled          | Enabled |
      | Cloud Storage (GB)      | 100     |
      | Stash Users:            |         |
      | Default Stash Storage:  |         |
    And Partner resources should be:
      |                     | Used      | Allocated | Limit |
      | Backup Licenses     | 0         | 20        | 400   |
      | Cloud Storage (GB)  | 0         | 100       | 100   |
      | Server Enabled      | Enabled   |           |       |
    And Partner internal billing should be:
      | Account Type:   | Credit Card   | Current Period: | Monthly             |
      | Unpaid Balance: | $0.00         | Collect On:     | N/A                 |
      | Renewal Date:   | after 1 month | Renewal Period: | Use Current Period  |
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 500 GB    |
    Then Change plan charge summary should be:
      | Description                   | Amount   |
      | Credit for remainder of plans | -$52.98  |
      | Charge for upgraded plans     | $209.98  |
      |                               |          |
      | Total amount to be charged    | $157.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 500 GB    |
    When I add a new user:
      | server licenses | server quota | desktop licenses | desktop quota |
      | 1               | 10           | 1                | 10            |
    Then New user should be created
    When I change account subscription up to biennial period
    Then Subscription changed message should be Your account has been changed to biennial billing.
    When I log in aria admin console as administrator
    Then newly created partner admin email account status should be ACTIVE
    When I log in bus admin console as administrator
    Then I search and delete partner account by newly created partner company name
    When I search emails by keywords:
      | content          |
      | @new_admin_email |
    Then I should see 2 email(s)
