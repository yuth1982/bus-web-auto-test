Feature: View billing information 

  @TC.15253
  Scenario: 15253 Verify MozyPro partner master plan section details
    When I add a new MozyPro partner:
    | period | base plan      |
    | 1      | 250 GB, $94.99 |
    Then New partner should created
    When I log in bus admin console as the new partner account
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal info table should be:
    | description   | value                               |
    | Period        | Monthly (change)                    |
    | Date          | +1 month(s)                         |
    | Amount        | $94.99 (Without taxes or discounts) |
    | Payment Type  | Visa ending in @XXXX (change)       |

  @TC.15254 @smoke_test
  Scenario: 15254 Verify MozyEnterprise partner master plan section details
    When I log in bus admin console as administrator
    When I add a new MozyEnterprise partner:
    | period | users |
    | 36     | 1     |
    Then New partner should created
    When I log in bus admin console as the new partner account
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal info table should be:
    | description   | value                                |
    | Period        | 3-year (change)                      |
    | Date          | +36 month(s)                         |
    | Amount        | $259.00 (Without taxes or discounts) |
    | Payment Type  | Visa ending in @XXXX (change)        |

  @TC.15258
  Scenario: 15258 Verify Next Renewal text align is set to left justify
    When I log in bus admin console as mozypro test account
    And I navigate to Billing Information section from bus admin console page
    Then Next Renewal text align is set to left justify

  @TC.16658
  Scenario: 16658 Verify MozyPro partner supplemental plan section details
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
    | period | base plan      |
    | 1      | 250 GB, $94.99 |
    Then New partner should created
    When I log in bus admin console as the new partner account
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal supplemental plan details should be:
    | description             | amount   |
    | Total price for 250 GB  | $94.99   |

  @TC.15259
  Scenario: 15259 Verify MozyEnterprise Autogrow status is set to disabled by default
    When I log in bus admin console as administrator
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 1     |
    Then New partner should created
    When I log in bus admin console as the new partner account
    And I navigate to Billing Information section from bus admin console page
    Then Autogrow status text's should be Disabled (more info)

  @TC.15260
  Scenario: 15260 Verify Reseller Autogrow status is set to disabled by default
    When I log in bus admin console as administrator
    When I add a new Reseller partner:
    | period | reseller type | reseller quota |
    | 1      | Silver        | 100            |
    Then New partner should created
    When I log in bus admin console as the new partner account
    And I navigate to Billing Information section from bus admin console page
    Then Autogrow status text's should be Disabled (more info)

  @TC.16659
  Scenario: 16659 Verify MozyEnterprise partner supplemental plan section details
    When I log in bus admin console as administrator
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 1     |
    Then New partner should created
    When I log in bus admin console as the new partner account
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal supplemental plan details should be:
    | description                         | amount   |
    | Total price for MozyEnterprise User | $95.00   |

  @TC.16660
  Scenario: 16660 Verify Reseller partner supplemental plan section details
    When I log in bus admin console as administrator
    When I add a new Reseller partner:
    | period | reseller type | reseller quota |
    | 1      | Silver        | 100            |
    Then New partner should created
    When I log in bus admin console as the new partner account
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal supplemental plan details should be:
    | description                           | amount  |
    | Number purchased                      | 100     |
    | Price each                            | $0.42   |
    | Total price for GB - Silver Reseller  | $42.00  |

  @TC.17517
  Scenario: 17517 Verify MozyPro VAT information in the billing information view
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan     |
      | 1      | 50 GB, $19.99 |
    Then New partner should created
    When I log in bus admin console as the new partner account
    And I navigate to Billing Information section from bus admin console page
    Then VAT table should be:
    | description       | value        |
    | VAT Number        | BE0883236072 |
    | (change) (delete) |              |