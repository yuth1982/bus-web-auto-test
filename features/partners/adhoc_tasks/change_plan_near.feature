Feature: Bugs #144165 Cannot increase resources in BUS, when we compare plans by price, we compare the "Default" USD price, not the price in use.
  Requirement #141405 Changing price schedules in Aria, and how this is reflected in BUS
  Requirement #143134 Aria coupon code remove: change period and change plan

  As a Mozy Administrator
  I change plan from 1 plan with server plan to near plan with server plan
  So that I change successfully without issues

  Background:
    Given I log in bus admin console as administrator

  @TC.144165_real_0101 @add_new_partner @mozypro @bus
  Scenario: MozyPro USD 10 gb yearly to 50 gb yearly with server
    When I add a new MozyPro partner:
      | company name                                   | period | base plan | server plan | net terms |
      | DONOT MozyPro USD 10 gb yearly to 50 gb yearly | 12     | 10 GB     | yes         | yes       |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 50 GB     |
    Then Change plan charge summary should be:
      | Description                   | Amount   |
      | Credit for remainder of plans | -$153.78 |
      | Charge for upgraded plans     | $296.78  |
      |                               |          |
      | Total amount to be charged    | $143.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 50 GB     | Yes         |

  @TC.144165_real_010102 @add_new_partner @mozypro @bus
  Scenario: MozyPro USD 50 gb yearly to 10 gb yearly
    When I add a new MozyPro partner:
      | company name                                   | period | base plan | server plan | net terms |
      | DONOT MozyPro USD 50 gb yearly to 10 gb yearly | 12     | 50 GB     | yes         | yes       |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 10 GB     |
    Then Change plan charge message should be:
    """
      Are you sure that you want to downgrade your Mozy plan? When you return resources, they are no longer available for use and your next charge will be reduced to renew only the remaining resources.
    """
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 10 GB     | Yes         |

  @TC.144165_real_0201 @add_new_partner @mozypro @bus
  Scenario: MozyPro USD 50 gb yearly to 100 gb yearly
    When I add a new MozyPro partner:
      | company name                                    | period | base plan | server plan | net terms |
      | DONOT MozyPro USD 50 gb yearly to 100 gb yearly | 12     | 50 GB     | yes         | yes       |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then Change plan charge summary should be:
      | Description                   | Amount   |
      | Credit for remainder of plans | -$296.78 |
      | Charge for upgraded plans     | $582.78  |
      |                               |          |
      | Total amount to be charged    | $286.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | Yes         |

  @TC.144165_real_0202 @add_new_partner @mozypro @bus
  Scenario: MozyPro France 50 gb yearly to 100 gb yearly
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | server plan | create under   | country | cc number        |
      | DONOT MozyPro France 50 gb yearly to 100 gb yearly | 12     | 50 GB     | yes         | MozyPro France | France  | 4485393141463880 |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then Change plan charge summary should be:
      | Description                   | Amount   |
      | Credit for remainder of plans | -€283.54 |
      | Charge for upgraded plans     | €540.94  |
      |                               |          |
      | Total amount to be charged    | €257.40  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | Yes         |

  @TC.144165_real_020202 @add_new_partner @mozypro @bus
  Scenario: MozyPro France 100 gb yearly to 50 gb yearly
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | server plan | create under   | country | cc number        |
      | DONOT MozyPro France 100 gb yearly to 50 gb yearly | 12     | 100 GB    | yes         | MozyPro France | France  | 4485393141463880 |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 50 GB     |
    Then Change plan charge message should be:
    """
      Are you sure that you want to downgrade your Mozy plan? When you return resources, they are no longer available for use and your next charge will be reduced to renew only the remaining resources.
    """
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 50 GB     | Yes         |

  @TC.144165_real_0203 @add_new_partner @mozypro @bus
  Scenario: MozyPro UK 50 gb yearly to 100 gb yearly
    When I add a new MozyPro partner:
      | company name                                   | period | base plan | server plan | create under | country        | cc number        |
      | DONOT MozyPro UK 50 gb yearly to 100 gb yearly | 12     | 50 GB     | yes         | MozyPro UK   | United Kingdom | 4916783606275713 |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then Change plan charge summary should be:
      | Description                   | Amount   |
      | Credit for remainder of plans | -£250.54 |
      | Charge for upgraded plans     | £474.94  |
      |                               |          |
      | Total amount to be charged    | £224.40  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | Yes         |

  @TC.144165_real_0301 @add_new_partner @mozypro @bus
  Scenario: MozyPro UK 500 gb yearly to 1 tb yearly
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | server plan | create under | country        | cc number        |
      | DONOT MozyPro UK 500 gb yearly to 1 tb yearly | 12     | 500 GB    | yes         | MozyPro UK   | United Kingdom | 4916783606275713 |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 1 TB      |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -£1,268.14 |
      | Charge for upgraded plans     | £2,476.54  |
      |                               |            |
      | Total amount to be charged    | £1,208.40  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 1 TB      | Yes         |

  @TC.144165_real_030102 @add_new_partner @mozypro @bus
  Scenario: MozyPro UK 1 tb yearly to 500 gb yearly
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | server plan | create under | country        | cc number        |
      | DONOT MozyPro UK 1 tb yearly to 500 gb yearly | 12     | 1 TB      | yes         | MozyPro UK   | United Kingdom | 4916783606275713 |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 500 GB    |
    Then Change plan charge message should be:
    """
      Are you sure that you want to downgrade your Mozy plan? When you return resources, they are no longer available for use and your next charge will be reduced to renew only the remaining resources.
    """
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | Yes         |

  @TC.144165_real_0302 @add_new_partner @mozypro @bus
  Scenario: MozyPro Germany 500 gb yearly to 1 tb yearly
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | server plan | create under    | country | cc number        |
      | DONOT MozyPro Germany 500 gb yearly to 1 tb yearly | 12     | 500 GB    | yes         | MozyPro Germany | Germany | 4188181111111112 |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 1 TB      |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -€1,749.04 |
      | Charge for upgraded plans     | €3,415.04  |
      |                               |            |
      | Total amount to be charged    | €1,666.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 1 TB      | Yes         |

  @TC.144165_real_0303 @add_new_partner @mozypro @bus
  Scenario: MozyPro US 500 gb yearly to 1 tb yearly
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | server plan |
      | DONOT MozyPro US 500 gb yearly to 1 tb yearly | 12     | 500 GB    | yes         |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 1 TB      |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -$1,616.78 |
      | Charge for upgraded plans     | $3,156.78  |
      |                               |            |
      | Total amount to be charged    | $1,540.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 1 TB      | Yes         |

  @TC.144165_real_0401 @add_new_partner @mozypro @bus
  Scenario: MozyPro US 4 tb yearly to 8 tb yearly
    When I add a new MozyPro partner:
      | company name                                | period | base plan | server plan |
      | DONOT MozyPro US 4 tb yearly to 8 tb yearly | 12     |  4 TB     | yes         |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 8 TB      |
    Then Change plan charge summary should be:
      | Description                   | Amount      |
      | Credit for remainder of plans | -$11,472.78 |
      | Charge for upgraded plans     | $32,779.56  |
      |                               |             |
      | Total amount to be charged    | $21,306.78  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 8 TB      | Yes         |

  @TC.144165_real_040102 @add_new_partner @mozypro @bus
  Scenario: MozyPro US 8 tb yearly to 4 tb yearly
    When I add a new MozyPro partner:
      | company name                                | period | base plan | server plan |
      | DONOT MozyPro US 8 tb yearly to 4 tb yearly | 12     | 8 TB      | yes         |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 4 TB      |
    Then Change plan charge message should be:
    """
      Are you sure that you want to downgrade your Mozy plan? When you return resources, they are no longer available for use and your next charge will be reduced to renew only the remaining resources.
    """
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 4 TB      | Yes         |

  @TC.144165_real_0402 @add_new_partner @mozypro @bus
  Scenario: MozyPro Ireland 4 tb yearly to 8 tb yearly
    When I add a new MozyPro partner:
      | company name                                     | period | base plan | server plan | create under    | country | cc number        |
      | DONOT MozyPro Ireland 4 tb yearly to 8 tb yearly | 12     |  4 TB     | yes         | MozyPro Ireland | Ireland | 4319402211111113 |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 8 TB      |
    Then Change plan charge summary should be:
      | Description                   | Amount      |
      | Credit for remainder of plans | -€12,828.62 |
      | Charge for upgraded plans     | €31,118.46  |
      |                               |             |
      | Total amount to be charged    | €18,289.84  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 8 TB      | Yes         |

  @TC.144165_real_0403 @add_new_partner @mozypro @bus
  Scenario: MozyPro UK 4 tb yearly to 8 tb yearly
    When I add a new MozyPro partner:
      | company name                                | period | base plan | server plan | create under | country        | cc number        |
      | DONOT MozyPro UK 4 tb yearly to 8 tb yearly | 12     |  4 TB     | yes         | MozyPro UK   | United Kingdom | 4916783606275713 |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 8 TB      |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -£8,998.54 |
      | Charge for upgraded plans     | £24,973.88 |
      |                               |            |
      | Total amount to be charged    | £15,975.34 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 8 TB      | Yes         |
