 Feature:
  As a Mozy Administrator
  I want provide tax-exempt information to Mozy
  so that I am not charged taxes if they should not apply to my business

  Background:
    Given I log in bus admin console as administrator

  @TC.17526
  Scenario: Mozy-17526 Verify default tax-exemtp status of a new partner (MozyPro / Yearly)
    When I add a MozyPro partner with 12 month(s) period, 500 GB, $2,089.89 plan, has server plan, no coupon, Belgium country, BE0883236072 VAT number, credit card payment
    Then Partner created successful message should be New partner created
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I navigate to taxpayer information view
    Then Taxpayer id should be BE0883236072
    And Tax exemption status should be Account is exempt from both federal/national and state/province taxation.

  @TC.17527
  Scenario: Mozy-17527 Verify default tax-exemtp status of a new partner (MozyEnterprise / Biennially)
    When I add a MozyEnterprise partner with 24 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, Belgium country, BE0883236072 VAT number, credit card payment
    Then Partner created successful message should be New partner created
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I navigate to taxpayer information view
    Then Taxpayer id should be BE0883236072
    And Tax exemption status should be Account is exempt from both federal/national and state/province taxation.

  @TC.17528
  Scenario: Mozy-17528 Verify default tax-exemtp status of a new partner (Reseller / Monthly)
    When I add a Reseller partner with 1 month(s) period, Gold Reseller, 100 GB plan, has server plan, 1 add-on, no coupon, Italy country, IT03018900245 VAT number, credit card payment
    Then Partner created successful message should be New partner created
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I navigate to taxpayer information view
    Then Taxpayer id should be IT03018900245
    And Tax exemption status should be Account is exempt from both federal/national and state/province taxation.

  @TC.17533
  Scenario: Mozy-17533 Set both Exempt from State and Federal taxes to false in Aria (Mozypro / Biennially)
    When I add a MozyPro partner with 24 month(s) period, 50 GB, $419.79 plan, has server plan, no coupon, Belgium country, BE0883236072 VAT number, credit card payment
    Then Partner created successful message should be New partner created
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I navigate to taxpayer information view
    Then Taxpayer id should be BE0883236072
    When I set Exempt from Federal and National taxes to false
    And I set Exempt from State and Province taxes to false
    Then Tax exemption status should be Account is not exempt from taxation.

  @TC.17537
  Scenario: Mozy-17537 Set Exempt from State/Province taxes to false in Aria (MozyEnterprise / 3-years)
    When I add a MozyEnterprise partner with 36 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, Belgium country, BE0883236072 VAT number, credit card payment
    Then Partner created successful message should be New partner created
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I navigate to taxpayer information view
    Then Taxpayer id should be BE0883236072
    When I set Exempt from State and Province taxes to false
    Then Tax exemption status should be Account is exempt from federal/national taxation.

  @TC.17539
  Scenario: Mozy-17539 Set Exempt from Federal/National taxes to false in Aria (Reseller / Yearly)
    When I add a Reseller partner with 1 month(s) period, Silver Reseller, 100 GB plan, no server plan, 0 add-on, no coupon, Italy country, IT03018900245 VAT number, credit card payment
    Then Partner created successful message should be New partner created
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I navigate to taxpayer information view
    Then Taxpayer id should be IT03018900245
    When I set Exempt from Federal and National taxes to false
    Then Tax exemption status should be Account is exempt from state/province taxation.

   @TC.17547
   Scenario: Mozy-17547 No taxes charged when create a new Monthly MozyPro partner

    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 plan, no server plan, no coupon, Belgium country, BE0883236072 VAT number, credit card payment
    Then Order summary details should be:
    | Description       | Amount   | Price Each | Total Price |
    | 50 GB             | 1        | $19.99     | $19.99      |
    | Pre-tax Subtotal  |          |            | $19.99      |
    | Total Charges     |          |            | $19.99      |
    Then Partner created successful message should be New partner created

  @TC.17555
  Scenario: Mozy-17555 No taxes charged when create a new Yearly MozyEnterprise partner
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, Belgium country, BE0883236072 VAT number, credit card payment
    Then Order summary details should be:
    | Description           | Amount   | Price Each | Total Price |
    | MozyEnterprise User   | 1        | $95.00     | $95.00      |
    | Pre-tax Subtotal      |          |            | $95.00      |
    | Total Charges         |          |            | $95.00      |
    Then Partner created successful message should be New partner created

  @TC.17556
  Scenario: Mozy-17556 No taxes charged when create a new Monthly Reseller partner
    When I add a Reseller partner with 1 month(s) period, Platinum Reseller, 100 GB plan, no server plan, 0 add-on, no coupon, Italy country, IT03018900245 VAT number, credit card payment
    Then Order summary details should be:
    | Description            | Amount   | Price Each | Total Price |
    | GB - Platinum Reseller | 100      | $0.30      | $30.00      |
    | Pre-tax Subtotal       |          |            | $30.00      |
    | Total Charges          |          |            | $30.00      |
    And Partner created successful message should be New partner created

  #@TC.17556
  #Scenario: No taxes charged when creating a new partner (Reseller / Monthly)
  #  When I add a MozyPro partner with 1 month(s) period, 250 GB, $94.99 plan, no server plan, no coupon, credit card payment
  # Then Partner created successful message should be New partner created
  #  When I act as the new partner on admin details panel
  # And I change subscription up to MozyPro with 250 GB of space to distribute however you want amongst unlimited desktop computers - billed annually
  #  Then Subscription changed message should be Your account has been changed to yearly billing.