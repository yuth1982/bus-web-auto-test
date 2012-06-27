Feature:
  As a Mozy Administrator
  I want to create partners
  So that I can organize my business in a way that works for me

  Background:
    Given I log in bus admin console as administrator

  @add_pro_1 @smoke_test @add_partner_basic
  Scenario: Add a new MozyPro partner
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 plan, no server plan
    Then Partner creation successful message should be New partner created

  @add_pro_vat
  Scenario: Add a new MozyPro partner with VAT number
    When I add a MozyPro partner with 12 month(s) period, 500 GB, $2,089.89 plan, has server plan, Belgium country, BE0883236072 VAT number
    Then Partner creation successful message should be New partner created

  @add_pro_net_term
  Scenario: Add a new MozyPro partner - Net Terms
    When I add a MozyPro partner with 24 month(s) period, 1 TB, $7,979.79 plan, no server plan, net terms payment
    Then Partner creation successful message should be New partner created

  @add_pro_other
  Scenario Outline: Add a new MozyPro partner
    When I add a MozyPro partner with <period> month(s) period, <supplemental> plan, <add-on> server plan
    Then Partner creation successful message should be New partner created

  Scenarios:
    |period | supplemental      | add-on  |
    | 12    | 500 GB, $2,089.89 | has     |
    | 24    | 1 TB, $7,979.79   | no      |

  @add_enterprise_1 @smoke_test @add_partner_basic
  Scenario: Add a new MozyEnterprise partner
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), None add-on plan
    Then Partner creation successful message should be New partner created

  @add_enterprise_2
  Scenario: Add a new MozyEnterprise partner
    When I add a MozyEnterprise partner with 12 month(s) period, 10 user(s), 16 TB Server Plan, $511,056.04 add-on plan
    Then Partner creation successful message should be New partner created

  @add_enterprise_3
  Scenario: Add a new MozyEnterprise partner
    When I add a MozyEnterprise partner with 12 month(s) period, no initial purchase
    Then Partner creation successful message should be New partner created

  @add_enterprise_other
  Scenario Outline: Add a new MozyEnterprise partner
    When I add a MozyEnterprise partner with <period> month(s) period, <users> user(s), <server add-on> add-on plan
    Then Partner creation successful message should be New partner created

  Scenarios:
    |period | users | server add-on                   |
    | 24    | 5     | 1 TB Server Plan, $12,299.40    |
    | 36    | 10    | 2 TB Server Plan, $23,699.40    |

  @add_reseller_1 @smoke_test @add_partner_basic
  Scenario: Add a new Reseller partner
    When I add a Reseller partner with 1 month(s) period, Silver Reseller, 100 GB plan, no server plan, 0 add-on
    Then Partner creation successful message should be New partner created

  @add_reseller_2
  Scenario Outline: Add a new Reseller partner
    When I add a Reseller partner with <period> month(s) period, <type> Reseller, <quota> GB plan, <add-on> server plan, <add-on quota> add-on
    Then Partner creation successful message should be New partner created
  Scenarios:
    | period  | type      | quota | add-on  | add-on quota  |
    | 12      | Gold      | 500   | has     | 10            |

