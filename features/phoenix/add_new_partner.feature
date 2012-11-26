Feature: Add a new partner through phoenix

  As a business owner
  I want to create a partner through phoenix
  So that I can organize my business in a way that works for me

  Background:
    Given I am at dom selection point:

  @TC.13498 @smoke @biennial @sample
  Scenario: 13498 Add a new US biennial basic MozyPro partner
    When I add a phoenix Pro partner:
      | period | base plan | country       | server plan |
      | 24     | 100 GB    | United States | yes         |
    Then the order summary looks like:
      | Description           | Price     | Quantity | Amount    |
      | 100 GB - Biennial     | $839.79   | 1        | $839.79   |
      | Server Plan - Biennial| $272.79   | 1        | $272.79   |
      | Total Charge          | $1,112.58 |          | $1,112.58 |

  @TC.13499 @smoke @year
  Scenario: 13499 Add a new US yearly basic MozyPro partner
    When I add a phoenix Pro partner:
      | period | base plan | country       | server plan |
      | 12     | 100 GB    | United States | yes         |
    Then the billing summary looks like:
      | Description            | Price   | Quantity | Total Price |
      | 100 GB - Annually      | $439.89 | 1        | $439.89     |
      | Server Plan - Annually | $142.89 | 1        | $142.89     |
      | Total Charge           |         |          | $582.78     |

  @TC.13502 @smoke @month
  Scenario: 13502 Add a new US monthly basic MozyPro partner
    When I add a phoenix Pro partner:
      | period | base plan | country       | server plan |
      | 1      | 100 GB    | United States | yes         |
    Then the billing summary looks like:
      | Description           | Price  | Quantity | Total Price |
      | 100 GB - Monthly      | $39.99 | 1        | $39.99      |
      | Server Plan - Monthly | $12.99 | 1        | $12.99      |
      | Total Charge          |        |          | $52.98      |

  @TC.13503 @smoke @biennial @IE
  Scenario: 13503 Add a new IE biennial basic MozyPro partner
    When I add a phoenix Pro partner:
      | period | base plan | country | vat number | server plan |
      | 24     | 100 GB    | Ireland | IE9691104A | yes         |
    Then the billing summary looks like:
      | Description            | Price     | Quantity | Total Price |
      | 100 GB - Biennial      | €650.79   | 1        | €650.79     |
      | Server Plan - Biennial | €209.79   | 1        | €209.79     |
      | Subscription Price     | €860.58   |          | €860.58     |
      | VAT                    | €197.93   |          | €197.93     |
      | Total Charge           | €1,058.51 |          | €1,058.51   |

  @TC.13504 @smoke @year @IE @novat
  Scenario: 13504 Add a new IE yearly basic MozyPro partner
    When I add a phoenix Pro partner:
      | period | base plan | country | vat number | server plan |
      | 12     | 100 GB    | Ireland |            | yes         |
    Then the billing summary looks like:
      | Description            | Price   | Quantity | Total Price |
      | 100 GB - Monthly       | €340.89 | 1        | €340.89     |
      | Server Plan - Monthly  | €109.89 | 1        | €109.89     |
      | Subscription Price     | €450.78 |          | €450.78     |
      | VAT                    | €103.67 |          | €103.67     |
      | Total Charge           | €554.45 |          | €554.45     |

  @TC.13497 @smoke @month @IE
  Scenario: 13497 Add a new IE monthly basic MozyPro partner
    When I add a phoenix Pro partner:
      | period | base plan | country | vat number | server plan |
      | 1      | 100 GB    | Ireland | IE9691104A | yes         |
    Then the billing summary looks like:
      | Description            | Price  | Quantity | Total Price |
      | 100 GB - Monthly       | €30.99 | 1        | €30.99      |
      | Server Plan - Monthly  | €9.99  | 1        | €9.99       |
      | Subscription Price     | €40.98 |          | €40.98      |
      | VAT                    | €9.43  |          | €9.43       |
      | Total Charge           | €50.41 |          | €50.41      |

  @TC.13515 @smoke @year @IE
  Scenario: 13515 Add a new IE yearly basic MozyPro partner
    When I add a phoenix Pro partner:
      | period | base plan | country | vat number | server plan |
      | 12     | 100 GB    | Ireland | IE9691104A | yes         |
    Then the billing summary looks like:
      | Description            | Price   | Quantity | Total Price |
      | 100 GB - Monthly       | €340.89 | 1        | €340.89     |
      | Server Plan - Monthly  | €109.89 | 1        | €109.89     |
      | Subscription Price     | €450.78 |          | €450.78     |
      | VAT                    | €103.67 |          | €103.67     |
      | Total Charge           | €554.45 |          | €554.45     |

  @TC.13513 @smoke @biennial @UK
  Scenario: 13503 Add a new UK biennial basic MozyPro partner
    When I add a phoenix Pro partner:
      | period | base plan | country        | vat number  | server plan |
      | 24     | 100 GB    | United Kingdom | GB746075129 | yes         |
    Then the billing summary looks like:
      | Description            | Price   | Quantity | Total Price |
      | 100 GB - Biennial      | £566.79 | 1        | £566.79     |
      | Server Plan - Biennial | £188.79 | 1        | £188.79     |
      | Subscription Price     | £755.58 |          | £755.58     |
      | VAT                    | Exempt  |          | Exempt      |
      | Total Charge           | £755.58 |          | £755.58     |

  @TC.13521 @smoke @year @UK @novat
  Scenario: 13504 Add a new UK yearly basic MozyPro partner
    When I add a phoenix Pro partner:
      | period | base plan | country        | vat number | server plan |
      | 12     | 100 GB    | United Kingdom |            | yes         |
    Then the billing summary looks like:
      | Description            | Price   | Quantity | Total Price |
      | 100 GB - Annually      | £296.89 | 1        | £296.89     |
      | Server Plan - Annually | £98.89  | 1        | £98.89      |
      | Subscription Price     | £395.78 |          | £395.78     |
      | VAT                    | £91.02  |          | £91.02      |
      | Total Charge           | £486.70 |          | £486.70     |

  @TC.13507 @smoke @month @UK
  Scenario: 13497 Add a new UK monthly basic MozyPro partner
    When I add a phoenix Pro partner:
      | period | base plan | country        | vat number  | server plan |
      | 1      | 100 GB    | United Kingdom | GB746075129 | yes         |
    Then the billing summary looks like:
      | Description            | Price   | Quantity | Total Price |
      | 100 GB - Monthly       | £26.89  | 1        | £26.89      |
      | Server Plan - Monthly  | £8.99   | 1        | £8.99       |
      | Subscription Price     | £35.98  |          | £35.98      |
      | VAT                    | Exempt  |          | Exempt      |
      | Total Charge           | £35.98  |          | £35.98      |

  @TC.13510 @smoke @year @UK
  Scenario: 13515 Add a new UK yearly basic MozyPro partner
    When I add a phoenix Pro partner:
      | period | base plan | country        | vat number  | server plan |
      | 12     | 100 GB    | United Kingdom | GB746075129 | yes         |
    Then the billing summary looks like:
      | Description            | Price   | Quantity | Total Price |
      | 100 GB - Annually      | £296.89 | 1        | £296.89     |
      | Server Plan - Annually | £98.89  | 1        | £98.89      |
      | Subscription Price     | £395.78 |          | £395.78     |
      | VAT                    | Exempt  |          | Exempt      |
      | Total Charge           | £395.78 |          | £395.78     |
