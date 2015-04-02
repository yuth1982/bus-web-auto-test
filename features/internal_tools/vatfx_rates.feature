Feature: Manage VAT/FX Rates in Internal Tools in Admin Console

  Background:
    Given I log in bus admin console as administrator

  Scenario: Add a VAT Rate successfully
     When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Austria  | 0.2    | next week      |
     Then New VAT Rate should be created
     Then I delete newly created VAT Rate and cancel this operation
     Then I delete newly created VAT Rate successfully

  Scenario: Add a VAT rate record with a rate have more decimal places
    When I add a VAT Rate:
      | Country  | Rate        | Effective Date |
      | Spain    | 0.2134      | tomorrow       |
    Then New VAT Rate should be created
    Then I delete newly created VAT Rate successfully

  Scenario: Add a VAT Rate with existing country name and different effective date
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Belgium  | 1      | next week      |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Belgium  | 1      | tomorrow       |
    Then New VAT Rate should be created
    Then Successfully delete VAT Rate(s):
      | Country  | Rate   | Effective Date |
      | Belgium  | 1      | next week      |
      | Belgium  | 1      | tomorrow       |

  Scenario: Add a VAT Rate with existing country name and same effective date
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Bulgaria | 0.2    | next week      |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Bulgaria | 0.2    | next week      |
    Then VAT Rate with existing country and same effective date shouldn't be created
    Then I delete newly created VAT Rate successfully

  Scenario: Add a VAT Rate without Country
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      |          | 0.23   | today          |
    Then VAT Rate without Country shouldn't be created

  Scenario: Add a VAT Rate without without Vat Rate
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | France   |        | today          |
    Then VAT Rate without Vat Rate shouldn't be created

  Scenario: Add a VAT Rate without Effective Date
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Croatia  | 0.25   |                |
    Then VAT Rate with invalid format of Effective Date shouldn't be created

  Scenario: Add a VAT record with a vat rate greater than 1
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Cyprus   | 1.01   | tomorrow       |
    Then VAT Rate with a Vat Rate greater than 1 shouldn't be created

  Scenario: Add a VAT Rate with a invalid format of effective date(invalid month,invalid date)
    When I add a VAT Rate:
      | Country          | Rate   | Effective Date |
      | Czech Republic   | 0.21   | 2015/13/13     |
    Then VAT Rate with invalid format of Effective Date shouldn't be created
    When I add a VAT Rate:
      | Country          | Rate   | Effective Date |
      | Czech Republic   | 0.21   | 2015/02/29     |
    Then VAT Rate with invalid format of Effective Date shouldn't be created

  Scenario: Add a VAT record with invalid vat rate=0 and -1
    When I add a VAT Rate:
      | Country          | Rate   | Effective Date |
      | Denmark          | 0      | tomorrow       |
    Then VAT Rate with invalid Vat Rate shouldn't be created
    When I add a VAT Rate:
      | Country          | Rate   | Effective Date |
      | Denmark          | -1     | tomorrow       |
    Then VAT Rate with invalid Vat Rate shouldn't be created
    When I add a VAT Rate:
      | Country          | Rate   | Effective Date |
      | Denmark          | abc    | tomorrow       |
    Then VAT Rate with invalid Vat Rate shouldn't be created

  Scenario: check VAT configure capability
    Then Manage VAT/FX Rates should be visible
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I act as newly created partner
    Then Manage VAT/FX Rates should be invisible
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  Scenario: initialize all VAT rates
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Austria  | 0.2    | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Belgium  | 0.21   | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Bulgaria | 0.2    | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Croatia  | 0.25   | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Cyprus   | 0.19   | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country         | Rate   | Effective Date |
      | Czech Republic  | 0.21   | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Denmark  | 0.25   | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Estonia  | 0.2    | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Finland  | 0.24   | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | France   | 0.2    | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Germany  | 0.19   | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Greece   | 0.23   | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Hungary  | 0.27   | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Ireland  | 0.23   | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Italy    | 0.22   | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Latvia   | 0.21   | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country    | Rate   | Effective Date |
      | Lithuania  | 0.21   | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country     | Rate    | Effective Date |
      | Luxembourg  | 0.15    | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Malta    | 0.18   | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country      | Rate   | Effective Date |
      | Netherlands  | 0.21   | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Poland   | 0.23   | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country   | Rate    | Effective Date |
      | Portugal  | 0.23    | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Romania  | 0.24   | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country   | Rate   | Effective Date |
      | Slovakia  | 0.2    | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country   | Rate   | Effective Date |
      | Slovenia  | 0.22   | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country   | Rate   | Effective Date |
      | Spain     | 0.21   | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country   | Rate   | Effective Date |
      | Sweden    | 0.25   | today          |
    Then New VAT Rate should be created
    When I add a VAT Rate:
      | Country            | Rate   | Effective Date |
      | United Kingdom     | 0.2    | today          |
    Then New VAT Rate should be created

  Scenario: Add a FX Rate successfully
    When I add a FX Rate:
      | From Currency | To Currency  | Rate | Effective Date  |
      | EUR           | USD          | 10.1 | tomorrow        |
    Then New FX Rate should be created
    Then I delete newly created FX Rate and cancel this operation
    Then I delete newly created FX Rate successfully

  Scenario: Add a FX rate with a rate have six decimal places
    When I add a FX Rate:
      | From Currency | To Currency  | Rate     | Effective Date  |
      | USD           | EUR          | 0.802512 | last week       |
    Then New FX Rate should be created
    Then I delete newly created FX Rate successfully

  Scenario: Add a FX rate record existing From/To Currency + different effective date
    When I add a FX Rate:
      | From Currency | To Currency  | Rate | Effective Date  |
      | GBP           | USD          | 6.9  | tomorrow        |
    Then New FX Rate should be created
    When I add a FX Rate:
      | From Currency | To Currency  | Rate | Effective Date  |
      | GBP           | USD          | 20.3 | next month      |
    Then New FX Rate should be created
    Then Successfully delete FX Rate(s):
      | From Currency | To Currency  | Rate | Effective Date  |
      | GBP           | USD          | 6.9  | tomorrow        |
      | GBP           | USD          | 20.3 | next month      |

  Scenario: Add a FX rate record with existing From/To Currency + same effective date
    When I add a FX Rate:
      | From Currency | To Currency  | Rate | Effective Date  |
      | USD           | EUR          | 0.8  | today           |
    Then New FX Rate should be created
    When I add a FX Rate:
      | From Currency | To Currency  | Rate | Effective Date  |
      | USD           | EUR          | 0.8  | today           |
    Then FX Rate with existing From/To Currency and same effective date shouldn't be created
    Then I delete newly created FX Rate successfully

  Scenario: Add a FX rate record with the same From Currency and To Currency
    When I add a FX Rate:
      | From Currency | To Currency  | Rate | Effective Date  |
      | USD           | USD          | 10.0 | today           |
    Then FX Rate with the same From Currency and To Currency shouldn't be created

  Scenario: Add a FX rate record without Rate value
    When I add a FX Rate:
      | From Currency | To Currency  | Rate | Effective Date  |
      | EUR           | USD          |      | today           |
    Then FX Rate without FX Rate shouldn't be created

  Scenario: Add a FX rate record without Effective Date
    When I add a FX Rate:
      | From Currency | To Currency  | Rate | Effective Date  |
      | USD           | EUR          | 12.3 |                 |
    Then FX Rate with invalid format of Effective Date shouldn't be created

  Scenario: Add a FX rate record without From/to Currency
    When I add a FX Rate:
      | From Currency | To Currency  | Rate | Effective Date  |
      |               | EUR          | 14.9 | today           |
    Then FX Rate without From Currency shouldn't be created
    When I add a FX Rate:
      | From Currency | To Currency  | Rate | Effective Date  |
      | EUR           |              | 14.9 | today           |
    Then FX Rate without To Currency shouldn't be created

  Scenario: Add a FX rate record with invalid format of Rate(0,-1,abc)
    When I add a FX Rate:
      | From Currency | To Currency  | Rate | Effective Date  |
      | USD           | GBP          | 0    | next week       |
    Then FX Rate with invalid FX Rate shouldn't be created
    When I add a FX Rate:
      | From Currency | To Currency  | Rate | Effective Date  |
      | USD           | GBP          | -1   | next week       |
    Then FX Rate with invalid FX Rate shouldn't be created
    When I add a FX Rate:
      | From Currency | To Currency  | Rate   | Effective Date  |
      | USD           | GBP          | sdf    | next week       |
    Then FX Rate with invalid FX Rate shouldn't be created

  Scenario: Add a VAT record with a invalid effective date(invalid month,invalid date)
    When I add a FX Rate:
      | From Currency | To Currency  | Rate     | Effective Date  |
      | GBP           | USD          | 17.11    | 2015/13/13      |
    Then FX Rate with invalid format of Effective Date shouldn't be created
    When I add a FX Rate:
      | From Currency | To Currency  | Rate    | Effective Date  |
      | GBP           | USD          | 17.11   | 2015/02/29      |
    Then FX Rate with invalid format of Effective Date shouldn't be created


