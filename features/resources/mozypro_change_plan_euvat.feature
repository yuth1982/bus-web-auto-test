Feature: Mozypro customers from 28 EU countries change plan

  @TC.1 @change_plan @eu
  Scenario: TC.1 change plan Austria AT 20
    When I log in bus admin console as administrator
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

  @TC.2 @change_plan @eu
  Scenario: TC.2 change plan Belgium BE 21
    When I log in bus admin console as administrator
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

  @TC.3 @change_plan @eu
  Scenario: TC.3 change plan Bulgaria BG 20
    When I log in bus admin console as administrator
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

  @TC.4 @change_plan @eu @qa6_dependent
  Scenario: TC.4 change plan Croatia HR 25
    When I log in bus admin console as administrator
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

  @TC.5 @change_plan @eu
  Scenario: TC.5 change plan Cyprus CY 19
    When I log in bus admin console as administrator
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

  @TC.6 @change_plan @eu @qa6_dependent
  Scenario: TC.6 change plan Czech Republic CZ 21
    When I log in bus admin console as administrator
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

  @TC.7 @change_plan @eu @qa6_dependent
  Scenario: TC.7 change plan Denmark DK 25
    When I log in bus admin console as administrator
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

  @TC.8 @change_plan @eu @qa6_dependent
  Scenario: TC.8 change plan Estonia EE 20
    When I log in bus admin console as administrator
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

  @TC.9 @change_plan @eu
  Scenario: TC.9 change plan Finland FI 24
    When I log in bus admin console as administrator
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

  @TC.10 @change_plan @eu
  Scenario: TC.10 change plan France FR 20
    When I log in bus admin console as administrator
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

  @TC.11 @change_plan @eu
  Scenario: TC.11 change plan Germany DE 19
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | country  | create under    |
      | 24     | 500 GB    | Germany  | MozyPro Germany |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 8 TB      | yes         |
    Then Change plan charge summary should be:
      | Description                    | Amount     |
      | Credit for remainder of 500 GB | -€3,748.25 |
      | Charge for upgraded plans      | €57,476.00 |
      |                                |            |
      | Total amount to be charged     | €53,727.75 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 8 TB      | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.12 @change_plan @eu
  Scenario: TC.12 change plan for EL MozyPro partner which signed up in phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | server plan | country | billing country |
      | 1      | 10 GB     | yes         | Greece  | Greece          |
    Then the order summary looks like:
      | Description           | Price  | Quantity | Amount |
      | 10 GB - Monthly       | €7.99  | 1        | €7.99  |
      | Server Plan - Monthly | €2.99  | 1        |	€2.99  |
      | Subscription Price    | €10.98 |          | €10.98 |
      | VAT                   | €2.53  |          | €2.53  |
      | Total Charge          | €13.51 |          | €13.51 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    When I act as partner by:
       | email        |
       | @admin_email |
     And I change MozyPro account plan to:
       | base plan | server plan |
       | 24 TB     | no          |
     Then Change plan charge summary should be:
       | Description                   | Amount    |
       | Credit for remainder of 10 GB | -€9.83    |
       | Charge for new 24 TB          | €8,191.73 |
       |                               |           |
       | Total amount to be charged    | €8,181.90 |
     And the MozyPro account plan should be changed
     And MozyPro new plan should be:
       | base plan | server plan |
       | 24 TB     | no          |
     When I stop masquerading
     Then I search and delete partner account by newly created partner company name

  @TC.13 @change_plan @eu
  Scenario: TC.13 change plan for HU MozyPro partner which signed up in phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | server plan | country | billing country |
      | 12     | 50 GB     | yes         | Hungary | Hungary         |
    Then the order summary looks like:
      | Description          | Price   | Quantity | Amount  |
      | 50 GB - Annual       | €175.89 | 1        | €175.89 |
      | Server Plan - Annual | €60.39  | 1        |	€60.39  |
      | Subscription Price   | €236.28 |          | €236.28 |
      | VAT                  | €63.80  |          | €63.80  |
      | Total Charge         | €300.08 |          | €300.08 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email        |
      | @admin_email |
    And I change MozyPro account plan to:
      | base plan | storage add-on |
      | 28 TB     | 10             |
    Then Change plan charge summary should be:
      | Description                   | Amount      |
      | Credit for remainder of plans | -€300.08    |
      | Charge for upgraded plans     | €122,932.64 |
      |                               |             |
      | Total amount to be charged    | €122,632.56 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 28 TB     | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.14 @change_plan @eu @qa6_dependent
  Scenario: TC.14 change plan for IE 23 MozyPro partner which signed up in phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | coupon              | country | billing country |
      | 24     | 100 GB    | 10PERCENTOFFOUTLINE | Ireland | Ireland         |
    Then the order summary looks like:
      | Description        | Price    | Quantity | Amount   |
      | 100 GB - Biennial  | €650.79  | 1        | €650.79  |
      | Subscription Price | €650.79  |          | €650.79  |
      | Discounts          | - €65.08 |          | - €65.08 |
      | Subtotal           | €585.71  |          | €585.71  |
      | VAT                | €149.68  |          | €149.68  |
      | Total Charge       | €735.39  |          | €735.39  |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email        |
      | @admin_email |
    And I change MozyPro account plan to:
      | base plan | server plan | coupon              |
      | 32 TB     | yes         | 10PERCENTOFFOUTLINE |
    Then Change plan charge summary should be:
      | Description                    | Amount      |
      | Credit for remainder of 100 GB | -€735.39    |
      | Charge for upgraded plans      | €218,312.20 |
      |                                |             |
      | Total amount to be charged     | €217,576.81 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 32 TB     | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.15 @change_plan @eu
  Scenario: TC.15 change plan for IT MozyPro partner which signed up in phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country |
      | 1      | 250 GB    | Italy   | Italy           |
    Then the order summary looks like:
      | Description        | Price  | Quantity | Amount |
      | 250 GB - Monthly   | €74.99 | 1        | €74.99 |
      | Subscription Price | €74.99 |          | €74.99 |
      | VAT                | €16.50 |          | €16.50 |
      | Total Charge       | €91.49 |          | €91.49 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email        |
      | @admin_email |
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 100 GB    | yes         |
    Then Change plan charge summary should be:
      | Description                | Amount |
      | Charge for new Server Plan | €12.19 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.16 @change_plan @eu
  Scenario: TC.16 change plan for Latvia LV MozyPro partner which signed up in phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | server plan | country | billing country |
      | 12     | 500 GB    | yes         | Latvia  | Latvia          |
    Then the order summary looks like:
      | Description          | Price     | Quantity | Amount    |
      | 500 GB - Annual      | €1,649.89 | 1        | €1,649.89 |
      | Server Plan - Annual | €175.89   | 1        | €175.89   |
      | Subscription Price   | €1,825.78 |          | €1,825.78 |
      | VAT                  | €383.42   |          | €383.42   |
      | Total Charge         | €2,209.20 |          | €2,209.20 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email        |
      | @admin_email |
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 250 GB    | no          |
    Then Change plan charge message should be:
    """
      Are you sure that you want to downgrade your Mozy plan? When you return resources, they are no longer available for use and your next charge will be reduced to renew only the remaining resources.
    """
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 250 GB    | no          |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.17 @change_plan @eu
  Scenario: TC.17 change plan for LT 21 MozyPro partner which signed up in phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | server plan | country   | billing country |
      | 24     | 1 TB      | yes         | Lithuania | Lithuania       |
    Then the order summary looks like:
      | Description            | Price     | Quantity | Amount    |
      | 1 TB - Biennial        | €6,299.79 | 1        | €6,299.79 |
      | Server Plan - Biennial | €419.79   | 1        | €419.79   |
      | Subscription Price     | €6,719.58 |          | €6,719.58 |
      | VAT                    | €1,411.12 |          | €1,411.12 |
      | Total Charge           | €8,130.70 |          | €8,130.70 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email        |
      | @admin_email |
    And I change MozyPro account plan to:
      | base plan | storage add-on |
      | 16 TB     | 2              |
    Then Change plan charge summary should be:
      | Description                    | Amount      |
      | Credit for remainder of plans  | -€8,130.70  |
      | Charge for upgraded plans      | €120,694.95 |
      |                                |             |
      | Total amount to be charged     | €112,564.25 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 16 TB     | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.18 @change_plan @eu  @qa6_dependent
  Scenario: TC.18 change plan for Luxembourg LU 15 MozyPro partner which signed up in phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country    | billing country |
      | 1      | 1 To      | Luxembourg | Luxembourg      |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 1 To - Mensuel          | 299,99€ | 1        | 299,99€ |
      | Prix d'abonnement       | 299,99€ |          | 299,99€ |
      | TVA                     | 45,00€  |          | 45,00€  |
      | Montant total des frais | 344,99€ |          | 344,99€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email        |
      | @admin_email |
    And I change MozyPro account plan to:
      | base plan | server plan | coupon              |
      | 100 GB    | yes         | 10PERCENTOFFOUTLINE |
    Then Change plan charge summary should be:
      | Description                | Amount |
      | Charge for new Server Plan | €10.49 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19 @change_plan @eu
  Scenario: TC.19 change plan for Malta LT 21 MozyPro partner which signed up in phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | server plan | country | billing country |
      | 12     | 250 GB    | yes         | Malta   | Malta           |
    Then the order summary looks like:
      | Description          | Price     | Quantity | Amount    |
      | 250 GB - Annual      | €824.89   | 1        | €824.89   |
      | Server Plan - Annual | €142.89   | 1        | €142.89   |
      | Subscription Price   | €967.78   |          | €967.78   |
      | VAT                  | €174.20   |          | €174.20   |
      | Total Charge         | €1,141.98 |          | €1,141.98 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email        |
      | @admin_email |
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
      | 250 G     | no          |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20 @change_plan @eu
  Scenario: 20 change plan for Netherlands 21 MozyPro partner which signed up in phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | server plan | country     | billing country |
      | 24     | 500 GB    | yes         | Netherlands | Netherlands     |
    Then the order summary looks like:
      | Description            | Price     | Quantity | Amount    |
      | 500 GB - Biennial      | €3,149.79 | 1        | €3,149.79 |
      | Server Plan - Biennial | €335.79   | 1        | €335.79   |
      | Subscription Price     | €3,485.58 |          | €3,485.58 |
      | VAT                    | €731.98   |          | €731.98   |
      | Total Charge           | €4,217.56 |          | €4,217.56 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email        |
      | @admin_email |
    And I change MozyPro account plan to:
      | base plan | server plan | storage add-on |
      | 20 TB     | no          | 10             |
    Then Change plan charge summary should be:
      | Description                    | Amount      |
      | Credit for remainder of 500 GB | -€3,811.25  |
      | Charge for upgraded plans      | €160,079.19 |
      |                                |             |
      | Total amount to be charged     | €156,267.94 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 20 TB     | no          |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.21 @change_plan @eu
  Scenario: TC.21 change plan Poland PL 23
    When I log in bus admin console as administrator
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

  @TC.22 @change_plan @eu
  Scenario: TC.22 change plan Portugal PT 23
    When I log in bus admin console as administrator
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

  @TC.23 @change_plan @eu
  Scenario: TC.23 change plan Romania Ro 24
    When I log in bus admin console as administrator
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

  @TC.24 @change_plan @eu
  Scenario: TC.24 change plan Slovakia SK 20
    When I log in bus admin console as administrator
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

  @TC.25 @change_plan @eu  @qa6_dependent
  Scenario: TC.25 change plan Slovenia SI 22
    When I log in bus admin console as administrator
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
      | Total amount to be charged    | €14,541.68 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan | storage add-on |
      | 4 TB      | yes         | 1              |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.26 @change_plan @eu
  Scenario: TC.26 change plan Spain ES 21
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | server plan | storage add on | country | create under    |
      | 24     | 16 TB     | yes         | 10             | Spain   | MozyPro Germany |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | storage add-on |
      | 20 TB     | 15             |
    Then Change plan charge summary should be:
      | Description                   | Amount       |
      | Credit for remainder of plans | -€116,883.96 |
      | Charge for upgraded plans     | €155,632.44  |
      |                               |              |
      | Total amount to be charged    | €38,748.48   |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan | storage add-on |
      | 20 TB     | yes         | 15             |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.27 @change_plan @eu
  Scenario: TC.27 change plan Sween SE 25
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | server plan | storage add on | country | create under | net terms |
      | 1      | 20 TB     | yes         | 8              | Sweden  | MozyPro UK   | yes       |
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
      | 20 TB     | no          |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.28 @change_plan @eu
  Scenario:TC.28 change plan United Kingdom UK 20
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | server plan | country        | create under |
      | 12     | 100 GB    | yes         | United Kingdom | MozyPro UK   |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 500 GB    |
    Then Change plan charge summary should be:
      | Description                   | Amount    |
      | Credit for remainder of plans | -£474.94  |
      | Charge for upgraded plans     | £1,834.54 |
      |                               |           |
      | Total amount to be charged    | £1,359.60 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name