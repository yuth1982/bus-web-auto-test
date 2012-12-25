Feature:
  Order data shuttle

  Background:
    Given I log in bus admin console as administrator

  @TC.16188
  Scenario: 16188 Verify Shipping Address Section Populated Fields Correctly
    When I add a new MozyPro partner:
      | period | base plan | admin name     | country       | address           | city      | state abbrev | zip   | phone          |
      | 1      | 50 GB     | TC.16188 Admin | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then New partner should be created
    When I navigate to process data shuttle order section for newly created partner company name
    Then Verify shipping address table should be:
      | description            | value             |
      | Name:                  | TC.16188 Admin    |
      | Address 1:             | 3401 Hillview Ave |
      | Address 2:             |                   |
      | City:                  | Palo Alto         |
      | State/Province/Region: | CA                |
      | Country:               | United States     |
      | Zip/Postal Code:       | 94304             |
      | Phone Number:          | 1-877-486-9273    |
      | Power Adapter:         |                   |
    And I search and delete partner account by newly created partner company name

  @TC.16190
  Scenario: 16190 Verify shipping address power adapter field validate
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I order data shuttle for newly created partner company name
      | key from  | quota |
      | available | 2     |
    Then Order data shuttle message should be Please select the power adapter type. Please add or create at least one key for the order!
    And I search and delete partner account by newly created partner company name

  @TC.16183
  Scenario: 16183 Verify ordering data shuttle exceed partner available resources
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 5000  |
    Then Order data shuttle message should be The resources added in this Data Shuttle order exceed those available for this partner. Please visit the Change Plan page to add more resources.
    And I search and delete partner account by newly created partner company name

  @TC.16325
  Scenario: 16325 Ordering data shuttle with 110% Discount
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | discount |
      | Data Shuttle US | available | 110      |
    Then Order data shuttle message should be Discount >100% are not allowed. Please correct the value in the red box
    And I search and delete partner account by newly created partner company name

  @TC.16184
  Scenario: 16184 Verify ordering data shuttle exceed partner available licence
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I order data shuttle for newly created partner company name
      | power adapter   | key from |
      | Data Shuttle US | new      |
    Then Order data shuttle message should be The resources added includes new key. Please use only existing keys for this partner
    And I search and delete partner account by newly created partner company name

  @TC.16209
  Scenario: 16209 Ordering data shuttle for MozyEnterprise using the Add Link with Unassigned email
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 20    |
    Then Data shuttle order summary should be:
      | Description         | Quantity | Total    |
      | Data Shuttle 1.8 TB | 1        | $275.00  |
      | Total Price         |          | $275.00  |
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @TC.16208
  Scenario: 16208 Ordering data shuttle for MozyEnterprise using the Add Link with assigned email
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | assign to                                |
      | Data Shuttle US | available | 20    | qa1+TC+16208+data+shuttle+order@mozy.com |
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @TC.16207
  Scenario: 16207 Ordering data shuttle for MozyPro using the Add New Key Link with unassigned email
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I order data shuttle for newly created partner company name
      | power adapter   | key from | quota |
      | Data Shuttle US | new      | 20    |
    Then Data shuttle order summary should be:
      | Description         | Quantity | Total    |
      | Data Shuttle 1.8 TB | 1        | $275.00  |
      | Total Price         |          | $275.00  |
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @TC.16205 @slow
  Scenario: 16205 Ordering data shuttle for MozyPro using the Add New Key Link with assigned email
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I order data shuttle for newly created partner company name
      | power adapter   | key from | quota | assign to                                |
      | Data Shuttle US | new      | 20    | qa1+TC+16205+data+shuttle+order@mozy.com |
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @TC.16324 @slow
  Scenario: 16324 Ordering data shuttle with 50% discount
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | assign to | discount |
      | Data Shuttle US | available | 10    | @email    | 50       |
    Then Data shuttle order summary should be:
      | Description         | Quantity | Total    |
      | Data Shuttle 1.8 TB | 1        | $137.50  |
      | Total Price         |          | $137.50  |
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @TC.16323 @slow
  Scenario: 16323 Ordering data shuttle with 100% discount
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | assign to | discount |
      | Data Shuttle US | available | 10    | @email    | 100      |
    Then Data shuttle order summary should be:
      | Description         | Quantity | Total  |
      | Data Shuttle 1.8 TB | 1        | $0.00  |
      | Total Price         |          | $0.00  |
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @TC.16211
  Scenario: 16211 Canceling orders that were created using the Add Link
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 20    |
    Then Data shuttle order should be created
    When I cancel the latest data shuttle order for newly created partner company name
    Then The order should be Cancelled
    And I search and delete partner account by newly created partner company name

  @TC.16212
  Scenario: 16212 Canceling orders that were created using the Add New Key Link
    When I add a new MozyPro partner:
      | period | base plan     |
      | 1      | 50 GB         |
    Then New partner should be created
    When I order data shuttle for newly created partner company name
      | power adapter   | key from | quota |
      | Data Shuttle US | new      | 20    |
    Then Data shuttle order should be created
    When I cancel the latest data shuttle order for newly created partner company name
    Then The order should be Cancelled
    And I search and delete partner account by newly created partner company name

  @TC.17879
  Scenario: 17879 Ordering data shuttle over 1.8T for Reseller using the Add New Key Link
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 2000           |
    Then New partner should be created
    When I order data shuttle for newly created partner company name
      | power adapter   | key from | quota |
      | Data Shuttle US | new      | 2000  |
    Then Data shuttle order should be created
    And Data shuttle order summary should be:
      | Description         | Quantity | Total   |
      | Data Shuttle 3.6 TB | 1        | $375.00 |
      | Total Price         |          | $375.00 |
    Then The number of win drivers should be 2
    And I search and delete partner account by newly created partner company name

  @TC.16320
  Scenario: 16320 Ordering data shuttle over 3.6T for MozyPro using the Add New Key Link
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 4 TB      |
    Then New partner should be created
    When I order data shuttle for newly created partner company name
      | power adapter   | key from | quota |
      | Data Shuttle US | new      | 3800  |
    Then Data shuttle order should be created
    And Data shuttle order summary should be:
      | Description         | Quantity | Total   |
      | Data Shuttle 5.4 TB | 1        | $475.00 |
      | Total Price         |          | $475.00 |
    Then The number of win drivers should be 3
    And I search and delete partner account by newly created partner company name

  @TC.16340
  Scenario: 16340 Manually change number of windows drives ordered
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 2000           |
    Then New partner should be created
    When I order data shuttle for newly created partner company name
      | power adapter   | key from | quota | win drivers |
      | Data Shuttle US | new      | 1000  | 2           |
    Then Data shuttle order should be created
    And The number of win drivers should be 2
    And I search and delete partner account by newly created partner company name

  @TC.16342
  Scenario: 16342 Manually change number of mac drives ordered
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 1 TB      |
    Then New partner should be created
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | win drivers | mac drivers |
      | Data Shuttle US | available | 500   | 0           | 2           |
    Then Data shuttle order should be created
    And The number of mac drivers should be 2
    And I search and delete partner account by newly created partner company name

  @TC.17881
  Scenario: 17881 Verify billing statements when order a data shuttle
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 20    |
    Then Data shuttle order should be created
    When I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date    | Amount  | Total Paid | Balance Due |
      | today  | $275.00  | $275.00    | $0.00       |
      | today  | $95.00   | $95.00     | $0.00       |
      | today  | $0.00    | $0.00      | $0.00       |
    And I search and delete partner account by newly created partner company name