Feature: Chane subscription period

  As a Mozy Administrator
  I want to change my subscription period longer
  so that I can save money on my Mozy subscription and be billed less frequently.

  @TC.15231
  Scenario: BILL.8004.8502 Move upstream with subscription period (MozyPro / Monthly -> Yearly)
    Given I log in bus admin console as administrator
    When I add a MozyPro partner with 1 month(s) period, 250 GB, $94.99 plan, no server plan
    Then Partner created message should be New partner created.
    When I masquerade as the new partner
    And I switch subscription to MozyPro with 250 GB of space to distribute however you want amongst unlimited desktop computers - billed annually
    Then Subscription changed message should be Your account has been changed to yearly billing.

  @TC.15232
  Scenario: BILL.8004.8502 Move upstream with subscription period (MozyPro / Yearly -> Biennially)
    Given I log in bus admin console as administrator
    When I add a MozyPro partner with 500 GB (10293325) plan, 12 month(s) period, no server add-on
    Then Partner created message should be New partner created.
    When I masquerade as the new partner
    And I switch subscription to A bienially billed plan with 500 GB quota and unlimited desktop licenses
    Then Subscription changed message should be Your account has been changed to biennial billing.

  @TC.15234
  Scenario: BILL.8005 Move downstream with subscription period (MozyPro / biennially -> yearly)
    Given I log in bus admin console as administrator
    When I add a MozyPro partner with 1 TB (10293359) plan, 24 month(s) period, has server add-on
    Then Partner created message should be New partner created.
    When I masquerade as the new partner
    And I switch subscription to An annually billed plan with 1 TB quota and unlimited desktop licenses
    Then Subscription changed message should be Your account has been changed to yearly billing.

  @TC.15235
  Scenario: BILL.8005 Move downstream with subscription period (MozyPro / yearly -> monthly)
    Given I log in bus admin console as administrator
    When I add a MozyPro partner with 2 TB (10293329) plan, 12 month(s) period, has server add-on
    Then Partner created message should be New partner created.
    When I masquerade as the new partner
    And I switch subscription to A monthly billed plan with 2 TB quota and unlimited desktop licenses
    Then Subscription changed message should be Your account has been changed to monthly billing.

  @TC.15236
  Scenario: BILL.8005 Move downstream with subscription period (MozyPro / biennially -> monthly)
    Given I log in bus admin console as administrator
    When I add a MozyPro partner with 4 TB (10293363) plan, 24 month(s) period, no server add-on
    Then Partner created message should be New partner created.
    When I masquerade as the new partner
    And I switch subscription to A monthly billed plan with 4 TB quota and unlimited desktop licenses
    Then Subscription changed message should be Your account has been changed to monthly billing.

  @TC.15243
  Scenario: BILL.5752.5754 Verify subscription period can be changed (mozypro / monthly)
    Given I log in bus admin console as MozyPro 10 GB Plan (Monthly) test partner
    When I navigate to billing information view
    Then Partner can change their subscription period

  @TC.15244
  Scenario: BILL.5752.5754 Verify subscription period can be changed (mozypro / yearly)
    Given I log in bus admin console as MozyPro 50 GB Plan (Yearly) test partner
    When I navigate to billing information view
    Then Partner can change their subscription period

  @TC.15245
  Scenario: BILL.5752.5754 Verify subscription period can be changed (mozypro / biennially)
    Given I log in bus admin console as MozyPro 100 GB Plan (Biennially) test partner
    When I navigate to billing information view
    Then Partner can change their subscription period

  @TC.15253
  Scenario: BILL.8511 Verify the price listed as the "Next Renewal > Amount"
    Given I log in bus admin console as MozyPro 250 GB Plan (Yearly) test partner
    When I navigate to billing information view
    Then Next renewal amount should be:
    | Period          | Date          | Amount | Credit Card          |
    | Yearly (change) | Apr 25, 2013  | $95.09 | Visa ending in 1111  |

  @TC.15358
  Scenario: BILL.8500 Verify Next Renewal text align is set to left justify
    Given I log in bus admin console as MozyPro 10 GB Plan (Monthly) test partner
    When I navigate to billing information view
    Then Next Renewal text-align property should set to start

  @TC.16105
  Scenario: BILL.8512 Verify the price listed for current plan
    Given I log in bus admin console as MozyPro 250 GB Plan (Yearly) test partner
    When I navigate to billing information view
    Then Current plan price list should be:
    | Plan                          | Total Price |
    | MozyPro 250 GB Plan (Monthly) | $94.99      |
    | jtme-Subtotal                 | $94.99      |
    | jtme-Tax                      | $0.10       |
    | jtme-Total                    | $95.09      |

  @BILL.8500-2
  Scenario: Verify Overdraft Protection text align is set to left
    Given I log in bus admin console as MozyPro 10 GB Plan (Monthly) test partner
    When I navigate to billing information view
    Then Overdraft Protection text-align property should set to left

  @BILL.8500-3
  Scenario: Verify Overdraft Protection status is set to disabled by default
    Given I log in bus admin console as MozyPro 10 GB Plan (Monthly) test partner
    When I navigate to billing information view
    Then Overdraft Protection status text's should be Disabled (more info)
