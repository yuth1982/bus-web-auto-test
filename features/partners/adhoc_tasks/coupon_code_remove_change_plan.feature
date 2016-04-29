Feature: Requirement #143134 Aria coupon code remove: change period and change plan

  Background:
    Given I log in bus admin console as administrator

  @TC.143134_41 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan monthly USD 10 GB monthly -> 250 GB monthly
    When I add a new MozyPro partner:
      | company name                              | period | base plan | country       |
      | DONOT EDIT MozyPro 10 GB Plan monthly USD 10 GB monthly -> 250 GB monthly | 1      | 10 GB     | United States |
    Then Sub-total before taxes or discounts should be $9.99
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | $9.99      | $9.99       |
      | Pre-tax Subtotal  |          |            | $9.99       |
      | Total Charges     |          |            | $9.99       |
    And New partner should be created
    And New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then Change plan charge summary should be:
      | Description                    | Amount  |
      | Credit for remainder of 10 GB  | -$9.99  |
      | Charge for new 250 GB          | $94.99  |
      |                                |         |
      | Total amount to be charged     | $85.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 250 GB    |

  @TC.143134_42 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan monthly USD 10 GB monthly to 250 gb monthly
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | country       | coupon      |
      | DONOT EDIT MozyPro 10 GB Plan monthly USD 10 GB monthly to 250 gb monthly | 1      | 10 GB     | United States | Nonprofit10 |
    Then Sub-total before taxes or discounts should be $9.99
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | $9.99      | $9.99       |
      | Discounts Applied |          |            | -$1.00      |
      | Pre-tax Subtotal  |          |            | $8.99       |
      | Total Charges     |          |            | $8.99       |
    And New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then Change plan charge summary should be:
      | Description                    | Amount  |
      | Credit for remainder of 10 GB  | -$8.99  |
      | Charge for new 250 GB          | $85.49  |
      |                                |         |
      | Total amount to be charged     | $76.50  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 250 GB    |

  @TC.143134_43 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan yearly Ireland 10 gb yearly to 250 gb yearly
    When I add a new MozyPro partner:
      | company name                                        | period | base plan | server plan | create under    | country | coupon      | cc number        |
      | DONOT MozyPro 10 GB Plan yearly Ireland to 250 gb yearly | 12     | 10 GB     | yes         | MozyPro Ireland | Ireland | Nonprofit10 | 4319402211111113 |
    Then Sub-total before taxes or discounts should be €120.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | €87.89     | €87.89      |
      | Server Plan       | 1        | €32.89     | €32.89      |
      | Discounts Applied |          |            | -€12.08     |
      | Pre-tax Subtotal  |          |            | €108.70     |
      | Taxes             |          |            | €25.00      |
      | Total Charges     |          |            | €133.70     |
    And New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then Change plan charge summary should be:
      | Description                   | Amount   |
      | Credit for remainder of plans | -€133.70 |
      | Charge for upgraded plans     | €861.01  |
      |                               |          |
      | Total amount to be charged    | €727.31  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 250 GB    |

  @TC.143134_44 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan yearly GBP 10 GB biennially-> 250 GB biennially
    When I add a new MozyPro partner:
      | company name                                 | period | base plan | create under | country        | cc number        |
      | DONOT EDIT MozyPro 10 GB Plan yearly GBP 10 GB biennially-> 250 GB biennially | 24     | 10 GB     | MozyPro UK   | United Kingdom | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £146.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | £146.79    | £146.79     |
      | Pre-tax Subtotal  |          |            | £146.79     |
      | Taxes             |          |            | £29.36      |
      | Total Charges     |          |            | £176.15     |
    And New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then Change plan charge summary should be:
      | Description                    | Amount    |
      | Credit for remainder of 10 GB  | -£176.15  |
      | Charge for new 250 GB          | £1,097.75 |
      |                                |           |
      | Total amount to be charged     | $921.6    |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 250 GB    |

  @TC.143134_46 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan yearly USD 250 gb yearly to 4 tb yearly
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | country       | coupon      |
      | DONOT EDIT MozyPro 250 GB Plan yearly USD to 4 tb yearly | 12     | 250 GB    | United States | Nonprofit10 |
    Then Sub-total before taxes or discounts should be $729.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $729.89    | $729.89     |
      | Discounts Applied |          |            | -$72.99     |
      | Pre-tax Subtotal  |          |            | $656.90     |
      | Total Charges     |          |            | $656.90     |
    And New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 4 TB      |
    Then Change plan charge summary should be:
      | Description                    | Amount    |
      | Credit for remainder of 250 GB | -$656.90  |
      | Charge for new 4 TB            | $9,980.90 |
      |                                |           |
      | Total amount to be charged     | $9,324.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 4 TB      |

  @TC.143134_47 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan Biennially EUR Germany 250 GB Biennially to 8 tb Biennially
    When I add a new MozyPro partner:
      | company name                                              | period | base plan | server plan | create under    | country | cc number        | coupon                        |
      | DONOT EDIT MozyPro 250 GB Plan Biennially EUR Germany 250 GB Biennially to 8 tb Biennially | 24     | 250 GB    | yes         | MozyPro Germany | Germany | 4188181111111112 | 100pctOffInternalTestCustomer |
    Then Sub-total before taxes or discounts should be €1,483.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €1,272.79  | €1,272.79   |
      | Server Plan       | 1        | €210.79    | €210.79     |
      | Total Charges     |          |            | €0.00       |
    And New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 8 TB      |
    Then Change plan charge summary should be:
      | Description                   | Amount |
      | Charge for upgraded plans     | €0.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 8 TB      |

  @TC.143134_49 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan yearly GBP VAT 500 GB yearly -> 8 TB yearly
    When I add a new MozyPro partner:
      | company name                                      | period | base plan | server plan | create under | country        | vat number  | cc number        |
      | DONOT EDIT MozyPro 500 GB Plan yearly GBP 500 GB yearly -> 8 TB yearly | 12     | 500 GB    | yes         | MozyPro UK   | United Kingdom | GB117223643 | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £1,056.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | £954.89    | £954.89     |
      | Server Plan       | 1        | £101.89    | £101.89     |
      | Pre-tax Subtotal  |          |            | £1,056.78   |
      | Total Charges     |          |            | £1,056.78   |
    And New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 8 TB      |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -£1,056.78 |
      | Charge for upgraded plans     | £20,811.56 |
      |                               |            |
      | Total amount to be charged    | £19 754.78 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 8 TB      |

  @TC.143134_410 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan Biennially USD new
    When I add a new MozyPro partner:
      | company name                                      | period | base plan | country       |
      | DONOT EDIT MozyPro 500 GB Plan Biennially USD new | 24     | 500 GB    | United States |
    Then Sub-total before taxes or discounts should be $2,789.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | $2,789.79  | $2,789.79   |
      | Pre-tax Subtotal  |          |            | $2,789.79   |
      | Total Charges     |          |            | $2,789.79   |
    And New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 2 TB      |
    Then Change plan charge summary should be:
      | Description                    | Amount     |
      | Credit for remainder of 500 GB | -$2,789.79 |
      | Charge for new 2 TB            | $11,019.79 |
      |                                |            |
      | Total amount to be charged     | $8,230.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 2 TB      |

  @TC.143134_501 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan yearly Ireland 10 gb yearly to 250 gb yearly
    When I add a new MozyPro partner:
      | company name                                | period | base plan | server plan | create under    | country | coupon      | cc number        |
      | DONOT MozyPro 10 gb yearly to 250 gb yearly | 12     | 10 GB     | yes         | MozyPro Ireland | Ireland | Nonprofit10 | 4319402211111113 |
    Then Sub-total before taxes or discounts should be €120.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | €87.89     | €87.89      |
      | Server Plan       | 1        | €32.89     | €32.89      |
      | Discounts Applied |          |            | -€12.08     |
      | Pre-tax Subtotal  |          |            | €108.70     |
      | Taxes             |          |            | €25.00      |
      | Total Charges     |          |            | €133.70     |
    And New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 250 GB    | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount   |
      | Credit for remainder of plans | -€133.70 |
      | Charge for upgraded plans     | €861.01  |
      |                               |          |
      | Total amount to be charged    | €727.31  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 250 GB    | Yes         |

  @TC.143134_502 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan yearly USD 10 gb yearly to 500 gb yearly
    When I add a new MozyPro partner:
      | company name                                         | period | base plan | country       | coupon      |
      | DONOT EDIT MozyPro USD 10 gb yearly to 500 gb yearly | 12     | 10 GB     | United States | Nonprofit10 |
    Then Sub-total before taxes or discounts should be $109.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | $109.89    | $109.89     |
      | Discounts Applied |          |            | -$10.99     |
      | Pre-tax Subtotal  |          |            | $98.90      |
      | Total Charges     |          |            | $98.90      |
    And New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 500 GB    |
    Then Change plan charge summary should be:
      | Description                   | Amount    |
      | Credit for remainder of 10 GB | -$98.90   |
      | Charge for new 500 GB         | $1,313.90 |
      |                               |           |
      | Total amount to be charged    | $1,215.00 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 500 GB    |

  @TC.143134_503 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan yearly USD 10 gb yearly to 1 tb yearly
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | create under | country        | coupon      | cc number        |
      | DONOT EDIT MozyPro USD 10 gb yearly to 1 tb yearly | 12     | 10 GB     | MozyPro UK   | United Kingdom | Nonprofit10 | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £76.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | £76.89     | £76.89      |
      | Discounts Applied |          |            | -£7.69      |
      | Pre-tax Subtotal  |          |            | £69.20      |
      | Taxes             |          |            | £13.84      |
      | Total Charges     |          |            | £83.04      |
    And New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan | storage add-on |
      | 1 TB      | Yes         | 1              |
    Then Change plan charge summary should be:
      | Description                   | Amount    |
      | Credit for remainder of 10 GB | -£83.04   |
      | Charge for upgraded plans     | £2,989.08 |
      |                               |           |
      | Total amount to be charged    | £2,906.04 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan | storage add-on |
      | 1 TB      | Yes         | 1              |

  @TC.143134_504 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan yearly Ireland 10 gb yearly to 2 tb yearly
    When I add a new MozyPro partner:
      | company name                              | period | base plan | create under   | country | coupon      | cc number        |
      | DONOT MozyPro 10 gb yearly to 2 tb yearly | 12     | 10 GB     | MozyPro France | France  | Nonprofit10 | 4485393141463880 |
    Then Sub-total before taxes or discounts should be €87.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | €87.89     | €87.89      |
      | Discounts Applied |          |            | -€8.79      |
      | Pre-tax Subtotal  |          |            | €79.10      |
      | Taxes             |          |            | €15.82      |
      | Total Charges     |          |            | €94.92      |
    And New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | storage add-on |
      | 2 TB      | 2              |
    Then Change plan charge summary should be:
      | Description                   | Amount    |
      | Credit for remainder of plans | -€94.92   |
      | Charge for upgraded plans     | €7,447.32 |
      |                               |           |
      | Total amount to be charged    | €7,352.40 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | storage add-on |
      | 2 TB      | 2              |

  @TC.143134_505 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan yearly Ireland 10 gb yearly to 4 tb yearly
    When I add a new MozyPro partner:
      | company name                              | period | base plan | create under    | country | coupon      | cc number        | vat number  |
      | DONOT MozyPro 10 gb yearly to 4 tb yearly | 12     | 10 GB     | MozyPro Germany | Germany | Nonprofit10 | 4485393141463880 | DE812321109 |
    Then Sub-total before taxes or discounts should be €87.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | €87.89     | €87.89      |
      | Discounts Applied |          |            | -€8.79      |
      | Pre-tax Subtotal  |          |            | €79.10      |
      | Total Charges     |          |            | €79.10      |
    And New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 4 TB      | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount    |
      | Credit for remainder of plans | -€79.10   |
      | Charge for upgraded plans     | €9,386.80 |
      |                               |           |
      | Total amount to be charged    | €9,307.70  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 4 TB      | Yes         |
