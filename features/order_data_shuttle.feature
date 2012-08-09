Feature:
  Order data shuttle

  Background:
    Given I log in bus admin console as administrator

  @TC.16188 @require_test_account
  Scenario: 16188 Verify Shipping Address Section Populated Fields Correctly
    When I navigate to process data shuttle order section for mozyenterprise test account
    Then Verify shipping address table should be:
    | description            | value                  |
    | Name:                  | Ruth Phillips          |
    | Address 1:             | 5 Armistice Drive      |
    | Address 2:             |                        |
    | City:                  | Brawley                |
    | State/Province/Region: | IL                     |
    | Country:               | United States          |
    | Zip/Postal Code:       | 12345                  |
    | Phone Number:          | 1234567890             |
    | Power Adapter:         |                        |

  @TC.16190 @require_test_account
  Scenario: 16190 Verify shipping address power adapter field validate
    When I navigate to process data shuttle order section for mozyenterprise test account
    And I go to next section without select power adapter in verify shipping address section
    Then Order data shuttle error message should be Please select the power adapter type.

  @TC.16183 @require_test_account
  Scenario: 16183 Verify ordering data shuttle exceed partner available resources
    When I order data shuttle for mozyenterprise test account
    | key from  | quota |
    | available | 5000  |
    Then Order data shuttle error message should be The resources added in this Data Shuttle order exceed those available for this partner. Please visit the Change Plan page to add more resources.

  @TC.16325 @require_test_account
  Scenario: 16325 Ordering data shuttle with 110% Discount
    When I order data shuttle for mozyenterprise test account
    | key from  | discount |
    | available | 110      |
    Then Order data shuttle error message should be Discount >100% are not allowed.

  @TC.16184 @require_test_account
  Scenario: 16184 Verify ordering data shuttle exceed partner available licence
    When I order data shuttle for mozyenterprise test account
    | key from | discount |
    | new      | 110      |
    Then Order data shuttle error message should be The resources added includes new key. Please use only existing keys for this partner

  @TC.16209 @slow @smoke
  Scenario: 16209 Ordering data shuttle for MozyEnterprise using the Add Link with Unassigned email
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 1     |
    Then New partner should created
    When I order data shuttle for the new partner account
    | key from  | quota |
    | available | 20    |
    Then Data shuttle order summary should be:
    | Description         | Quantity | Total    |
    | Data Shuttle 1.8 TB | 1        | $275.00  |
    | Total Price         |          | $275.00  |
    Then Data shuttle order should be created

  @TC.16208 @slow
  Scenario: 16208 Ordering data shuttle for MozyEnterprise using the Add Link with assigned email
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 1     |
    Then New partner should created
    When I order data shuttle for the new partner account
    | key from  | quota | assign to |
    | available | 20    | @email    |
    Then Data shuttle order should be created

  @TC.16207 @slow @smoke
  Scenario: 16207 Ordering data shuttle for MozyPro using the Add New Key Link with unassigned email
    When I add a new MozyPro partner:
    | period | base plan     |
    | 1      | 50 GB, $19.99 |
    Then New partner should created
    When I order data shuttle for the new partner account
    | key from | quota |
    | new      | 20    |
    Then Data shuttle order summary should be:
    | Description         | Quantity | Total    |
    | Data Shuttle 1.8 TB | 1        | $275.00  |
    | Total Price         |          | $275.00  |
    Then Data shuttle order should be created

  @TC.16205 @slow
  Scenario: 16207 Ordering data shuttle for MozyPro using the Add New Key Link with assigned email
    When I add a new MozyPro partner:
    | period | base plan     |
    | 1      | 50 GB, $19.99 |
    Then New partner should created
    When I order data shuttle for the new partner account
    | key from | quota | assign to |
    | new      | 20    | @email    |
    Then Data shuttle order should be created

  @TC.16324 @slow @browser_on_top
  Scenario: 16324 Ordering data shuttle with 50% discount
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 1     |
    Then New partner should created
    When I order data shuttle for the new partner account
    | key from  | quota | assign to | discount |
    | available | 10    | @email    | 50       |
    Then Data shuttle order summary should be:
    | Description         | Quantity | Total    |
    | Data Shuttle 1.8 TB | 1        | $137.50  |
    | Total Price         |          | $137.50  |
    Then Data shuttle order should be created

  @TC.16323 @slow @browser_on_top
  Scenario: 16323 Ordering data shuttle with 100% discount
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 1     |
    Then New partner should created
    When I order data shuttle for the new partner account
    | key from  | quota | assign to | discount |
    | available | 10    | @email    | 100      |
    Then Data shuttle order summary should be:
    | Description         | Quantity | Total  |
    | Data Shuttle 1.8 TB | 1        | $0.00  |
    | Total Price         |          | $0.00  |
    Then Data shuttle order should be created

  @TC.16211 @slow
  Scenario: 16211 Canceling orders that were created using the Add Link
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 1     |
    Then New partner should created
    When I order data shuttle for the new partner account
    | key from  | quota |
    | available | 20    |
    Then Data shuttle order should be created
    When I cancel the latest data shuttle order for the new partner account
    Then The order should be Cancelled

  @TC.16212 @slow
  Scenario: 16212 Canceling orders that were created using the Add New Key Link
    When I add a new MozyPro partner:
    | period | base plan     |
    | 1      | 50 GB, $19.99 |
    Then New partner should created
    When I order data shuttle for the new partner account
    | key from | quota |
    | new      | 20    |
    Then Data shuttle order should be created
    When I cancel the latest data shuttle order for the new partner account
    Then The order should be Cancelled

  @TC.17879 @slow
  Scenario: 17879 Ordering data shuttle over 1.8T for Reseller using the Add New Key Link
    When I add a new Reseller partner:
    | period | reseller type | reseller quota |
    | 1      | Silver        | 2000           |
    Then New partner should created
    When I order data shuttle for the new partner account
    | key from | quota |
    | new      | 2000  |
    Then Data shuttle order should be created
    Then Data shuttle order summary should be:
    | Description         | Quantity | Total   |
    | Data Shuttle 3.6 TB | 1        | $375.00 |
    | Total Price         |          | $375.00 |
    Then The number of win drivers should be 2

  @TC.16320 @slow
  Scenario: 17879 Ordering data shuttle over 3.6T for MozyPro using the Add New Key Link
    When I add a new MozyPro partner:
    | period | base plan       |
    | 1      | 4 TB, $1,439.99 |
    Then New partner should created
    When I order data shuttle for the new partner account
    | key from | quota |
    | new      | 3800  |
    Then Data shuttle order should be created
    Then Data shuttle order summary should be:
    | Description         | Quantity | Total   |
    | Data Shuttle 5.4 TB | 1        | $475.00 |
    | Total Price         |          | $475.00 |
    Then The number of win drivers should be 3

  @TC.16340 @slow
  Scenario: 16340 Manually change number of windows drives ordered
    When I add a new Reseller partner:
    | period | reseller type | reseller quota |
    | 1      | Silver        | 2000           |
    Then New partner should created
    When I order data shuttle for the new partner account
    | key from | quota | win drivers |
    | new      | 1000  | 2           |
    Then Data shuttle order should be created
    Then The number of win drivers should be 2

  @TC.16342 @slow
  Scenario: 16342 Manually change number of mac drives ordered
    When I add a new MozyPro partner:
    | period | base plan       |
    | 1      | 1 TB, $379.99 |
    Then New partner should created
    When I order data shuttle for the new partner account
    | key from  | quota | win drivers | mac drivers |
    | available | 500   | 0           | 2           |
    Then Data shuttle order should be created
    Then The number of mac drivers should be 2

  @TC.17881 @slow
  Scenario: 17881 Verify payment generate in Aria when order a data shuttle
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 1     |
    Then New partner should created
    When I order data shuttle for the new partner account
    | key from  | quota |
    | available | 20    |
    Then Data shuttle order should be created
    When I log in bus admin console as the new partner account
    And I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
    | Date    | Amount  | Total Paid | Balance Due |
    | @today  | $275.00 | $275.00    | $0.00       |
    | @today  | $95.00  | $95.00     | $0.00       |