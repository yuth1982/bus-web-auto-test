Feature: Credit Card Type when Creating Partner

  Background:
    Given I log in bus admin console as administrator

  @TC.131842 @credit_card_type @tasks_p2 @bus
  Scenario: 131842 Add new partner using credit card of Visa
    When I add a new MozyPro partner:
      | period | base plan | cc number        | expire month | expire year | cvv |
      | 12     | 50 GB     | 4018121111111122 | 12           | 16          | 824 |
    Then New partner should be created
    And I search and delete partner account by newly created partner company name

  @TC.131842 @credit_card_type @tasks_p2 @bus
  Scenario: 131842 Add new partner using credit card of MasterCard
    When I add a new MozyPro partner:
      | period | base plan | server plan | storage add on | cc number        | expire month | expire year | cvv |
      | 24     | 1 TB      | yes         | 15             | 5111991111111121 | 12           | 17          | 404 |
    Then New partner should be created
    And I search and delete partner account by newly created partner company name

  @TC.131842 @credit_card_type @tasks_p2 @bus
  Scenario: 131842 Add new partner using credit card of American Express
    When I add a new MozyPro partner:
      | period | base plan | server plan | cc number        | expire month | expire year | cvv |
      | 1      | 100 GB    | yes         | 372478273181824  | 12           | 17          | 295 |
    Then New partner should be created
    And I search and delete partner account by newly created partner company name

  @TC.131842 @credit_card_type @tasks_p2 @bus
  Scenario: 131842 Add new partner using credit card of Discover
    When I add a new MozyEnterprise partner:
      | period | users | server add on | cc number        | expire month | expire year | cvv |
      | 36     | 99    | 40            | 6011868815065127 | 12           | 17          | 731 |
    Then New partner should be created
    And I search and delete partner account by newly created partner company name





