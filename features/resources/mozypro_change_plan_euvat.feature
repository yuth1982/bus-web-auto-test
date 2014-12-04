Feature: Resize Reseller Gold & Platinum Partners add-ons to 20 GB add-on

  Background:
    Given I log in bus admin console as administrator

  Scenario: 1 change plan Austria AT 20
    When I add a new MozyPro partner:
      | period | base plan | server plan | country | security | create under   |
      | 1      | 10 GB     | yes         | Austria | Standard | MozyPro France |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then Change plan charge summary should be:
      | Description                   | Amount  |
      | Credit for remainder of plans | -€13.18 |
      | Charge for upgraded plans     | €49.18  |
      |                               |         |
      | Total amount to be charged    | €36.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

   @BE
  Scenario: 2 change plan Belgium BE 21
    When I add a new MozyPro partner:
      | period | base plan | server plan | country | security | create under   | net terms |
      | 1      | 50 GB     | yes         | Belgium | HIPAA    | MozyPro France | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | server plan |
      | no          |
    Then Change plan charge message should be:
    """
    Are you sure that you want to downgrade your Mozy plan? When you return resources, they are no longer available for use and your next charge will be reduced to renew only the remaining resources.
    """
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 50 GB     | no          |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @BG
  Scenario: 3 change plan Bulgaria BG 20
    When I add a new MozyPro partner:
      | period | base plan | country  |
      | 12     | 32 TB     | Bulgaria |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan | storage add-on |
      | 1 TB      | yes         | 10             |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Charge for upgraded plans     | $12,934.55 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan | storage add-on |
      | 1 TB      | yes         | 10             |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @qa6_dependent
  Scenario: 4 change plan Croatia HR 25
    When I add a new MozyPro partner:
      | period | base plan | net terms | country | security | create under   |
      | 24     | 250 GB    | yes       | Croatia | HIPAA    | MozyPro France |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | coupon              |
      | 500 GB    | 10PERCENTOFFOUTLINE |
    Then Change plan charge summary should be:
      | Description                    | Amount     |
      | Credit for remainder of 250 GB | -€1,968.49 |
      | Charge for new 500 GB          | €3,622.26  |
      |                                |            |
      | Total amount to be charged     | €1,653.77  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 500 GB    |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

    @CY
  Scenario: 5 change plan Cyprus CY 19
    When I add a new MozyPro partner:
      | period | base plan | country | create under    |
      | 1      | 500 GB    | Cyprus  | MozyPro Germany |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 1 TB      | yes         |
    Then Change plan charge summary should be:
      | Description                    | Amount   |
      | Credit for remainder of 500 GB | -€178.49 |
      | Charge for upgraded plans      | €380.78  |
      |                                |          |
      | Total amount to be charged     | €202.29  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 1 TB      | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @qa6_dependent
  Scenario: 6 change plan Czech Republic CZ 21
    When I add a new MozyPro partner:
      | period | base plan | net terms | country        | security | create under   |
      | 12     | 1 TB      | yes       | Czech Republic | HIPAA    | MozyPro France |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan | coupon              |
      | 2 TB      | yes         | 10PERCENTOFFOUTLINE |
    Then Change plan charge summary should be:
      | Description                  | Amount     |
      | Credit for remainder of 1 TB | -€3,992.87 |
      | Charge for upgraded plans    | €7,447.86  |
      |                              |            |
      | Total amount to be charged   | €3,454.99  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 2 TB      | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @qa6_dependent
  Scenario: 7 change plan Denmark DK 25
    When I add a new MozyPro partner:
      | period | base plan | country | create under    |
      | 24     | 2 TB      | Denmark | MozyPro Germany |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | storage add-on | coupon              |
      | 4 TB      | 2              | 10PERCENTOFFOUTLINE |
    Then Change plan charge summary should be:
      | Description                  | Amount      |
      | Credit for remainder of 2 TB | -€15,224.74 |
      | Charge for upgraded plans    | €30,428.28  |
      |                              |             |
      | Total amount to be charged   | €15,203.54  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | storage add-on |
      | 4 TB      | 2              |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @qa6_dependent
  Scenario: 8 change plan Estonia EE 20
    When I add a new MozyPro partner:
      | period | base plan | country | create under    | net terms |
      | 1      | 4 TB      | Estonia | MozyPro Germany | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan | coupon              |
      | 2 TB      | yes         | 10PERCENTOFFOUTLINE |
    Then Change plan charge summary should be:
      | Description                | Amount |
      | Charge for new Server Plan | €32.99 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 2 TB      | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @FI
  Scenario: 9 change plan Finland FI 24
    When I add a new MozyPro partner:
      | period | base plan | server plan | storage add on | country | security | create under   |
      | 12     | 8 TB      | yes         | 2              | Finland | HIPAA    | MozyPro France |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan | storage add-on |
      | 12 TB     | no          | 0              |
    Then Change plan charge summary should be:
      | Description                  | Amount      |
      | Credit for remainder of 8 TB | -€30,280.53 |
      | Charge for new 12 TB         | €45,420.79  |
      |                              |             |
      | Total amount to be charged   | €15,140.26  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan | storage add-on |
      | 12 TB     | no          | 0              |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @FR
  Scenario: 10 change plan France FR 20
    When I add a new MozyPro partner:
      | period | base plan | server plan | storage add on | country | create under   |
      | 1      | 250 GB    | yes         | 3              | France  | MozyPro France |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 500 GB    |
    Then Change plan charge summary should be:
      | Description                   | Amount   |
      | Credit for remainder of plans | -€105.58 |
      | Charge for upgraded plans     | €199.18  |
      |                               |          |
      | Total amount to be charged    | €93.60   |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan | storage add-on |
      | 500 GB    | yes         | 3              |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @PL
  Scenario: 21 change plan Poland PL 23
    When I add a new MozyPro partner:
      | period | base plan | server plan | storage add on | country | create under    |
      | 1      | 28 TB     | yes         | 2              | Poland  | MozyPro Ireland |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 32 TB     |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -€9,901.32 |
      | Charge for upgraded plans     | €11,315.80 |
      |                               |            |
      | Total amount to be charged    | €1,414.48  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 32 TB     | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @PT
  Scenario: 22 change plan Portugal  PT 23
    When I add a new MozyPro partner:
      | period | base plan | server plan | storage add on | country  | create under    | net terms |
      | 12     | 24 TB     | yes         | 1              | Portugal | MozyPro Ireland | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | storage add-on |
      | 16 TB     | 0              |
    Then Change plan charge message should be:
    """
      Are you sure that you want to downgrade your Mozy plan? When you return resources, they are no longer available for use and your next charge will be reduced to renew only the remaining resources.
    """
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan | storage add-on |
      | 16 TB     | yes         | 0              |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @PO
  Scenario: 23 change plan Romania Ro 24
    When I add a new MozyPro partner:
      | period | base plan | storage add on | country | create under   |
      | 24     | 20 TB     | 7              | Romania | MozyPro France |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan | storage add-on |
      | 28 TB     | yes         | 5              |
    Then Change plan charge summary should be:
      | Description                   | Amount       |
      | Credit for remainder of 20 TB | -€144,520.70 |
      | Charge for upgraded plans     | €209,618.36  |
      |                               |              |
      | Total amount to be charged    | €65,097.66   |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan | storage add-on |
      | 28 TB     | yes         | 5              |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @SK
  Scenario: 24 change plan Slovakia SK 20
    When I add a new MozyPro partner:
      | period | base plan | storage add on | country  | create under   | net terms |
      | 1      | 16 TB     | 5              | Slovakia | MozyPro France | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 250 GB    | yes         |
    Then Change plan charge message should be:
    """
      Are you sure you want to change your Mozy plan? If you choose to continue, your account will automatically be charged for the new plan quantities for the remainder of your current subscription period.
    """
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 250 GB    | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @SI  @qa6_dependent
  Scenario: 25 change plan Slovenia SI 22
    When I add a new MozyPro partner:
      | period | base plan | server plan | country  | create under    | net terms |
      | 12     | 100 GB    | yes         | Slovenia | MozyPro Ireland | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | storage add-on | coupon              |
      | 4 TB      | 1              | 10PERCENTOFFOUTLINE |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -€549.96   |
      | Charge for upgraded plans     | €15,091.64 |
      |                               |            |
      | Total amount to be charged    | €14,541.68|
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan | storage add-on |
      | 4 TB      | yes         | 1              |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name
