Feature: View billing information 

  Background:
    Given I log in bus admin console as administrator

  @TC.15253
  Scenario: 15253 Verify MozyPro partner master plan section details
    When I add a new MozyPro partner:
    | period | base plan |
    | 24     | 250 GB    |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal info table should be:
    | description   | value                                   |
    | Period        | Biennial (change)                     |
    | Date          | +24 month(s)                            |
    | Amount        | $1,994.79 (Without taxes or discounts)  |
    | Payment Type  | Visa ending in @XXXX (change)           |

  @TC.17976
  Scenario: 17976 Verify Reseller partner master plan section details
    When I add a new Reseller partner:
    | period | reseller type | reseller quota |
    | 12     | Silver        | 100            |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal info table should be:
    | description   | value                                |
    | Period        | Yearly (change)                      |
    | Date          | +12 month(s)                         |
    | Amount        | $462.00 (Without taxes or discounts) |
    | Payment Type  | Visa ending in @XXXX (change)        |

  @TC.15254 @smoke_test
  Scenario: 15254 Verify MozyEnterprise partner master plan section details
    When I add a new MozyEnterprise partner:
    | period | users |
    | 36     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal info table should be:
    | description   | value                                |
    | Period        | 3-year (change)                      |
    | Date          | +36 month(s)                         |
    | Amount        | $259.00 (Without taxes or discounts) |
    | Payment Type  | Visa ending in @XXXX (change)        |

  @TC.16658
  Scenario: 16658 Verify MozyPro partner supplemental plan section details
    When I add a new MozyPro partner:
    | period | base plan |
    | 1      | 250 GB    |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal supplemental plan details should be:
    | description             | amount   |
    | Total price for 250 GB  | $94.99   |

  @TC.15359
  Scenario: 15359 Verify MozyEnterprise Autogrow status is set to disabled by default
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then Autogrow status text's should be Disabled (more info)

  @TC.15360
  Scenario: 15360 Verify Reseller Autogrow status is set to disabled by default
    When I add a new Reseller partner:
    | period | reseller type | reseller quota |
    | 1      | Silver        | 100            |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then Autogrow status text's should be Disabled (more info)

  @TC.16659
  Scenario: 16659 Verify MozyEnterprise partner supplemental plan section details
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal supplemental plan details should be:
    | description                         | amount   |
    | Total price for MozyEnterprise User | $95.00   |

  @TC.16660
  Scenario: 16660 Verify Reseller partner supplemental plan section details
    When I add a new Reseller partner:
    | period | reseller type | reseller quota |
    | 1      | Silver        | 100            |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal supplemental plan details should be:
    | description                           | amount  |
    | Number purchased                      | 100     |
    | Price each                            | $0.42   |
    | Total price for GB - Silver Reseller  | $42.00  |

  @TC.17517
  Scenario: 17517 Verify MozyPro VAT information in the billing information view
    When I add a new MozyPro partner:
    | period | base plan | server plan | country | vat number    |
    | 12     | 500 GB    | yes         | Italy   | IT03018900245 |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then VAT table should be:
    | description       | value         |
    | VAT Number        | IT03018900245 |
    | (change) (delete) |               |