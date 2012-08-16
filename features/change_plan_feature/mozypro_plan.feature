Feature: Change plan

  Background:
    Given I log in bus admin console as administrator

  @TC.16485 @smoke
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
    And MozyPro current purchase should be 50 GB, $19.99

  @TC.18424 @smoke
  Scenario: 16488 MozyPro monthly US partner 1 TB moves to 250 GB plan
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
    And MozyPro current purchase should be 250 GB, $94.99

  @TC.18336 @smoke
  Scenario: 18336 MozyPro yearly UK partner 500 GB moves to 1 TB plan
    When I add a new MozyPro partner:
      | period | base plan         |
      | 1      | 500 GB, $2,089.89 |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan       |
      | 1 TB, $4,179.89 |
    Then Change plan charge summary should be:
      | Description                | Amount   |
      | Charge for new 500 GB      | $189.99  |
    And Account plan should be changed
    And MozyPro current purchase should be 1 TB, $4,179.89

  @TC.18443 @smoke
  Scenario: 18443 MozyPro monthly UK partner 500 GB moves to 250 GB plan
    When I add a new MozyPro partner:
      | period | base plan     |
      | 1      | 2 TB, $749.99 |
    Then New partner should be created
    When I act as newly created partner account
    And I assign MozyPro allocated quota to 500 GB
    Then MozyPro resource quota should be changed
    When I change MozyPro account plan to:
      | base plan        |
      | 500 GB, $189.99  |
    Then Account plan should be changed
    And MozyPro current purchase should be 500 GB, $189.99

# Show / Hide direct link   Mozy-18248:SMB 1 TB partner moves to 2 TB plan. Ireland

  @TC.18248
  Scenario: 18336 MozyPro monthly UK partner 500 GB moves to 1 TB plan
    When I add a new MozyPro partner:
      | period | base plan      |
      | 1      | 250 GB, $94.99 |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan       |
      | 500 GB, $189.99 |
    Then Change plan charge summary should be:
      | Description                     | Amount   |
      | Credit for remainder of 10 GB   | -$9.99   |
      | Charge for upgraded plans       | $189.99  |
      |                                 |          |
      | Total amount to be charged      | $180.00  |
    And Account plan should be changed
    And MozyPro current purchase should be 500 GB, $189.99

# Show / Hide direct link   Mozy-18407:SMB 2 TB partner moves to 1 TB plan. Ireland
  @TC.18443
  Scenario: 18443 MozyPro monthly UK partner 500 GB moves to 250 GB plan
    When I add a new MozyPro partner:
      | period | base plan     |
      | 1      | 2 TB, $749.99 |
    Then New partner should be created
    When I act as newly created partner account
    And I assign MozyPro allocated quota to 500 GB
    Then MozyPro resource quota should be changed
    When I change MozyPro account plan to:
      | base plan        |
      | 500 GB, $189.99  |
    Then Account plan should be changed
    And MozyPro current purchase should be 500 GB, $189.99

