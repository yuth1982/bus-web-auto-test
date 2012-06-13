 Feature:
  As a Mozy Administrator
  I want provide tax-exempt information to Mozy
  so that I am not charged taxes if they should not apply to my business

  @TC.15328
  Scenario: BILL.101000 Verify default tax-exempt status of a new partner created in BUS
    Given I log in bus admin console as administrator
    And I add a MozyPro partner with 10 GB (10293349) plan, 24 month(s) period, has server add-on, Italy country, IT03018900245 VAT number
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I navigate to taxpayer information view
    Then Taxpayer id should be IT03018900245
    And Tax exemption status should be Account is exempt from both federal/national and state/province taxation.

  @TC.15381
  Scenario: BILL.101000 Set Exempt from Federal/National taxes to false in Aria
    Given I log in bus admin console as administrator
    And I add a MozyPro partner with 100 GB (10293353) plan, 24 month(s) period, no server add-on, Belgium country, BE0883236072 VAT number
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I navigate to taxpayer information view
    And I set Exempt from Federal and National taxes to false
    And Tax exemption status should be Account is exempt from state/province taxation.

  @TC.15380
  Scenario: BILL.101000 Set Exempt from State/Province taxes to false in Aria
    Given I log in bus admin console as administrator
    And I add a MozyPro partner with 250 GB (10293355) plan, 24 month(s) period, has server add-on, Belgium country, BE0883236072 VAT number
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I navigate to taxpayer information view
    And I set Exempt from State and Province taxes to false
    And Tax exemption status should be Account is exempt from federal/national taxation.

  @TC.15277
  Scenario: BILL.101000 Set both Exempt from State and Federal taxes to false in Ara
    Given I log in bus admin console as administrator
    And I add a MozyPro partner with 500 GB (10293357) plan, 24 month(s) period, no server add-on, Belgium country, BE0883236072 VAT number
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I navigate to taxpayer information view
    And I set Exempt from Federal and National taxes to false
    And I set Exempt from State and Province taxes to false
    And Tax exemption status should be Account is not exempt from taxation.

  @TC.15835
  Scenario: BILL.101003 No taxes charged when purchasing new resource in bus
    Given I log in bus admin console as Schamberger-Cole admin
    And I add a MozyPro partner with 1 TB (10293359) plan, 24 month(s) period, has server add-on, Italy country, IT03018900245 VAT number
    And I view price details of my purchased resource 1 server licence, 10G server quota, 1 desktop licence, 10G desktop quota
    Then I should see tax total price is $0.00

  @TC.15456
  Scenario: BILL.101003 No taxes charged when creating new partner in bus
    Given I log in bus admin console as administrator
    And I add a MozyPro partner with 2 TB (10293361) plan, 24 month(s) period, no server add-on, Belgium country, BE0883236072 VAT number
    And I view the new partner order summary when adding partner
    Then I should see taxes total price of initial order is $0.00

    #    | 4 TB (10293363)     | 24     | no      |
