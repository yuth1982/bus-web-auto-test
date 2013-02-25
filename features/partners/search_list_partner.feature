Feature: Search and list partner

  Background:
    Given I log in bus admin console as administrator

  # This test cases requires an OEM partner with API Key
  # Test account Barclays Root - Reserved is in QA6 only
  #
  @TC.643 @need_test_account
  Scenario: 643 Verify White List visibility for an OEM partner with an API Key
    When I search partner by:
      | name                     | filter |
      | Barclays Root - Reserved | OEMs   |
    Then I view partner details by Barclays Root - Reserved
    And Partner ip whitelist should be 250.250.250.250

  @TC.644
  Scenario: 644 Verify White List visibility for a Corp partner with an API Key
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 10 GB     |
    Then New partner should be created
    And I Create an API key for current partner
    When I add a new ip whitelist 250.250.250.250
    Then Partner ip whitelist should be 250.250.250.250
    And I delete partner account

  # This test cases requires an OEM partner without API Key
  # Test account Charter Business Trial - Reserved is in QA6 only
  #
  @TC.645 @need_test_account
  Scenario: 645 Verify White List visibility for an OEM partner without an API Key
    When I search partner by:
      | name                              | filter |
      | Charter Business Trial - Reserved | OEMs   |
    Then I view partner details by Charter Business Trial - Reserved
    And Partner API key should be empty
    And Partner ip whitelist should be There is no current API key.

  @TC.646
  Scenario: 646 Verify White List visibility for a Corp partner without an API Key
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 10 GB     |
    Then New partner should be created
    And Partner API key should be empty
    And Partner ip whitelist should be There is no current API key.

  @TC.789
  Scenario: 789 Search partner by company name
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 10 GB     |
    And New partner should be created
    When I search partner by newly created partner company name
    Then Partner search results should be:
      | Partner       | Created |
      | @company_name | today   |
    And I search and delete partner account by newly created partner company name

  # This test cases requires an OEM partner
  # Test account Charter Business Trial - Reserved is in QA6 only
  #
  @TC.790 @need_test_account
  Scenario: 790 Do a search for all partners
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 10 GB     |
    And New partner should be created
    When I search partner by:
      | name                              |
      | Charter Business Trial - Reserved |
    Then Partner search results should be:
      | Partner                           | Type |
      | Charter Business Trial - Reserved | oem  |
    When I search partner by:
      | name |
      |      |
    Then Partner search results should be:
      | Partner       | Created |
      | @company_name | today   |
    And I search and delete partner account by newly created partner company name

  @TC.791
  Scenario: 791 Do a regular expression search for a partner
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 10 GB     |
    And New partner should be created
    And I add a new partner external id
    And Partner general information should be:
      | External ID:          |
      | @external_id (change) |
    When I search partner by newly created partner external id
    Then Partner search results should be:
      | External ID  | Partner       | Type    |
      | @external_id | @company_name | MozyPro |
    When I search partner by newly created partner admin email
    Then Partner search results should be:
      | External ID  | Partner       | Root Admin  |
      | @external_id | @company_name | @admin_email |
    And I search and delete partner account by newly created partner company name

  @TC.792
  Scenario: 792 Do a search on all deleted partners
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 10 GB     |
    Then New partner should be created
    And I delete partner account
    When I search partner by:
      | name          | filter  |
      | @company_name | Deleted |
    Then Partner search results should be:
      | Partner       | Created |
      | @company_name | today   |

  @TC.795
  Scenario: 795 Search for partners with the business type
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 10 GB     |
    Then New partner should be created
    When I search partner by:
      | name          | filter     |
      | @company_name | Businesses |
    Then Partner search results should be:
      | Partner       | Created | Type    |
      | @company_name | today   | MozyPro |
    And I search and delete partner account by newly created partner company name

  # This test cases requires an incompleted partner
  # Test account Quigley-Effertz - Reserved is in QA6 only
  #
  @TC.794 @need_test_account
  Scenario: 794 Search incomplete all partners
    When I search partner by:
      | name                       | filter |
      | Quigley-Effertz - Reserved | Incomplete (all)   |
    Then Partner search results should be:
      | Partner                    | Type |
      | Quigley-Effertz - Reserved | MozyPro Itemized  |

  @TC.796
  Scenario: 796 Search for partners with the reseller type
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota |
      | 1       | Platinum      | 500            |
    And New partner should be created
    When I search partner by:
      | name          | filter   |
      | @company_name | Reseller |
    Then Partner search results should be:
      | Partner       | Created | Type     |
      | @company_name | today   | Reseller |
    And I search and delete partner account by newly created partner company name

  # This test cases requires an OEM partner
  # Test account Charter Business Trial - Reserved is in QA6 only
  #
  @TC.797 @need_test_account
  Scenario: 797 Search for partners with the OEMs type
    When I search partner by:
      | name                              | filter |
      | Charter Business Trial - Reserved | OEMs   |
    Then Partner search results should be:
      | Partner                           | Type |
      | Charter Business Trial - Reserved | oem  |

  # This test cases requires any existing partner
  # Test account Charter Business Trial - Reserved is in QA6 only
  #
  @TC.799 @need_test_account
  Scenario: 799 Uncheck the Inlcude sub-partners
    When I search partner by:
      | name                              | including sub-partners |
      | Charter Business Trial - Reserved | no                     |
    Then Partner search results should be empty

  # This test cases requires any existing partner
  # Test account Charter Business Trial - Reserved is in QA6 only
  #
  @TC.800 @need_test_account
  Scenario: 800 Clear the search results for a partner
    When I search partner by:
      | name                              | filter |
      | Charter Business Trial - Reserved | OEMs   |
    Then Partner search results should be:
      | Partner                           | Type |
      | Charter Business Trial - Reserved | oem  |
    When I clear partner search results
    Then Partner search results should not be:
      | Partner                           | Type |
      | Charter Business Trial - Reserved | oem  |

  @TC.1051
  Scenario: 1051 Verify Partner Details Links - Strings
    When I add a new MozyPro partner:
      | period | base plan | country       | address           | city      | state abbrev | zip   | phone          |
      | 1      | 10 GB     | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be $9.99
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | $9.99      | $9.99       |
      | Pre-tax Subtotal  |          |            | $9.99       |
      | Total Charges     |          |            | $9.99       |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent: | Next Charge:   | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Stash: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro | after 1 month  | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No            |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:   |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | @new_admin_email |
    And Partner account attributes should be:
      | Backup Licenses         | 200       |
      | Backup License Soft Cap | Enabled   |
      | Server Enabled          | Disabled  |
      | Cloud Storage (GB)      | 10        |
      | Stash Users:            |           |
      | Default Stash Storage:  |           |
    And Partner resources should be:
      |                     | Used      | Allocated | Limit |
      | Backup Licenses     | 0         | 10        | 200   |
      | Cloud Storage (GB)  | 0         | 10        | 10    |
      | Server Enabled      | Disabled  |           |       |
    And Partner internal billing should be:
      | Account Type:   | Credit Card   | Current Period: | Monthly             |
      | Unpaid Balance: | $0.00         | Collect On:     | N/A                 |
      | Renewal Date:   | after 1 month | Renewal Period: | Use Current Period  |
    And Partner billing history should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | $9.99   | $9.99      | $0.00       |
      | today | $0.00   | $0.00      | $0.00       |
    And I delete partner account