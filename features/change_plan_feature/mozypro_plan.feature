Feature: Change plan

  Background:
    Given I log in bus admin console as administrator

  # This scenario is highly depend on our product plans, if scenario failed, please login bus and update plan table below
  @TC.18730 @Bug.83813 @Regression
  Scenario: 18730 Verify MozyPro monthly base plans info
    When I add a new MozyPro partner:
      | period | base plan    |
      | 1      | 10 GB, $9.99 |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans should be:
      | plan   |
      | 10 GB  |
      | 50 GB  |
      | 100 GB |
      | 250 GB |
      | 500 GB |
      | 1 TB   |
      | 2 TB   |
      | 4 TB   |
      | 8 TB   |
      | 12 TB  |
      | 16 TB  |
      | 20 TB  |
      | 24 TB  |
      | 28 TB  |
      | 32 TB  |

  # This scenario is highly depend on our product plans, if scenario failed, please login bus and update plan table below
  @TC.18731 @Bug.83813 @Regression
  Scenario: 18731 Verify MozyPro yearly base plans info
    When I add a new MozyPro partner:
      | period | base plan      |
      | 12     | 10 GB, $109.89 |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans should be:
      | plan   |
      | 10 GB  |
      | 50 GB  |
      | 100 GB |
      | 250 GB |
      | 500 GB |
      | 1 TB   |
      | 2 TB   |
      | 4 TB   |
      | 8 TB   |
      | 12 TB  |
      | 16 TB  |
      | 20 TB  |
      | 24 TB  |
      | 28 TB  |
      | 32 TB  |

  # This scenario is highly depend on our product plans, if scenario failed, please login bus and update plan table below
  @TC.18732 @Regression @Bug.83813
  Scenario: 18732 Verify MozyPro biennially base plans info
    When I add a new MozyPro partner:
      | period | base plan      |
      | 24     | 10 GB, $209.79 |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans should be:
      | plan   |
      | 10 GB  |
      | 50 GB  |
      | 100 GB |
      | 250 GB |
      | 500 GB |
      | 1 TB   |
      | 2 TB   |
      | 4 TB   |
      | 8 TB   |
      | 12 TB  |
      | 16 TB  |
      | 20 TB  |
      | 24 TB  |
      | 28 TB  |
      | 32 TB  |

  @TC.16485 @Smoke
  Scenario: 16485 MozyPro monthly US partner 10 GB moves to 50 GB plan
    When I add a new MozyPro partner:
      | period | base plan    |
      | 1      | 10 GB, $9.99 |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan       |
      | 50 GB, $19.99   |
    Then Change plan charge summary should be:
      | Description                     | Amount   |
      | Credit for remainder of 10 GB   | -$9.99   |
      | Charge for new 50 GB            | $19.99   |
      |                                 |          |
      | Total amount to be charged      | $10.00   |
    And Account plan should be changed
    And MozyPro new plan should be:
      | base plan                        |
      | 50 GB, $19.99 (current purchase) |

  @TC.18424 @Smoke
  Scenario: 18424 MozyPro monthly US partner 1 TB moves to 250 GB plan
    When I add a new MozyPro partner:
      | period | base plan     |
      | 1      | 1 TB, $379.99 |
    Then New partner should be created
    When I act as newly created partner account
    And I assign MozyPro allocated quota to 250 GB
    Then MozyPro resource quota should be changed
    When I change MozyPro account plan to:
      | base plan        |
      | 250 GB, $94.99   |
    Then Account plan should be changed
    And MozyPro new plan should be:
      | base plan                         |
      | 250 GB, $94.99 (current purchase) |

  @TC.18336 @Smoke
  Scenario: 18336 MozyPro yearly UK partner 500 GB moves to 1 TB plan
    When I add a new MozyPro partner:
      | period | base plan         | country        |
      | 12     | 500 GB, $2,089.89 | United Kingdom |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan       |
      | 1 TB, $4,179.89 |
    Then Change plan charge summary should be:
      | Description                     | Amount     |
      | Credit for remainder of 500 GB  | -$2,089.89 |
      | Charge for new 1 TB             | $5,141.26  |
      |                                 |            |
      | Total amount to be charged      | $3,051.37  |
    And Account plan should be changed
    And MozyPro new plan should be:
      | base plan                          |
      | 1 TB, $4,179.89 (current purchase) |

  @TC.18443 @Smoke
  Scenario: 18443 MozyPro yearly UK partner 500 GB moves to 250 GB plan
    When I add a new MozyPro partner:
      | period | base plan         | country        |
      | 12     | 500 GB, $2,089.89 | United Kingdom |
    Then New partner should be created
    When I act as newly created partner account
    And I assign MozyPro allocated quota to 250 GB
    Then MozyPro resource quota should be changed
    When I change MozyPro account plan to:
      | base plan         |
      | 250 GB, $1,044.89 |
    Then Account plan should be changed
    And MozyPro new plan should be:
      | base plan                            |
      | 250 GB, $1,044.89 (current purchase) |

  @TC.18248 @Smoke @Bug.84931
  Scenario: 18248 MozyPro biennially Ireland partner 1 TB moves to 2 TB plan
    When I add a new MozyPro partner:
      | period | base plan       | country |
      | 24     | 1 TB, $7,979.79 | Ireland |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan        |
      | 2 TB, $15,749.79 |
    Then Change plan charge summary should be:
      | Description                     | Amount     |
      | Credit for remainder of 1 TB    | -$7,979.79 |
      | Charge for new 2 TB             | $19,372.24 |
      |                                 |            |
      | Total amount to be charged      | $11,392.45 |
    And Account plan should be changed
    And MozyPro new plan should be:
      | base plan                           |
      | 2 TB, $15,749.79 (current purchase) |

  @TC.18407
  Scenario: 18407 MozyPro biennially Ireland partner 2 TB moves to 1 TB plan
    When I add a new MozyPro partner:
      | period | base plan        | country |
      | 24     | 2 TB, $15,749.79 | Ireland |
    Then New partner should be created
    When I act as newly created partner account
    And I assign MozyPro allocated quota to 1024 GB
    Then MozyPro resource quota should be changed
    When I change MozyPro account plan to:
      | base plan       |
      | 1 TB, $7,979.79 |
    Then Account plan should be changed
    And MozyPro new plan should be:
      | base plan                          |
      | 1 TB, $7,979.79 (current purchase) |

  @TC.17104 @Smoke
  Scenario: 17104 Add server plan option to MozyPro monthly US partner
    When I add a new MozyPro partner:
      | period | base plan    |
      | 1      | 10 GB, $9.99 |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | server plan |
      | yes         |
    Then Change plan charge summary should be:
      | Description                  | Amount  |
      | Charge for new Server Plan   | $3.99   |
    And Account plan should be changed
    And MozyPro new plan should be:
      | base plan                       | server plan |
      | 10 GB, $9.99 (current purchase) | yes         |

  @TC.17105 @Smoke
  Scenario: 17105 Add server storage add on to MozyPro monthly US partner
    When I add a new MozyPro partner:
      | period | base plan     |
      | 1      | 1 TB, $379.99 |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | storage add on |
      | 10             |
    Then Change plan charge summary should be:
      | Description                  | Amount   |
      | Charge for new 250 GB Add-on | $949.90  |
    And Account plan should be changed
    And MozyPro new plan should be:
      | base plan                        | storage add on |
      | 1 TB, $379.99 (current purchase) | 10             |

  @TC.17274 @Smoke
  Scenario: 17274 Add server plan option to MozyPro yearly UK partner
    When I add a new MozyPro partner:
      | period | base plan         | country        |
      | 12     | 500 GB, $2,089.89 | United Kingdom |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | server plan |
      | yes         |
    Then Change plan charge summary should be:
      | Description                  | Amount   |
      | Charge for new Server Plan   | $270.46  |
    And Account plan should be changed
    And MozyPro new plan should be:
      | base plan                            | server plan |
      | 500 GB, $2,089.89 (current purchase) | yes         |

  @TC.17275 @Smoke
  Scenario: 17275 Add server storage add on to MozyPro yearly UK partner
    When I add a new MozyPro partner:
      | period | base plan       | country        |
      | 12     | 1 TB, $4,179.89 | United Kingdom |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | storage add on |
      | 10             |
    Then Change plan charge summary should be:
      | Description                  | Amount     |
      | Charge for new 250 GB Add-on | $12,852.15 |
    And Account plan should be changed
    And MozyPro new plan should be:
      | base plan                          | storage add on |
      | 1 TB, $4,179.89 (current purchase) | 10             |

  @TC.17276 @Smoke
  Scenario: 17276 Add server plan option to MozyPro biennially Ireland partner
    When I add a new MozyPro partner:
      | period | base plan         | country |
      | 24     | 500 GB, $3,989.79 | Ireland |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | server plan |
      | yes         |
    Then Change plan charge summary should be:
      | Description                  | Amount   |
      | Charge for new Server Plan   | $516.34  |
    And Account plan should be changed
    And MozyPro new plan should be:
      | base plan                            | server plan |
      | 500 GB, $3,989.79 (current purchase) | yes         |

  @TC.17277 @Smoke
  Scenario: 17277 Add server storage add on to MozyPro biennially Ireland partner
    When I add a new MozyPro partner:
      | period | base plan       | country |
      | 24     | 1 TB, $7,979.79 | Ireland |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | storage add on |
      | 10             |
    Then Change plan charge summary should be:
      | Description                  | Amount     |
      | Charge for new 250 GB Add-on | $24,535.92 |
    And Account plan should be changed
    And MozyPro new plan should be:
      | base plan                          | storage add on |
      | 1 TB, $7,979.79 (current purchase) | 10             |