Feature: Change subscription period

  As a Mozy Administrator
  I want to change my subscription period longer
  so that I can save money on my Mozy subscription and be billed less frequently.

  Background:
    Given I log in bus admin console as administrator

  @TC.15231 @smoke_test
  Scenario: Mozy-15231 Move upstream with subscription period (MozyPro / Monthly -> Yearly)
    When I add a MozyPro partner with 1 month(s) period, 250 GB, $94.99 plan, no server plan, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I change subscription up to MozyPro with 250 GB of space to distribute however you want amongst unlimited desktop computers - billed annually
    Then Subscription changed message should be Your account has been changed to yearly billing.

  @TC.15232
  Scenario: Mozy-15232 Move upstream with subscription period (MozyPro / Yearly -> Biennially)
    When I add a MozyPro partner with 12 month(s) period, 500 GB, $2,089.89 plan, no server plan, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I change subscription up to MozyPro with 500 GB of space to distribute however you want amongst unlimited desktop computers - billed biennially
    Then Subscription changed message should be Your account has been changed to biennial billing.

  @TC.15233
  Scenario: Mozy-15233 Move upstream with subscription period (MozyPro / Monthly -> Biennially)
    When I add a MozyPro partner with 1 month(s) period, 1 TB, $379.99 plan, no server plan, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I change subscription up to MozyPro with 1 TB of space to distribute however you want amongst unlimited desktop computers - billed biennially
    Then Subscription changed message should be Your account has been changed to biennial billing.

  @TC.15234 @smoke_test
  Scenario: Mozy-15234 Move downstream with subscription period (MozyPro / Biennially -> Yearly)
    When I add a MozyPro partner with 24 month(s) period, 50 GB, $419.79 plan, no server plan, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I change subscription down to MozyPro with 50 GB of space to distribute however you want amongst unlimited desktop computers - billed annually
    Then Subscription changed message should be Your account will be switched to yearly billing schedule at your next renewal.

  @TC.15235
  Scenario: Mozy-15235 Move downstream with subscription period (MozyPro / Yearly -> Monthly)
    When I add a MozyPro partner with 12 month(s) period, 100 GB, $439.89 plan, no server plan, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I change subscription down to MozyPro with 100 GB of space to distribute however you want amongst unlimited desktop computers - billed monthly
    Then Subscription changed message should be Your account will be switched to monthly billing schedule at your next renewal.

  @TC.15236
  Scenario: Mozy-15236 Move downstream with subscription period (MozyPro / Biennially -> Monthly)
    When I add a MozyPro partner with 24 month(s) period, 10 GB, $209.79 plan, no server plan, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I change subscription down to MozyPro with 10 GB of space to distribute however you want amongst unlimited desktop computers - billed monthly
    Then Subscription changed message should be Your account will be switched to monthly billing schedule at your next renewal.

  @TC.15238 @smoke_test
  Scenario: Mozy-15238 Move upstream with subscription period (MozyEnterprise / Yearly -> Biennially)
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I change subscription up to A MozyEnterprise user with unlimited space to use on a single desktop computer - billed biennially
    Then Subscription changed message should be Your account has been changed to biennial billing.

  @TC.15239
  Scenario: Mozy-15239 Move upstream with subscription period (MozyEnterprise / Biennially -> 3 Years)
    When I add a MozyEnterprise partner with 24 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I change subscription up to A MozyEnterprise user with unlimited space to use on a single desktop computer - billed every 3 years
    Then Subscription changed message should be Your account has been changed to 3-year billing.

  @TC.15240
  Scenario: Mozy-15240 Move upstream with subscription period (MozyEnterprise / Yearly -> 3 Years)
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I change subscription up to A MozyEnterprise user with unlimited space to use on a single desktop computer - billed every 3 years
    Then Subscription changed message should be Your account has been changed to 3-year billing.

  @TC.15241
  Scenario: Mozy-15241 Move downstream with subscription period (MozyEnterprise / Biennially -> Yearly)
    When I add a MozyEnterprise partner with 24 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I change subscription down to A MozyEnterprise user with unlimited space to use on a single desktop computer - billed annually
    Then Subscription changed message should be Your account will be switched to yearly billing schedule at your next renewal.

  @TC.15243
  Scenario: Mozy-15243 Move downstream with subscription period (MozyEnterprise / 3 Years -> Biennially)
    When I add a MozyEnterprise partner with 36 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I change subscription down to A MozyEnterprise user with unlimited space to use on a single desktop computer - billed biennially
    Then Subscription changed message should be Your account will be switched to biennially billing schedule at your next renewal.

  @TC.15244
  Scenario: Mozy-15244 Move downstream with subscription period (MozyEnterprise / 3 Years -> Yearly)
    When I add a MozyEnterprise partner with 36 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I change subscription down to A MozyEnterprise user with unlimited space to use on a single desktop computer - billed annually
    Then Subscription changed message should be Your account will be switched to yearly billing schedule at your next renewal.

  @TC.15245
  Scenario: Mozy-15245 Move upstream with subscription period (Reseller / Monthly -> Yearly)
    When I add a Reseller partner with 1 month(s) period, Silver Reseller, 100 GB plan, no server plan, 0 add-on, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I change subscription up to The base plan to create a Mozy Silver Reseller's annual commitment. 1 GB of space to distribute however you want amongst unlimited desktop computers - billed annually
    Then Subscription changed message should be Your account has been changed to yearly billing.

  @TC.15246
  Scenario: Mozy-15246 Move downstream with subscription period (Reseller / Monthly -> Yearly)
    When I add a Reseller partner with 12 month(s) period, Gold Reseller, 500 GB plan, has server plan, 10 add-on, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I change subscription down to The base plan to create a Mozy Gold Reseller's annual commitment. 1 GB of space to distribute however you want amongst unlimited desktop computers - billed monthly
    Then Subscription changed message should be Your account will be switched to monthly billing schedule at your next renewal.

  @TC.15253
  Scenario: Mozy-15253 Verify MozyPro partner master plan section details
    When I add a MozyPro partner with 1 month(s) period, 250 GB, $94.99 plan, no server plan, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I navigate to billing information view
    Then Next renewal master plan period should be Monthly (change)
    And Next renewal master plan date should be +1 month(s)
    And Next renewal master plan amount should be $94.99 (Without taxes or discounts)
    And Next renewal master plan payment type should be Visa ending in 1111 (change)

  @TC.XXXXX @not_done
  Scenario: Mozy-15253 Verify MozyEnterprise partner master plan section details
    When I add a MozyEnterprise partner with 36 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I navigate to billing information view
    Then Next renewal master plan period should be 3-year (change)
    And Next renewal master plan date should be +36 month(s)
    And Next renewal master plan amount should be $259.00 (Without taxes or discounts)
    And Next renewal master plan payment type should be Visa ending in 1111 (change)

  @TC.15254 @not_done
  Scenario: Mozy-15254 Verify VAT information in the billing information view
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 plan, no server plan, no coupon, Belgium country, BE0883236072 VAT number, credit card payment
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I navigate to billing information view
    Then Next renewal master plan amount should be $19.99(including VAT)

  @TC.15258
  Scenario: Mozy-15258 Verify Next Renewal text align is set to left justify
    Given I log in bus admin console as administrator
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 plan, no server plan, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I navigate to billing information view
    Then Next Renewal text align is set to left justify

  @TC.15259
  Scenario: Mozy-15259 Verify Autogrow status is set to disabled by default (mozyenterprise)
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I navigate to billing information view
    Then Autogrow status text's should be Disabled (more info)

  @TC.15260
  Scenario: Mozy-15260 Verify Autogrow status is set to disabled by default (reseller)
    When I add a Reseller partner with 1 month(s) period, Silver Reseller, 100 GB plan, no server plan, 0 add-on, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I navigate to billing information view
    Then Autogrow status text's should be Disabled (more info)

  @TC.15383
  Scenario: Mozy-15383 Verify confirmation message when move subscription period to yearly (reseller)
    When I add a Reseller partner with 1 month(s) period, Silver Reseller, 100 GB plan, no server plan, 0 add-on, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I try to change subscription to The base plan to create a Mozy Silver Reseller's annual commitment. 1 GB of space to distribute however you want amongst unlimited desktop computers - billed annually
    Then Change subscription confirmation message should include Are you sure that you want to change your subscription period from monthly to yearly billing?
    And Change subscription confirmation message should include If you choose to continue, your account will be credited for the remainder of your monthly Subscription, then charged for a new yearly subscription beginning today. By choosing yearly billing, you will receive 1 free month(s) of Mozy service.
    And Change subscription confirmation message should include Any resources you scheduled for return in your next subscription have been deducted from the new subscription total.

  @TC.15384
  Scenario: Mozy-15384 Verify confirmation message when move subscription period to biennially (mozypro)
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 plan, no server plan, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I try to change subscription to MozyPro with 50 GB of space to distribute however you want amongst unlimited desktop computers - billed biennially
    Then Change subscription confirmation message should include Are you sure that you want to change your subscription period from monthly to biennial billing?
    And Change subscription confirmation message should include If you choose to continue, your account will be credited for the remainder of your monthly Subscription, then charged for a new biennial subscription beginning today. By choosing biennial billing, you will receive 3 free month(s) of Mozy service.
    And Change subscription confirmation message should include Any resources you scheduled for return in your next subscription have been deducted from the new subscription total.

  @TC.15385
  Scenario: Mozy-15385 Verify confirmation message when move subscription period to 3 years (mozyenterprise)
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I try to change subscription to A MozyEnterprise user with unlimited space to use on a single desktop computer - billed every 3 years
    Then Change subscription confirmation message should include Are you sure that you want to change your subscription period from yearly to 3-year billing?
    And Change subscription confirmation message should include If you choose to continue, your account will be credited for the remainder of your yearly Subscription, then charged for a new 3-year subscription beginning today. By choosing 3-year billing, you will receive 4 free month(s) of Mozy service.
    And Change subscription confirmation message should include Any resources you scheduled for return in your next subscription have been deducted from the new subscription total.

  @TC.16658
  Scenario: Mozy-16658 Verify MozyPro partner supplemental plan section details
    When I add a MozyPro partner with 1 month(s) period, 250 GB, $94.99 plan, no server plan, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    And I masquerade as the new partner
    And I navigate to billing information view
    Then Next renewal supplemental plan details should be:
    | description             | amount   |
    | Total price for 250 GB  | $94.99  |

  @TC.16659
  Scenario: Mozy-16659 Verify MozyEnterprise partner supplemental plan section details
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    And I masquerade as the new partner
    And I navigate to billing information view
    Then Next renewal supplemental plan details should be:
    | description                         | amount   |
    | Total price for MozyEnterprise User | $95.00  |

  @TC.16660
  Scenario: Mozy-16660 Verify Reseller partner supplemental plan section details
    When I add a Reseller partner with 1 month(s) period, Silver Reseller, 100 GB plan, no server plan, 0 add-on, no coupon, credit card payment
    Then Partner creation successful message should be New partner created
    And I masquerade as the new partner
    And I navigate to billing information view
    Then Next renewal supplemental plan details should be:
    | description                           | amount  |
    | Number purchased 	                    | 100     |
    | Price each 	                        | $0.42   |
    | Total price for GB - Silver Reseller 	| $42.00  |

