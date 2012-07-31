Feature: View billing information 

  @TC.15254 @smoke_test
  Scenario: Mozy-15254 Verify MozyEnterprise partner master plan section details
    When I log in bus admin console as administrator
    When I add a MozyEnterprise partner with 36 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Billing Information view from bus admin console page
    Then Next renewal info table should be:
    | description   | value                                |
    | Period        | 3-year (change)                      |
    | Date          | +36 month(s)                         |
    | Amount        | $259.00 (Without taxes or discounts) |
    | Payment Type  | Visa ending in @XXXX (change)        |

  @TC.15258
  Scenario: Mozy-15258 Verify Next Renewal text align is set to left justify
    When I log in bus admin console as mozypro test account
    And I navigate to Billing Information view from bus admin console page
    Then Next Renewal text align is set to left justify

  @TC.16658
  Scenario: Mozy-16658 Verify MozyPro partner supplemental plan section details
    When I log in bus admin console as administrator
    When I add a MozyPro partner with 1 month(s) period, 250 GB, $94.99 base plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Billing Information view from bus admin console page
    Then Next renewal supplemental plan details should be:
    | description             | amount   |
    | Total price for 250 GB  | $94.99   |

  @TC.15259
  Scenario: Mozy-15259 Verify MozyEnterprise Autogrow status is set to disabled by default
    When I log in bus admin console as administrator
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Billing Information view from bus admin console page
    Then Autogrow status text's should be Disabled (more info)

  @TC.15260
  Scenario: Mozy-15260 Verify Reseller Autogrow status is set to disabled by default
    When I log in bus admin console as administrator
    When I add a Reseller partner with 1 month(s) period, Silver Reseller, 100 GB base plan, no server plan, 0 add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Billing Information view from bus admin console page
    Then Autogrow status text's should be Disabled (more info)

  @TC.16659
  Scenario: Mozy-16659 Verify MozyEnterprise partner supplemental plan section details
    When I log in bus admin console as administrator
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Billing Information view from bus admin console page
    Then Next renewal supplemental plan details should be:
    | description                         | amount   |
    | Total price for MozyEnterprise User | $95.00   |

  @TC.16660
  Scenario: Mozy-16660 Verify Reseller partner supplemental plan section details
    When I log in bus admin console as administrator
    When I add a Reseller partner with 1 month(s) period, Silver Reseller, 100 GB base plan, no server plan, 0 add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Billing Information view from bus admin console page
    Then Next renewal supplemental plan details should be:
    | description                           | amount  |
    | Number purchased                      | 100     |
    | Price each                            | $0.42   |
    | Total price for GB - Silver Reseller  | $42.00  |

  @TC.17517
  Scenario: Mozy-17517 Verify MozyPro VAT information in the billing information view
    When I log in bus admin console as administrator
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 base plan, no server plan, no coupon, Belgium country, BE0883236072 VAT number, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Billing Information view from bus admin console page
    Then VAT table should be:
    | description       | value        |
    | VAT Number        | BE0883236072 |
    | (change) (delete) |              |