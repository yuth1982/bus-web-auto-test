 Feature:
  As a Mozy Administrator
  I want provide tax-exempt information to Mozy
  so that I am not charged taxes if they should not apply to my business

  Background:
    Given I log in bus admin console as administrator

  @TC.17526
  Scenario: 17526 Verify default tax-exemtp status of a new Yearly MozyPro partner
    When I add a new MozyPro partner:
    | period | base plan     | server plan | country | vat number   |
    | 1      | 50 GB, $19.99 | yes         | Belgium | BE0883236072 |
    Then New partner should be created
    When I log in aria admin console as aria admin
    Then the new partner account taxpayer information should be:
    | id           | status                                                                   |
    | BE0883236072 | Account is exempt from both federal/national and state/province taxation.|

  @TC.17527
  Scenario: 17527 Verify default tax-exemtp status of a new Biennially MozyEnterprise partner
    When I add a new MozyEnterprise partner:
    | period | users | country | vat number   |
    | 24     | 1     | Belgium | BE0883236072 |
    Then New partner should be created
    When I log in aria admin console as aria admin
    Then the new partner account taxpayer information should be:
    | id           | status                                                                   |
    | BE0883236072 | Account is exempt from both federal/national and state/province taxation.|

  @TC.17528
  Scenario: 17528 Verify default tax-exemtp status of a new Monthly Reseller partner
    When I add a new Reseller partner:
    | period | reseller type | reseller quota | server plan | country | vat number    |
    | 1      | Gold          | 100            | yes         | Italy   | IT03018900245 |
    Then New partner should be created
    When I log in aria admin console as aria admin
    Then the new partner account taxpayer information should be:
    | id            | status                                                                   |
    | IT03018900245 | Account is exempt from both federal/national and state/province taxation.|

  @TC.17533
  Scenario: 17533 Set both Exempt from State and Federal taxes to false for a new Biennially Mozypro partner
    When I add a new MozyPro partner:
    | period | base plan      | server plan | country | vat number   |
    | 24     | 50 GB, $419.79 | yes         | Belgium | BE0883236072 |
    Then New partner should be created
    When I log in aria admin console as aria admin
    When I set the new partner account taxpayer information to:
    | exempt state | exempt federal |
    | no           | no             |
    Then the new partner account taxpayer information should be:
    | id           | status                              |
    | BE0883236072 | Account is not exempt from taxation.|

  @TC.17537
  Scenario: 17537 Set Exempt from State taxes to false for a new 3-years MozyEnterprise partner
    When I add a new MozyEnterprise partner:
    | period | users | country | vat number   |
    | 36     | 1     | Belgium | BE0883236072 |
    Then New partner should be created
    When I log in aria admin console as aria admin
    When I set the new partner account taxpayer information to:
    | exempt state | exempt federal |
    | no           | yes            |
    Then the new partner account taxpayer information should be:
    | id           | status                                            |
    | BE0883236072 | Account is exempt from federal/national taxation. |

  @TC.17539
  Scenario: 17539 Set Exempt from Federal taxes to false for a new Yearly Reseller partner
    When I add a new Reseller partner:
    | period | reseller type | reseller quota | country | vat number    |
    | 1      | Silver        | 100            | Italy   | IT03018900245 |
    Then New partner should be created
    When I log in aria admin console as aria admin
    When I set the new partner account taxpayer information to:
    | exempt state | exempt federal |
    | yes           | no            |
    Then the new partner account taxpayer information should be:
    | id            | status                                          |
    | IT03018900245 | Account is exempt from state/province taxation. |

  @TC.17547
  Scenario: 17547 No taxes charged when create a new Monthly MozyPro partner
    When I add a new MozyPro partner:
    | period | base plan     | country | vat number   |
    | 1      | 50 GB, $19.99 | Belgium | BE0883236072 |
    Then Order summary table should be:
    | Description       | Quantity | Price Each | Total Price |
    | 50 GB             | 1        | $19.99     | $19.99      |
    | Pre-tax Subtotal  |          |            | $19.99      |
    | Total Charges     |          |            | $19.99      |
    Then New partner should be created

  @TC.17555
  Scenario: 17555 No taxes charged when create a new Yearly MozyEnterprise partner
    When I add a new MozyEnterprise partner:
    | period | users | country | vat number   |
    | 12     | 1     | Belgium | BE0883236072 |
    Then Order summary table should be:
    | Description           | Quantity | Price Each | Total Price |
    | MozyEnterprise User   | 1        | $95.00     | $95.00      |
    | Pre-tax Subtotal      |          |            | $95.00      |
    | Total Charges         |          |            | $95.00      |
    Then New partner should be created

  @TC.17556
  Scenario: 17556 No taxes charged when create a new Monthly Reseller partner
    When I add a new Reseller partner:
    | period | reseller type | reseller quota | country | vat number    |
    | 1      | Platinum      | 100            | Italy   | IT03018900245 |
    Then Order summary table should be:
    | Description            | Quantity | Price Each | Total Price |
    | GB - Platinum Reseller | 100      | $0.30      | $30.00      |
    | Pre-tax Subtotal       |          |            | $30.00      |
    | Total Charges          |          |            | $30.00      |
    Then New partner should be created
