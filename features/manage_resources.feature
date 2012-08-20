Feature: Manage resources

  Background:
    Given I log in bus admin console as administrator

  @TC.18735 @Bug.84691 @Regression
  Scenario: 18735 Verify unallocated storage auto refreshed when allocated storage changed
    When I add a new MozyPro partner:
      | period | base plan         |
      | 12     | 500 GB, $2,089.89 |
    Then New partner should be created
    When I act as newly created partner account
    And I assign MozyPro allocated quota to 250 GB
    Then MozyPro resource general information should be:
    | total storage | unallocated storage |
    | 500 GB        | 250 GB              |