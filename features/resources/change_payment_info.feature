Feature: Modify credit card information and billing contact information

  Background:
    Given I log in bus admin console as administrator

  @TC.15266
  Scenario: 15266 Verify Change Payment Information Contact Info
    When I add a new MozyPro partner:
      | period | base plan | country       | address           | city      | state abbrev | zip   | phone          |
      | 24     | 250 GB    | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Change Payment Information section from bus admin console page
    Then Payment billing information should be:
    | Billing Street Address: | Billing City: | Billing State/Province: | Billing Country: | Billing ZIP/Postal Code: | Billing Email    | Billing Phone: |
    | 3401 Hillview Ave       | Palo Alto     | CA                      | United States    | 94304                    | @new_admin_email | 1-877-486-9273 |

  @TC.15286
  Scenario: 15286 Change Payment Information With Credit Card
    When I add a new MozyEnterprise partner:
      | period | users |
      | 36     | 100   |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Change Payment Information section from bus admin console page
    And I update payment contact information to:
      | address               | phone     |
      | This is a new address | 12345678  |
    And I update credit card information to:
      | cc name     | cc number        | expire month | expire year | cvv |
      | change card | 4532355312331942 | 12           | 18          | 123 |
    And I save payment information changes
    Then Payment information should be updated
    When I log in aria admin console as administrator
    And I search aria account by newly created partner admin email
    Then Aria account billing contact should include:
      | address               | phone    | cc name     |
      | This is a new address | 12345678 | change card |
    And Aria account credit card information should be:
    | Payment Type:       | Card Number:      | Expiration Date: |
    | Credit Card (Visa)  | ************1942  | 12 / 2018        |
    When I log in bus admin console as administrator
    And I search and delete by account newly created partner company name