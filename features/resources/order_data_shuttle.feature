Feature:
  Order data shuttle

  Background:
    Given I log in bus admin console as administrator

  @TC.12355
  Scenario: 12355 Add a new partner and verify it appears in the module
    When I add a new MozyPro partner:
      | period | base plan | address           | city      | state abbrev | zip   | phone          |
      | 1      | 50 GB     | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then New partner should be created
    When I navigate to Order Data Shuttle section from bus admin console page
    Then Partners search results in order data shuttle section should be:
      | Partner        | Root Admin    | Type    |
      | @partner_name  | @admin_email  | MozyPro |
    Then I search and delete partner account by newly created partner company name

  @TC.12659
  Scenario: 12659 Delete a partner and verify the module updates correctly
    When I add a new MozyPro partner:
      | period | base plan | address           | city      | state abbrev | zip   | phone          |
      | 1      | 50 GB     | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then New partner should be created
    And I delete partner account
    When I navigate to Order Data Shuttle section from bus admin console page
    And I search partner in order data shuttle section by newly created partner company name
    Then Partner search results in order data shuttle section should be empty

  @TC.12354
  Scenario: 12354 Verify Module - General UI Controls
    When I navigate to Order Data Shuttle section from bus admin console page
    And I search partner in order data shuttle section by this is a really long text this is a really long text this is a really long text
    Then Partner search results in order data shuttle section should be empty
    When I clear partner search results in order data shuttle section
    And I search partner in order data shuttle section by $%^**
    Then Partner search results in order data shuttle section should be empty
    When I collapse order data shuttle section
    And Partner search results in order data shuttle section should be invisible

  @TC.12662
  Scenario: 12662 Verify Partners Appear - Search
    When I add a new MozyPro partner:
      | period | base plan | address           | city      | state abbrev | zip   | phone          |
      | 1      | 50 GB     | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then New partner should be created
    When I navigate to Order Data Shuttle section from bus admin console page
    And I search partner in order data shuttle section by newly created partner company name
    Then Partners search results in order data shuttle section should be:
      | Partner        | Root Admin    | Type    |
      | @partner_name  | @admin_email  | MozyPro |
    Then I search and delete partner account by newly created partner company name

  @TC.12661
  Scenario: 12661 Verify EMEA Pro Partners Appear - Search
    When I add a new MozyPro partner:
      | period | base plan | create under    | country  |
      | 1      | 250 GB    | MozyPro Ireland | Ireland  |
    Then New partner should be created
    When I navigate to Order Data Shuttle section from bus admin console page
    And I search partner in order data shuttle section by newly created partner company name
    Then Partners search results in order data shuttle section should be:
      | Partner        | Root Admin    | Type    |
      | @partner_name  | @admin_email  | MozyPro |
    Then I search and delete partner account by newly created partner company name

  @TC.12942
  Scenario: 12942 Suspended partner order data shuttle
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 250 GB    |
    Then New partner should be created
    And I suspend the partner
    When I navigate to Order Data Shuttle section from bus admin console page
    And I search partner in order data shuttle section by newly created partner company name
    Then Partner search results in order data shuttle section should be empty
    Then I search and delete partner account by newly created partner company name

  @TC.12368
  Scenario: 12368 Verify Shipping Address Section - Populated Fields Correctly
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

  @TC.12370
  Scenario: 12370 Verify shipping address - field validate
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I order data shuttle for newly created partner company name
      | name | address 1 | city | state | phone | zip |
      |      |           |      |       |       |     |
    Then Order data shuttle message should include Please specify a name
    And Order data shuttle message should include Please specify an address
    And Order data shuttle message should include Please specify a city
    And Order data shuttle message should include Please specify a state
    And Order data shuttle message should include Please specify a phone number
    And Order data shuttle message should include Please specify a zip
    And Order data shuttle message should include Please select the power adapter type.
    And I search and delete partner account by newly created partner company name

  @TC.12184
  Scenario: 12184 Verify Data Shuttle Device Status report
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle device status summary table header should be:
      | Ordered | Not Started | Seeding | Seed Complete | Seed Error | Loading  | Load Complete | Load Error | Cancelled |

  @TC.12197
  Scenario: 12197 Verify clicking Seeding
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle device seeding status table header should be:
      |Order # | Partner | Created | Key | Machine | Data Shuttle Device ID | Phase | Status | % Complete | GB Transferred | Seed Size | Start | Elapsed |

  @TC.12198
  Scenario: 12198 Verify clicking Seed Complete
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle device seed complete status table header should be:
      |Order # | Partner | Created | Key | Machine | Data Shuttle Device ID | Phase | Status | % Complete | GB Transferred | Seed Size | Start | Elapsed |

  @TC.12199
  Scenario: 12199 Verify clicking Seed Error
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle device seed error status table header should be:
      |Order # | Partner | Created | Key | Machine | Data Shuttle Device ID | Phase | Status | % Complete | GB Transferred | Seed Size | Start | Elapsed |

  @TC.12200
  Scenario: 12200 Verify clicking Loading
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle device loading status table header should be:
      |Order # | Partner | Created | Key | Machine | Data Shuttle Device ID | Phase | Status | % Complete | GB Transferred | Seed Size | Start | Elapsed |

  @TC.12201
  Scenario: 12201 Verify clicking Load Complete
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle device load complete status table header should be:
      |Order # | Partner | Created | Key | Machine | Data Shuttle Device ID | Phase | Status | % Complete | GB Transferred | Seed Size | Start | Elapsed |

  @TC.12203
  Scenario: 12203 Verify clicking Load Error
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle device load error status table header should be:
      |Order # | Partner | Created | Key | Machine | Data Shuttle Device ID | Phase | Status | % Complete | GB Transferred | Seed Size | Start | Elapsed |

  @TC.12202
  Scenario: 12202 Verify clicking Cancelled
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle device cancelled status table header should be:
      | Order # | Partner | Created | Key | Machine | Data Shuttle Device ID | Phase | Status | % Complete | GB Transferred | Seed Size | Start | Elapsed | Cancelled |

  @TC.12185
  Scenario: 12185 Verify Data Shuttle Stuck report
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle device stuck summary table header should be:
      | > 7 days | > 14 days | > 30 days |

  @TC.12204
  Scenario: 12204 Verify Data Shuttle Stuck > 7 days
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle device stuck over 7 days table header should be:
      | Order # | Partner | Created | Key | Machine | Data Shuttle Device ID | Phase | Status | % Complete | GB Transferred | Seed Size | Start | Elapsed |

  @TC.12922
  Scenario: 12922 Verify Data Shuttle Stuck > 14 days
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle device stuck over 14 days table header should be:
      | Order # | Partner | Created | Key | Machine | Data Shuttle Device ID | Phase | Status | % Complete | GB Transferred | Seed Size | Start | Elapsed |

  @TC.12923
  Scenario: 12923 Verify Data Shuttle Stuck > 30 days
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle device stuck over 30 days table header should be:
      | Order # | Partner | Created | Key | Machine | Data Shuttle Device ID | Phase | Status | % Complete | GB Transferred | Seed Size | Start | Elapsed |

  @TC.12186
  Scenario: 12186 Verify Data Inventory Status report
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle inventory status summary table header should be:
      | Drives @ 3PL Site | Active Drives | Drives at 80% Life | Dead Drives (100%+) |

  @TC.12216
  Scenario: 12216 Verify the Active Drives #
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle inventory active drivers status table header should be:
      | Drive SN | % Life Used | Current Location | Order | Phase |

  @TC.12295
  Scenario: 12295 Verify the # of drives at 80%
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle inventory drivers at 80% life status table header should be:
      | Drive SN | % Life Used | Current Location | Order | Phase |

  @TC.12296
  Scenario: 12296 Verify the Dead Drives #
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle inventory dead drivers status table header should be:
      | Drive SN | % Life Used | Current Location | Order | Phase |

  @TC.16183
  Scenario: 16183 Verify ordering data shuttle exceed partner available resources
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 2     |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 10          | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    And I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 5000  |
    Then order data shuttle message should be:
    """
    The resources added in this Data Shuttle order exceed those available for machine 'AUTOTEST'. Please visit the Edit Machine page to add more resources.
    """
    And I search and delete partner account by newly created partner company name

  @TC.16325
  Scenario: 16325 Ordering data shuttle with 110% Discount
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 10          | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | discount |
      | Data Shuttle US | available | 110      |
    Then order data shuttle message should be:
    """
    Discount >100% are not allowed. Please correct the value in the red box
    """
    And I search and delete partner account by newly created partner company name

  @TC.16205 @slow
  Scenario: 16205 Ordering data shuttle for MozyPro
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | storage_type | storage_limit | devices |
      | Desktop      | 30          | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 20    |
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @TC.16324 @slow
  Scenario: 16324 Ordering data shuttle with 50% discount
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 2     |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 10          | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | discount |
      | Data Shuttle US | available | 10    | 50       |
    Then Data shuttle order summary should be:
      | Description         | Quantity | Total    |
      | Data Shuttle 1.8 TB | 1        | $275.00  |
      | Total Price         |          | $137.50  |
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @TC.16323 @slow
  Scenario: 16323 Ordering data shuttle with 100% discount
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 2     |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 10          | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | discount |
      | Data Shuttle US | available | 10    | 100      |
    Then Data shuttle order summary should be:
      | Description         | Quantity | Total   |
      | Data Shuttle 1.8 TB | 1        | $275.00 |
      | Total Price         |          | $0.00   |
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @TC.16211
  Scenario: 16211 Canceling orders that were created using the Add Link
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 2     |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 20          | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 20    |
    Then Data shuttle order should be created
    When I cancel the latest data shuttle order for newly created partner company name
    Then The order should be Cancelled
    And I search and delete partner account by newly created partner company name

  @TC.17879
  Scenario: 17879 Ordering data shuttle over 1.8T for Reseller
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 2000           |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 2000        | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 2000  |
    And Data shuttle order summary should be:
      | Description         | Quantity | Total   |
      | Data Shuttle 3.6 TB | 1        | $375.00 |
      | Total Price         |          | $375.00 |
    Then The number of win drivers should be 2
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @TC.16320
  Scenario: 16320 Ordering data shuttle over 3.6T for MozyPro
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 4 TB      |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | storage_type | storage_limit | devices |
      | Desktop      | 3800        | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 3800  |
    And Data shuttle order summary should be:
      | Description         | Quantity | Total   |
      | Data Shuttle 5.4 TB | 1        | $475.00 |
      | Total Price         |          | $475.00 |
    Then The number of win drivers should be 3
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @TC.16340
  Scenario: 16340 Manually change number of windows drives ordered
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 2000           |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 1000        | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | win drivers |
      | Data Shuttle US | available | 1000  | 2           |
    And The number of win drivers should be 2
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @TC.16342
  Scenario: 16342 Manually change number of mac drives ordered
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 1 TB      |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | storage_type | storage_limit | devices |
      | Desktop      | 500         | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | win drivers | mac drivers |
      | Data Shuttle US | available | 500   | 0           | 2           |
    And The number of mac drivers should be 2
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @TC.17881
  Scenario: 17881 Verify billing statements when order a data shuttle
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 2     |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 20            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
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
      | today  | $190.00  | $190.00     | $0.00       |
      | today  | $0.00    | $0.00      | $0.00       |
    And I search and delete partner account by newly created partner company name