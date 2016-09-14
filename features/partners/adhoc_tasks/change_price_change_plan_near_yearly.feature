Feature: Bugs #144165 Cannot increase resources in BUS, when we compare plans by price, we compare the "Default" USD price, not the price in use.
  Requirement #141405 Changing price schedules in Aria, and how this is reflected in BUS
  Requirement #143134 Aria coupon code remove: change period and change plan

  As a Mozy Administrator
  I upgrade from 1 plan with higher server plan to another plan with lower server plan
  So that I change successfully without issues

  old 100 GB with Server plan to new 250 GB with Server plan in USD&GBP yearly and biennially
  old 250 GB with Server plan to new 500 GB with Server plan in UDS&EURO&GBP yearly and biennially
  old 1 TB with Server plan to new 2 TB with Server plan in USD&GBP yearly and biennially
  old 2 TB with Server plan to 4 TB with Server plan USD&GBP yearly and biennially

  Background:
    Given I log in bus admin console as administrator

  @TC.144165_fake_0101 @add_new_partner @mozypro @bus
  Scenario: MozyPro USD 100 gb yearly to 250 gb yearly
    When I add a new MozyPro partner:
      | company name                                     | period | base plan | server plan | net terms |
      | DONOT MozyPro USD 100 gb yearly to 250 gb yearly | 12     | 100 GB    | yes         | yes       |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then Change plan charge summary should be:
      | Description                    | Amount   |
      | Credit for remainder of 100 GB | -$439.89 |
      | Charge for new 250 GB          | $729.89  |
      |                                |          |
      | Total amount to be charged     | $290.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 250 GB    | Yes         |

  @TC.144165_fake_010102 @add_new_partner @mozypro @bus
  Scenario: MozyPro USD 250 gb yearly to 100 gb yearly
    When I add a new MozyPro partner:
      | company name                                         | period | base plan | server plan | net terms |
      | DONOT MozyPro USD new 250 gb yearly to 100 gb yearly | 12     | 250 GB    | yes         | yes       |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then Change plan charge summary should be:
      | Description                         | Amount   |
      | Credit for remainder of Server Plan | -$124.89 |
      | Charge for new Server Plan          | $142.89  |
      |                                     |          |
      | Total amount to be charged          | $18.00   |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | Yes         |

  @TC.144165_fake_010103 @add_new_partner @mozypro @bus
  Scenario: MozyPro USD 250 gb yearly to 100 GB yearly
    When I add a new MozyPro partner:
      | company name                                              | period | country       |
      | DONOT EDIT MozyPro USD old 250 gb yearly to 100 GB yearly | 12     | United States |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 250 GB Plan (Annual)                   | Custom Old Standard | usd               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 250 GB Plan (Annual) | Custom Old Standard | usd               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                               |
      | 10 GB, $109.89                     |
      | 50 GB, $219.89                     |
      | 100 GB, $439.89                    |
      | 250 GB, $1,044.89 (current purchase) |
      | 500 GB, $1,459.89                  |
      | 1 TB, $2,919.89                    |
      | 2 TB, $5,769.89                    |
      | 4 TB, $11,089.89                   |
      | 8 TB, $31,679.78                   |
      | 12 TB, $47,519.67                  |
      | 16 TB, $63,359.56                  |
      | 20 TB, $79,199.45                  |
      | 24 TB, $95,039.34                  |
      | 28 TB, $110,879.23                 |
      | 32 TB, $126,719.12                 |
    And Add-ons price should be Server Plan, $175.89
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then Change plan charge summary should be:
      | Description                         | Amount   |
      | Credit for remainder of Server Plan | -$175.89 |
      | Charge for new Server Plan          | $142.89  |
      |                                     |          |
      | Total amount to be charged          | $0.00    |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | Yes         |

  @TC.144165_fake_0102 @add_new_partner @mozypro @bus
  Scenario: MozyPro UK 100 gb yearly to 250 gb yearly
    When I add a new MozyPro partner:
      | company name                                    | period | base plan | server plan | create under | country        | vat number  | net terms |
      | DONOT MozyPro UK 100 gb yearly to 250 gb yearly | 12     | 100 GB    | yes         | MozyPro UK   | United Kingdom | GB117223643 | yes       |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then Change plan charge summary should be:
      | Description                    | Amount   |
      | Credit for remainder of 100 GB | -£296.89 |
      | Charge for new 250 GB          | £477.89  |
      |                                |          |
      | Total amount to be charged     | £181.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 250 GB    | Yes         |

  @TC.144165_fake_010202 @add_new_partner @mozypro @bus
  Scenario: MozyPro UK 250 gb yearly to 100 gb yearly
    When I add a new MozyPro partner:
      | company name                                    | period | base plan | server plan | create under | country        | vat number  | net terms |
      | DONOT MozyPro UK 250 gb yearly to 100 gb yearly | 12     | 250 GB    | yes         | MozyPro UK   | United Kingdom | GB117223643 | yes       |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then Change plan charge summary should be:
      | Description                         | Amount  |
      | Credit for remainder of Server Plan | -£80.89 |
      | Charge for new Server Plan          | £98.89  |
      |                                     |         |
      | Total amount to be charged          | £18.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | Yes         |

  @TC.144165_fake_010203 @add_new_partner @mozypro @bus
  Scenario: MozyPro UK 250 gb yearly to 100 GB yearly
    When I add a new MozyPro partner:
      | company name                                             | period | create under | country        | net terms |
      | DONOT EDIT MozyPro UK old 250 gb yearly to 100 GB yearly | 12     | MozyPro UK   | United Kingdom | yes       |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 250 GB Plan (Annual)                   | Custom Old Standard | gbp               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 250 GB Plan (Annual) | Custom Old Standard | gbp               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                               |
      | 10 GB, £76.89                      |
      | 50 GB, £153.89                     |
      | 100 GB, £296.89                    |
      | 250 GB, £703.89 (current purchase) |
      | 500 GB, £954.89                    |
      | 1 TB, £1,908.89                    |
      | 2 TB, £3,771.89                    |
      | 4 TB, £7,248.89                    |
      | 8 TB, £20,041.78                   |
      | 12 TB, £30,062.67                  |
      | 16 TB, £40,083.56                  |
      | 20 TB, £50,104.45                  |
      | 24 TB, £60,125.34                  |
      | 28 TB, £70,146.23                  |
      | 32 TB, £80,167.12                  |
    And Add-ons price should be Server Plan, £120.89
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then Change plan charge summary should be:
      | Description                         | Amount   |
      | Credit for remainder of Server Plan | -£145.07 |
      | Charge for new Server Plan          | £118.67  |
      |                                     |          |
      | Total amount to be charged          | £0.00    |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | Yes         |

  @TC.144165_fake_0103 @add_new_partner @mozypro @bus
  Scenario: MozyPro Germany 100 gb yearly to 250 gb yearly
    When I add a new MozyPro partner:
      | company name                                         | period | base plan | server plan | create under    | country | vat number  | net terms |
      | DONOT MozyPro Germany 100 gb yearly to 250 gb yearly | 12     | 100 GB    | yes         | MozyPro Germany | Germany | DE812321109 | yes       |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then Change plan charge summary should be:
      | Description                    | Amount   |
      | Credit for remainder of 100 GB | -€340.89 |
      | Charge for new 250 GB          | €663.89  |
      |                                |          |
      | Total amount to be charged     | €323.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 250 GB    | Yes         |

  @TC.144165_fake_010302 @add_new_partner @mozypro @bus
  Scenario: MozyPro Germany 250 gb yearly to 100 gb yearly
    When I add a new MozyPro partner:
      | company name                                         | period | base plan | server plan | create under    | country | vat number  | net terms |
      | DONOT MozyPro Germany 250 gb yearly to 100 gb yearly | 12     | 250 GB    | yes         | MozyPro Germany | Germany | DE812321109 | yes       |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then Change plan charge summary should be:
      | Description                         | Amount   |
      | Credit for remainder of Server Plan | -€113.89 |
      | Charge for new Server Plan          | €109.89  |
      |                                     |          |
      | Total amount to be charged          | €0.00    |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | Yes         |

  @TC.144165_fake_010303 @add_new_partner @mozypro @bus
  Scenario: MozyPro Germany 250 gb yearly to 100 gb yearly
    When I add a new MozyPro partner:
      | company name                                             | period | create under    | country | net terms |
      | DONOT MozyPro Germany old 250 gb yearly to 100 gb yearly | 12     | MozyPro Germany | Germany | yes       |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 250 GB Plan (Annual)                   | Custom Old Standard | eur               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 250 GB Plan (Annual) | Custom Old Standard | eur               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                               |
      | 10 GB, €87.89                      |
      | 50 GB, €175.89                     |
      | 100 GB, €340.89                    |
      | 250 GB, €824.89 (current purchase) |
      | 500 GB, €1,327.89                  |
      | 1 TB, €2,654.89                    |
      | 2 TB, €5,245.89                    |
      | 4 TB, €10,081.89                   |
      | 8 TB, €24,419.78                   |
      | 12 TB, €36,629.67                  |
      | 16 TB, €48,839.56                  |
      | 20 TB, €61,049.45                  |
      | 24 TB, €73,259.34                  |
      | 28 TB, €85,469.23                  |
      | 32 TB, €97,679.12                  |
    And Add-ons price should be Server Plan, €142.89
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then Change plan charge summary should be:
      | Description                         | Amount   |
      | Credit for remainder of Server Plan | -€170.04 |
      | Charge for new Server Plan          | €130.77  |
      |                                     |          |
      | Total amount to be charged          | €0.00    |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | Yes         |

  @TC.144165_fake_0201 @add_new_partner @mozypro @bus
  Scenario: MozyPro USD 250 gb yearly to 500 GB yearly
    When I add a new MozyPro partner:
      | company name                                          | period | country       |
      | DONOT EDIT MozyPro USD 250 gb yearly to 500 GB yearly | 12     | United States |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 250 GB Plan (Annual)                   | Custom Old Standard | usd               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 250 GB Plan (Annual) | Custom Old Standard | usd               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                               |
      | 10 GB, $109.89                     |
      | 50 GB, $219.89                     |
      | 100 GB, $439.89                    |
      | 250 GB, $1,044.89 (current purchase) |
      | 500 GB, $1,459.89                  |
      | 1 TB, $2,919.89                    |
      | 2 TB, $5,769.89                    |
      | 4 TB, $11,089.89                   |
      | 8 TB, $31,679.78                   |
      | 12 TB, $47,519.67                  |
      | 16 TB, $63,359.56                  |
      | 20 TB, $79,199.45                  |
      | 24 TB, $95,039.34                  |
      | 28 TB, $110,879.23                 |
      | 32 TB, $126,719.12                 |
    And Add-ons price should be Server Plan, $175.89
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 500 GB    | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -$1,220.78 |
      | Charge for upgraded plans     | $1,616.78  |
      |                               |            |
      | Total amount to be charged    | $396.00    |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | Yes         |

  @TC.144165_fake_0202 @add_new_partner @mozypro @bus
  Scenario: MozyPro Germany 250 gb yearly to 500 GB yearly
    When I add a new MozyPro partner:
      | company name                                              | period | create under    | country | net terms |
      | DONOT EDIT MozyPro Germany 250 gb yearly to 500 GB yearly | 12     | MozyPro Germany | Germany | yes       |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 250 GB Plan (Annual)                   | Custom Old Standard | eur               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 250 GB Plan (Annual) | Custom Old Standard | eur               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                               |
      | 10 GB, €87.89                      |
      | 50 GB, €175.89                     |
      | 100 GB, €340.89                    |
      | 250 GB, €824.89 (current purchase) |
      | 500 GB, €1,327.89                  |
      | 1 TB, €2,654.89                    |
      | 2 TB, €5,245.89                    |
      | 4 TB, €10,081.89                   |
      | 8 TB, €24,419.78                   |
      | 12 TB, €36,629.67                  |
      | 16 TB, €48,839.56                  |
      | 20 TB, €61,049.45                  |
      | 24 TB, €73,259.34                  |
      | 28 TB, €85,469.23                  |
      | 32 TB, €97,679.12                  |
    And Add-ons price should be Server Plan, €142.89
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 500 GB    | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -€1,151.66 |
      | Charge for upgraded plans     | €1,749.04  |
      |                               |            |
      | Total amount to be charged    | €597.38    |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | Yes         |

  @TC.144165_fake_0203 @add_new_partner @mozypro @bus
  Scenario: MozyPro UK 250 gb yearly to 500 GB yearly
    When I add a new MozyPro partner:
      | company name                                         | period | create under | country        | net terms |
      | DONOT EDIT MozyPro UK 250 gb yearly to 500 GB yearly | 12     | MozyPro UK   | United Kingdom | yes       |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 250 GB Plan (Annual)                   | Custom Old Standard | gbp               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 250 GB Plan (Annual) | Custom Old Standard | gbp               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                               |
      | 10 GB, £76.89                      |
      | 50 GB, £153.89                     |
      | 100 GB, £296.89                    |
      | 250 GB, £703.89 (current purchase) |
      | 500 GB, £954.89                    |
      | 1 TB, £1,908.89                    |
      | 2 TB, £3,771.89                    |
      | 4 TB, £7,248.89                    |
      | 8 TB, £20,041.78                   |
      | 12 TB, £30,062.67                  |
      | 16 TB, £40,083.56                  |
      | 20 TB, £50,104.45                  |
      | 24 TB, £60,125.34                  |
      | 28 TB, £70,146.23                  |
      | 32 TB, £80,167.12                  |
    And Add-ons price should be Server Plan, £120.89
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 500 GB    | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount    |
      | Credit for remainder of plans | -£989.74  |
      | Charge for upgraded plans     | £1,268.14 |
      |                               |           |
      | Total amount to be charged    | £278.40   |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | Yes         |

  @TC.144165_fake_0301 @add_new_partner @mozypro @bus
  Scenario: MozyPro USD 1 TB yearly to 2 TB yearly
    When I add a new MozyPro partner:
      | company name                                      | period | country       |
      | DONOT EDIT MozyPro USD 1 TB yearly to 2 TB yearly | 12     | United States |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                  | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 1 TB Plan (Annual) | Custom Old Standard | usd               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                    | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 1 TB Plan (Annual) | Custom Old Standard | usd               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                               |
      | 10 GB, $109.89                     |
      | 50 GB, $219.89                     |
      | 100 GB, $439.89                    |
      | 250 GB, $729.89                   |
      | 500 GB, $1,459.89                  |
      | 1 TB, $4,179.89 (current purchase) |
      | 2 TB, $5,769.89                    |
      | 4 TB, $11,089.89                   |
      | 8 TB, $31,679.78                   |
      | 12 TB, $47,519.67                  |
      | 16 TB, $63,359.56                  |
      | 20 TB, $79,199.45                  |
      | 24 TB, $95,039.34                  |
      | 28 TB, $110,879.23                 |
      | 32 TB, $126,719.12                 |
#    And Add-ons price should be Server Plan, $329.89
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 2 TB      | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -$4,509.78 |
      | Charge for upgraded plans     | $6,082.78  |
      |                               |            |
      | Total amount to be charged    | $1,573.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 2 TB      | Yes         |

  @TC.144165_fake_0302 @add_new_partner @mozypro @bus
  Scenario: MozyPro France 1 TB yearly to 2 TB yearly
    When I add a new MozyPro partner:
      | company name                                         | period | create under   | country | net terms |
      | DONOT EDIT MozyPro France 1 TB yearly to 2 TB yearly | 12     | MozyPro France | France  | yes       |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                  | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 1 TB Plan (Annual) | Custom Old Standard | eur               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                    | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 1 TB Plan (Annual) | Custom Old Standard | eur               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                               |
      | 10 GB, €87.89                      |
      | 50 GB, €175.89                     |
      | 100 GB, €340.89                    |
      | 250 GB, €663.89                    |
      | 500 GB, €1,327.89                  |
      | 1 TB, €3,299.89 (current purchase) |
      | 2 TB, €5,245.89                    |
      | 4 TB, €10,081.89                   |
      | 8 TB, €24,419.78                   |
      | 12 TB, €36,629.67                  |
      | 16 TB, €48,839.56                  |
      | 20 TB, €61,049.45                  |
      | 24 TB, €73,259.34                  |
      | 28 TB, €85,469.23                  |
      | 32 TB, €97,679.12                  |
#    And Add-ons price should be Server Plan, €219.89
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 2 TB      | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -€4,223.74 |
      | Charge for upgraded plans     | €6,635.74  |
      |                               |            |
      | Total amount to be charged    | €2,412.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 2 TB      | Yes         |

  @TC.144165_fake_0303 @add_new_partner @mozypro @bus
  Scenario: MozyPro UK 1 TB yearly to 2 TB yearly
    When I add a new MozyPro partner:
      | company name                                     | period | create under | country        | cc number        |
      | DONOT EDIT MozyPro UK 1 TB yearly to 2 TB yearly | 12     | MozyPro UK   | United Kingdom | 4916783606275713 |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                  | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 1 TB Plan (Annual) | Custom Old Standard | gbp               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                    | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 1 TB Plan (Annual) | Custom Old Standard | gbp               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                               |
      | 10 GB, £76.89                      |
      | 50 GB, £153.89                     |
      | 100 GB, £296.89                    |
      | 250 GB, £477.89                    |
      | 500 GB, £954.89                    |
      | 1 TB, £2,694.89 (current purchase) |
      | 2 TB, £3,771.89                    |
      | 4 TB, £7,248.89                    |
      | 8 TB, £20,041.78                   |
      | 12 TB, £30,062.67                  |
      | 16 TB, £40,083.56                  |
      | 20 TB, £50,104.45                  |
      | 24 TB, £60,125.34                  |
      | 28 TB, £70,146.23                  |
      | 32 TB, £80,167.12                  |
#    And Add-ons price should be Server Plan, £219.89
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 2 TB      | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -£3,497.74 |
      | Charge for upgraded plans     | £4,770.94  |
      |                               |            |
      | Total amount to be charged    | £1,273.20  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 2 TB      | Yes         |

  @TC.144165_fake_0401 @add_new_partner @mozypro @bus
  Scenario: MozyPro USD 2 TB yearly to 4 TB yearly
    When I add a new MozyPro partner:
      | company name                                      | period | country       |
      | DONOT EDIT MozyPro USD 2 TB yearly to 4 TB yearly | 12     | United States |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                  | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 2 TB Plan (Annual) | Custom Old Standard | usd               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                    | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 2 TB Plan (Annual) | Custom Old Standard | usd               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                               |
      | 10 GB, $109.89                     |
      | 50 GB, $219.89                     |
      | 100 GB, $439.89                    |
      | 250 GB, $729.89                    |
      | 500 GB, $1,459.89                  |
      | 1 TB, $2,919.89                    |
      | 2 TB, $8,249.89 (current purchase) |
      | 4 TB, $11,089.89                   |
      | 8 TB, $31,679.78                   |
      | 12 TB, $47,519.67                  |
      | 16 TB, $63,359.56                  |
      | 20 TB, $79,199.45                  |
      | 24 TB, $95,039.34                  |
      | 28 TB, $110,879.23                 |
      | 32 TB, $126,719.12                 |
#    And Add-ons price should be Server Plan, $439.89
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 4 TB      | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -$8,689.78 |
      | Charge for upgraded plans     | $11,472.78 |
      |                               |            |
      | Total amount to be charged    | $2,783.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 4 TB      | Yes         |

  @TC.144165_fake_0402 @add_new_partner @mozypro @bus
  Scenario: MozyPro Ireland 2 TB yearly to 4 TB yearly
    When I add a new MozyPro partner:
      | company name                                          | period | create under    | country | cc number        |
      | DONOT EDIT MozyPro Ireland 2 TB yearly to 4 TB yearly | 12     | MozyPro Ireland | Ireland | 4319402211111113 |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                  | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 2 TB Plan (Annual) | Custom Old Standard | eur               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                    | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 2 TB Plan (Annual) | Custom Old Standard | eur               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                               |
      | 10 GB, €87.89                      |
      | 50 GB, €175.89                     |
      | 100 GB, €340.89                    |
      | 250 GB, €663.89                    |
      | 500 GB, €1,327.89                  |
      | 1 TB, €2,654.89                    |
      | 2 TB, €6,379.89 (current purchase) |
      | 4 TB, €10,081.89                   |
      | 8 TB, €24,419.78                   |
      | 12 TB, €36,629.67                  |
      | 16 TB, €48,839.56                  |
      | 20 TB, €61,049.45                  |
      | 24 TB, €73,259.34                  |
      | 28 TB, €85,469.23                  |
      | 32 TB, €97,679.12                  |
#    And Add-ons price should be Server Plan, €329.89
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 4 TB      | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -€8,253.02 |
      | Charge for upgraded plans     | €12,828.62 |
      |                               |            |
      | Total amount to be charged    | €4,575.60  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 4 TB      | Yes         |

  @TC.144165_fake_0403 @add_new_partner @mozypro @bus
  Scenario: MozyPro UK 2 TB yearly to 4 TB yearly
    When I add a new MozyPro partner:
      | company name                                     | period | create under | country        | cc number        |
      | DONOT EDIT MozyPro UK 2 TB yearly to 4 TB yearly | 12     | MozyPro UK   | United Kingdom | 4916783606275713 |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                  | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 2 TB Plan (Annual) | Custom Old Standard | gbp               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                    | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 2 TB Plan (Annual) | Custom Old Standard | gbp               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                               |
      | 10 GB, £76.89                      |
      | 50 GB, £153.89                     |
      | 100 GB, £296.89                    |
      | 250 GB, £477.89                    |
      | 500 GB, £954.89                    |
      | 1 TB, £1,908.89                    |
      | 2 TB, £5,224.89 (current purchase) |
      | 4 TB, £7,248.89                    |
      | 8 TB, £20,041.78                   |
      | 12 TB, £30,062.67                  |
      | 16 TB, £40,083.56                  |
      | 20 TB, £50,104.45                  |
      | 24 TB, £60,125.34                  |
      | 28 TB, £70,146.23                  |
      | 32 TB, £80,167.12                  |
#    And Add-ons price should be Server Plan, £329.89
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 4 TB      | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -£6,665.74 |
      | Charge for upgraded plans     | £8,998.54  |
      |                               |            |
      | Total amount to be charged    | £2,332.80  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 4 TB      | Yes         |

  @TC.144165_fake_0501 @add_new_partner @mozypro @bus
  Scenario: MozyPro US old 500 gb yearly to 1 tb yearly
    When I add a new MozyPro partner:
      | company name                                      | period | country       |
      | DONOT MozyPro US old 500 gb yearly to 1 tb yearly | 12     | United States |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                    | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 500 GB Plan (Annual) | Custom Old Standard | usd               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 500 GB Plan (Annual) | Custom Old Standard | usd               | 1              |
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 1 TB      |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -$2,309.78 |
      | Charge for upgraded plans     | $3,156.78  |
      |                               |            |
      | Total amount to be charged    | $847.00    |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 1 TB      | Yes         |
