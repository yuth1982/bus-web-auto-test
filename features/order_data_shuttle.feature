Feature:
  Order data shuttle

  Background:
    Given I log in bus admin console as administrator

  @TC.16188 @require_test_account
  Scenario: Mozy-16188 Verify Shipping Address Section Populated Fields Correctly
    When I order data shuttle for MozyEnterprise test company name
    Then Verify shipping address table should match:
    | description            | value                  |
    | Name:                  | Angela Castillo        |
    | Address 1:             | 628 American Ash Point |
    | Address 2:             |                        |
    | City:                  | Newark                 |
    | State/Province/Region: | NV                     |
    | Country:               | United States          |
    | Zip/Postal Code:       | 12345                  |
    | Phone Number:          | 1234567890             |
    | Power Adapter:         |                        |

  @TC.16190 @require_test_account
  Scenario: Verify shipping address power adapter field validate
    When I order data shuttle for MozyEnterprise test company name
    And I go to next section without select power adapter in verify shipping address section
    Then Order data shuttle error message should match: Please select the power adapter type.

  @TC.16183 @require_test_account
  Scenario: Mozy-16183 Verify ordering data shuttle exceed partner available resources
    And I order data shuttle for MozyEnterprise test company name
    And I order a available key with Data Shuttle US power adapter, 50 GB quota, assigned to no one, 0 discount
    Then Order data shuttle error message should match: The resources added in this Data Shuttle order exceed those available for this partner. Please visit the Change Plan page to add more resources.

  @TC.16325 @require_test_account
  Scenario: Mozy-16325 Ordering data shuttle with 110% Discount
    When I order data shuttle for MozyEnterprise test company name
    And I order a available key with Data Shuttle US power adapter, 2 GB quota, assigned to no one, 110 discount
    Then Order data shuttle error message should match: Discount >100% are not allowed.

  @TC.16184 @require_test_account
  Scenario: Mozy-16184 Verify ordering data shuttle exceed partner available licence
    And I order data shuttle for MozyEnterprise test company name
    And I order a new key with Data Shuttle US power adapter, 2 GB quota, assigned to no one, 0 discount
    Then Order data shuttle error message should match: The resources added in this Data Shuttle order exceed those available for this partner. Please visit the Change Plan page to add more resources.

  @TC.16209 @slow
  Scenario: Mozy-16209 Ordering data shuttle for MozyEnterprise using the Add Link with Unassigned email
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    And I order data shuttle for the new partner company name
    And I order a available key with Data Shuttle US power adapter, 20 GB quota, assigned to no one, 0 discount
    Then Order data shuttle successful message should match: Data Shuttle Device for Pro Partner the new partner company name created.

  @TC.16208 @slow
  Scenario: Mozy-16208 Ordering data shuttle for MozyEnterprise using the Add Link with assigned email
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    And I order data shuttle for the new partner company name
    And I order a available key with Data Shuttle US power adapter, 20 GB quota, assigned to the new partner email, 0 discount
    Then Order data shuttle successful message should match: Data Shuttle Device for Pro Partner the new partner company name created.

  @TC.16207 @slow
  Scenario: Mozy-16207 Ordering data shuttle for MozyPro using the Add New Key Link with unassigned email
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 base plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    And I order data shuttle for the new partner company name
    And I order a new key with Data Shuttle US power adapter, 20 GB quota, assigned to no one, 0 discount
    Then Order data shuttle successful message should match: Data Shuttle Device for Pro Partner the new partner company name created.

  @TC.16205 @slow
  Scenario: Mozy-16207 Ordering data shuttle for MozyPro using the Add New Key Link with assigned email
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 base plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    And I order data shuttle for the new partner company name
    And I order a new key with Data Shuttle US power adapter, 20 GB quota, assigned to the new partner email, 0 discount
    Then Order data shuttle successful message should match: Data Shuttle Device for Pro Partner the new partner company name created.

  @TC.16324 @slow
  Scenario: Mozy-16324 Ordering data shuttle with 50% discount
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    And I order data shuttle for the new partner company name
    And I order a available key with Data Shuttle US power adapter, 10 GB quota, assigned to the new partner email, 50 discount
    Then Data shuttle order summary should match:
    | Description         | Quantity | Total    |
    | Data Shuttle 1.8 TB | 1        | $137.50  |
    | Total Price         |          | $137.50  |
    And Order data shuttle successful message should match: Data Shuttle Device for Pro Partner the new partner company name created.

  @TC.16323 @slow
  Scenario: Mozy-16323 Ordering data shuttle with 100% discount
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    And I order data shuttle for the new partner company name
    And I order a available key with Data Shuttle US power adapter, 10 GB quota, assigned to the new partner email, 100 discount
    #Then Data shuttle order summary should match:
    #| Description         | Quantity | Total  |
    #| Data Shuttle 1.8 TB | 1        | $0.00  |
    #| Total Price         |          | $0.00  |
    And Order data shuttle successful message should match: Data Shuttle Device for Pro Partner the new partner company name created.

  @TC.16211 @slow
  Scenario: Mozy-16211 Canceling orders that were created using the Add Link
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    And I order data shuttle for the new partner company name
    And I order a available key with Data Shuttle US power adapter, 20 GB quota, assigned to no one, 0 discount
    Then Order data shuttle successful message should match: Data Shuttle Device for Pro Partner the new partner company name created.
    When I search data shuttle order by the new partner company name
    And I cancel the latest data shuttle order
    Then The latest order status should be Cancelled

  @TC.16212 @slow
  Scenario: Mozy-16211 Canceling orders that were created using the Add Link
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 base plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    And I order data shuttle for the new partner company name
    And I order a new key with Data Shuttle US power adapter, 20 GB quota, assigned to no one, 0 discount
    Then Order data shuttle successful message should match: Data Shuttle Device for Pro Partner the new partner company name created.
    When I search data shuttle order by the new partner company name
    And I cancel the latest data shuttle order
    Then The latest order status should be Cancelled