  Feature: Add a new EU mozypro partner

    As a Mozy Administrator
    I want to create MozyPro EU partners
    So that I can organize my business in a way that works for me

    Background:
      Given I log in bus admin console as administrator

    #---------------------------------------------------------------------------------
    #    negative test cases:
    #---------------------------------------------------------------------------------

  @TC.40001 @bus @2.17 @add_new_partner @mozypro @signup_neg @vat
  Scenario: 40001 Add New MozyPro Partner - invalid VAT number

  # no country code in vat number
    When I add a new MozyPro partner:
      | period |   create under   |  country  |    vat number     |
      | 1      |  MozyPro Ireland |  Ireland  |   820c9dIN@#;v    |
    Then Create partner error message should be VAT number is invalid. Please try again.

  # country code match, vat number is invalid
    When I add a new MozyPro partner:
      | period |  country  |    vat number     |
      | 1      |  Ireland  |   IE08410091490   |
    Then Create partner error message should be VAT number is invalid. Please try again.

  # vat number country code not match country
    When I add a new MozyPro partner:
      | period |  create under    | country   |    vat number      |
      | 1      |  MozyPro Germany |  Ireland  |   FR08410091490    |
    Then Create partner error message should be VAT number is invalid. Please try again.


  @TC.40003 @bus @2.17 @add_new_partner @mozypro @signup_neg
  Scenario: 40003 Add New MozyPro Partner - invalid coupon
    When I add a new MozyPro partner:
      | period |  country          |    coupon              |
      | 1      |  United Kingdom   |   10OffInvalidCoupon   |
    Then Create partner error message should be Invalid coupon code

  @TC.41001 @bus @2.17 @add_new_partner @mozypro @signup_alert
  Scenario: 41001 Add New MozyPro Partner - If no vat number, profile country is EU, billing country is not EU, alert will pop up. Partner created failed if BIN country not match.
    When I add a new MozyPro partner:
      | period | base plan |   create under    |  country  | billing country   | cc number        |
      | 1      | 50 GB     |  MozyPro Germany  |  Spain    |    United States  | 5232037812229004 |
    And Aria payment error message should be Could not validate payment information.
    And the billing country alert is This customer might be an EU customer without a VAT number, the billing contact address doesn't match the account country. Please verify the customer's location manually offline

  @TC.41002 @bus @2.17 @add_new_partner @mozypro @signup_alert
  Scenario: 41002 Add New MozyPro Partner - If no vat number, profile country is not EU, billing country is EU, alert will pop up. BIN country check will take effect.
    When I add a new MozyPro partner:
      | period | base plan |   create under    |  country       | billing country   | cc number        |
      | 1      | 50 GB     |  MozyPro          |  United States |  United Kingdom   | 4916783606275713 |
    And New partner should be created
    And the billing country alert is This customer might be an EU customer without a VAT number, the billing contact address doesn't match the account country. Please verify the customer's location manually offline

  @TC.41003 @bus @2.17 @add_new_partner @mozypro @signup_alert
  Scenario: 41003 Add New MozyPro Partner - If no vat number, profile country&billing country all EU and profile country not match billing country, alert will pop up.
    When I add a new MozyPro partner:
      | period | base plan |   create under    |  country  | billing country | cc number        |
      | 1      | 50 GB     |  MozyPro France   |   Germany |  Poland         | 5232037812229004 |
    And New partner should be created
    And the billing country alert is This customer might be an EU customer without a VAT number, the billing contact address doesn't match the account country. Please verify the customer's location manually offline

  @TC.41004 @bus @2.17 @add_new_partner @mozypro @signup_alert
  Scenario: 41004 Add New MozyPro Partner - If no vat number, profile country is EU, when select payment method as Net Terms, alert will pop up
    When I add a new MozyPro partner:
      | period | base plan |   create under    |  country  |  net terms |
      | 1      | 50 GB     |  MozyPro Ireland  |   Finland |  yes       |
    And New partner should be created
    And the billing country alert is This is an EU customer without a VAT number and credit card info. Please verify the customer's location manually offline.

  @TC.41005 @bus @2.17 @add_new_partner @mozypro @signup_alert
  Scenario: 41005 Add New MozyPro Partner - If no vat number, profile country&billing country all not EU and profile country not match billing country, alert will not pop up
    When I add a new MozyPro partner:
      | period | base plan |  create under |  country   |  billing country | net terms  |
      | 12     | 50 GB     |  MozyPro      |  Hong Kong |  United States   | yes        |
    And New partner should be created
    And there is no popup alert during partner creation

  @TC.41006 @bus @2.17 @add_new_partner @mozypro @signup_alert
  Scenario: 41006 Add New MozyPro Partner - If no vat number, profile country&billing country all not EU and profile country match billing country, alert will not pop up
    When I add a new MozyPro partner:
      | period | base plan |  create under | country       | net terms  |
      | 12     | 50 GB     |  MozyPro      | United States | yes        |
    And New partner should be created
    And there is no popup alert during partner creation

  @TC.41007 @bus @2.17 @add_new_partner @mozypro @signup_alert
  Scenario: 41007 Add New MozyPro Partner - If no vat number, profile country&billing country all not EU and profile country not match billing country, alert will not pop up, sign up will succeed even BIN country not match.
    When I add a new MozyPro partner:
      | period | base plan |  create under |  country         | billing country |
      | 12     | 50 GB     |  MozyPro      |  United States   | Japan           |
    And New partner should be created
    And there is no popup alert during partner creation

  @TC.41008 @bus @2.17 @add_new_partner @mozypro @signup_alert
  Scenario: 41008 Add New MozyPro Partner - If no vat number, profile country&billing country all not EU, alert will not pop up, sign up will succeed
    When I add a new MozyPro partner:
      | period | base plan |  create under |  country         |
      | 12     | 50 GB     |  MozyPro      |  United States   |
    And New partner should be created
    And there is no popup alert during partner creation

  @TC.41009 @bus @2.17 @add_new_partner @mozypro @signup_alert
  Scenario: 41009 Add New MozyPro Partner - If no vat number, profile country is same as billing country (EU), sign up using nt, alert will pop up, sign up will secceed
    When I add a new MozyPro partner:
      | period | base plan |   create under    |  country  |  net terms |
      | 12     | 50 GB     |  MozyPro Ireland  |  Ireland  |  yes       |
    And New partner should be created
    And the billing country alert is This is an EU customer without a VAT number and credit card info. Please verify the customer's location manually offline.

  @TC.41010 @bus @2.17 @add_new_partner @mozypro @signup_alert
  Scenario: 41010 Add New MozyPro Partner - If no vat number, profile country is same as billing country (EU), alert will not pop up, sign up use cc will secceed if BIN country match.
    When I add a new MozyPro partner:
      | period | base plan |   create under    |  country  |  cc number        |
      | 12     | 50 GB     |  MozyPro Ireland  |  Ireland  |  4319402211111113 |
    And New partner should be created
    And there is no popup alert during partner creation

  @TC.41011 @bus @2.17 @add_new_partner @mozypro @signup_alert @vat
  Scenario: 41011 Add New MozyPro Partner - partner with valid vat number should sign up successfully, no alert pop up
    When I add a new MozyPro partner:
      | period | base plan |   create under    |  country  |  cc number        |  vat number |
      | 12     | 50 GB     |  MozyPro Ireland  |  Ireland  |  4319402211111113 |  IE9691104A |
    And New partner should be created
    And there is no popup alert during partner creation

  @TC.41012 @bus @2.17 @add_new_partner @mozypro @signup_alert @vat
  Scenario: 41012 Add New MozyPro Partner - partner with valid vat number should sign up successfully, no alert pop up
    When I add a new MozyPro partner:
      | period | base plan |   create under    |  country  | billing country |  cc number        |  vat number |
      | 12     | 50 GB     |  MozyPro Ireland  |  Ireland  |  France         |  4485393141463880 |  IE9691104A |
    And New partner should be created
    And there is no popup alert during partner creation

  @TC.41013 @bus @2.17 @add_new_partner @mozypro @signup_alert @vat
  Scenario: 41013 Add New MozyPro Partner - partner with valid vat number should sign up successfully, no alert pop up
    When I add a new MozyPro partner:
      | period | base plan |   create under    |  country  | billing country | net terms |  vat number |
      | 12     | 50 GB     |  MozyPro Ireland  |  Ireland  | France          |  yes      |  IE9691104A |
    And New partner should be created
    And there is no popup alert during partner creation

  @TC.41014 @bus @2.17 @add_new_partner @mozypro @signup_alert @vat
  Scenario: 41014 Add New MozyPro Partner - partner with valid vat number should sign up successfully, no alert pop up
    When I add a new MozyPro partner:
      | period | base plan |   create under    |  country  | net terms |  vat number |
      | 12     | 50 GB     |  MozyPro Ireland  |  Ireland  |  yes      |  IE9691104A |
    And New partner should be created
    And there is no popup alert during partner creation

  #   Verified in busclient04 2.17.0.2
  #  manual case: VAT validation service is currently not available
  #  steps:
  #  1. edit app/models/vat.rb,  change soap server address
  #  2. run case TC.40005. test pass
  #  3. create EU partner with the vat number blank
  #  4. new partner should be created
  #  5. change app/models/vat.rb back
  # @TC.40005 @bus @2.17 @add_new_partner @mozypro
  # Scenario: 40002 Add New MozyPro Partner - VAT number not match country
  #  When I add a new MozyPro partner:
  #    | period | country   |    vat number      |
  #    | 1      |  France   |   FR08410091490    |
  #  Then Create partner error message should be The VAT validation service is temporarily unavailable, please leave the field blank and update later.

