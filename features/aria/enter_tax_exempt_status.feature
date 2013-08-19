 Feature:
  As a Mozy Administrator
  I want provide tax-exempt information to Mozy
  so that I am not charged taxes if they should not apply to my business

  Background:
    Given I log in bus admin console as administrator

  @TC.17526 @firefox @bus @2.0 @enter_tax-exempt_status
  Scenario: 17526 Verify default tax-exemtp status of a new Yearly MozyPro partner
    When I add a new MozyPro partner:
      | period | base plan | server plan | country | vat number   |
      | 1      | 50 GB     | yes         | Belgium | BE0883236072 |
    Then New partner should be created
    When I log in aria admin console as administrator
    Then newly created partner admin email account taxpayer information should be:
      | id           | status                                         |
      | BE0883236072 | State/Province and Federal/National Tax Exempt |

  @TC.17527 @firefox @bus @2.0 @enter_tax-exempt_status
  Scenario: 17527 Verify default tax-exemtp status of a new Biennially MozyEnterprise partner
    When I add a new MozyEnterprise partner:
      | period | users | country | vat number   |
      | 24     | 1     | Belgium | BE0883236072 |
    Then New partner should be created
    When I log in aria admin console as administrator
    Then newly created partner admin email account taxpayer information should be:
      | id           | status                                         |
      | BE0883236072 | State/Province and Federal/National Tax Exempt |

  @TC.17528 @firefox @bus @2.0 @enter_tax-exempt_status
  Scenario: 17528 Verify default tax-exemtp status of a new Monthly Reseller partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | country | vat number    |
      | 1      | Gold          | 100            | yes         | Italy   | IT03018900245 |
    Then New partner should be created
    When I log in aria admin console as administrator
    Then newly created partner admin email account taxpayer information should be:
      | id            | status                                         |
      | IT03018900245 | State/Province and Federal/National Tax Exempt |

  @TC.17533 @firefox  @bus @2.0 @enter_tax-exempt_status
  Scenario: 17533 Set both Exempt from State and Federal taxes to false for a new Biennially Mozypro partner
    When I add a new MozyPro partner:
      | period | base plan | server plan | country | vat number   |
      | 24     | 50 GB     | yes         | Belgium | BE0883236072 |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I set newly created partner admin email account taxpayer information to:
      | exempt state | exempt federal |
      | no           | no             |
    Then newly created partner admin email account taxpayer information should be:
      | id           | status           |
      | BE0883236072 | No tax exemption |

  @TC.17537 @firefox @bus @2.0 @enter_tax-exempt_status
  Scenario: 17537 Set Exempt from State taxes to false for a new 3-years MozyEnterprise partner
    When I add a new MozyEnterprise partner:
      | period | users | country | vat number   |
      | 36     | 1     | Belgium | BE0883236072 |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I set newly created partner admin email account taxpayer information to:
      | exempt state | exempt federal |
      | no           | yes            |
    Then newly created partner admin email account taxpayer information should be:
      | id           | status                      |
      | BE0883236072 | Federal/National Tax Exempt |

  @TC.17539 @firefox  @bus @2.0 @enter_tax-exempt_status
  Scenario: 17539 Set Exempt from Federal taxes to false for a new Yearly Reseller partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | country | vat number    |
      | 1      | Silver        | 100            | Italy   | IT03018900245 |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I set newly created partner admin email account taxpayer information to:
      | exempt state | exempt federal |
      | yes           | no            |
    Then newly created partner admin email account taxpayer information should be:
      | id            | status                    |
      | IT03018900245 | State/Province Tax Exempt |

  @TC.17547 @bus @2.0 @enter_tax-exempt_status
  Scenario: 17547 No taxes charged when create a new Monthly MozyPro partner
    When I add a new MozyPro partner:
      | period | base plan | country | vat number   |
      | 1      | 50 GB     | Belgium | BE0883236072 |
    Then Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 50 GB             | 1        | $19.99     | $19.99      |
      | Pre-tax Subtotal  |          |            | $19.99      |
      | Total Charges     |          |            | $19.99      |
    And New partner should be created

  @TC.17555 @bus @2.0 @enter_tax-exempt_status
  Scenario: 17555 No taxes charged when create a new Yearly MozyEnterprise partner
    When I add a new MozyEnterprise partner:
      | period | users | country | vat number   |
      | 12     | 1     | Belgium | BE0883236072 |
    Then Order summary table should be:
      | Description           | Quantity | Price Each | Total Price |
      | MozyEnterprise User   | 1        | $95.00     | $95.00      |
      | Pre-tax Subtotal      |          |            | $95.00      |
      | Total Charges         |          |            | $95.00      |
    And New partner should be created

  @TC.17556 @bus @2.0 @enter_tax-exempt_status
  Scenario: 17556 No taxes charged when create a new Monthly Reseller partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | country | vat number    |
      | 1      | Platinum      | 100            | Italy   | IT03018900245 |
    Then Order summary table should be:
      | Description            | Quantity | Price Each | Total Price |
      | GB - Platinum Reseller | 100      | $0.30      | $30.00      |
      | Pre-tax Subtotal       |          |            | $30.00      |
      | Total Charges          |          |            | $30.00      |
    And New partner should be created
