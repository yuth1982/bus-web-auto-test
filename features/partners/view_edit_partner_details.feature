Feature: BUS Regression partner test

  Background:
    Given I log in bus admin console as administrator

    @TC.1649 @selenium @bus @others
    Scenario: 1649 Set a partners subdomain
    When I add a new MozyPro partner:
    | period | base plan |
    | 1      | 50 GB     |
    Then New partner should be created
    When I change the subdomain to @subdomain
    Then The subdomain is created with name https://@subdomain.mozypro.com/
    And The subdomain in BUS will be @subdomain
    And I delete partner account

  @TC.1051 @bus @2.5 @partner
  Scenario: 1051 Verify Partner Details Links - Strings
    When I add a new MozyPro partner:
      | period | base plan | country       | address           | city      | state abbrev | zip   | phone          |
      | 1      | 10 GB     | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be $9.99
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 10 GB            | 1        | $9.99      | $9.99       |
      | Pre-tax Subtotal |          |            | $9.99       |
      | Total Charges    |          |            | $9.99       |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent:| Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro| @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 10        | 10       | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Credit Card            | Current Period: | Monthly            |
      | Unpaid Balance: | $0.00                  | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount | Total Paid | Balance Due |
      | today | $9.99  | $9.99      | $0.00       |
      | today | $0.00  | $0.00      | $0.00       |
    And I delete partner account