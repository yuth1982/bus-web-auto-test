Feature: Phoenix regression Test

  Background:
    Given I am at dom selection point:

  @TC.2347
  Scenario: 2347 Create a new Mozypro partner part1(mozy.com)
    When I add a phoenix Pro partner:
      | period | base plan | country       | server plan |
      | 24     | 100 GB    | United States | yes         |
    Then the order summary looks like:
      | Description           | Price     | Quantity | Amount    |
      | 100 GB - Biennial     | $839.79   | 1        | $839.79   |
      | Server Plan - Biennial| $272.79   | 1        | $272.79   |
      | Total Charge          | $1,112.58 |          | $1,112.58 |
    And the partner is successfully added.
    When I log in bus admin console as administrator
    And I view partner details by @partner_name
    Then Partner contact information should be:
      | Contact Address: | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: |
      | @address         | @city         | @state         | @zip_code                | @country         |
    Then I delete partner account

  @TC.2356
  Scenario: 2356 Create a new MozyPro partner part3 (BUS)
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And Partner contact information should be:
      | Contact Address: | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: |
      | @address         | @city         | @state         | @zip_code                | @country         |
    Then I delete partner account

  @TC.2357 @fail
  Scenario: 2357 Verify that the United States is the default country (MozyPro)
    When I add a phoenix Pro partner to the billing page:
      | period | base plan | country       | server plan |
      | 24     | 100 GB    | United States | yes         |
    Then the default country is United States in the pro billing page

  @TC.2359 @fail
  Scenario: 2359 Verify that the United States is the default country (MozyHome)
    When I add a phoenix Home user to the billing page:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the default country is United States in the home billing page

  @TC.2360 @fail
  Scenario: 2360 Verify that the United States is the default country (BUS)
    When I log in bus admin console as administrator
    And I navigate to Add New Partner section from bus admin console page
    Then the default billing country is United States in add new partner section

  @TC.2349 @partly_correct
  Scenario: 2349 Create a new MozyHome user
    When I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          | $5.99 |          | $5.99  |
    Then the user is successfully added
    When I log in bus admin console as administrator
    And I view MozyHome user details by @user_name
    Then MozyHome user details should be:
      | Country: |
      | @country |

  @TC.2350
  Scenario: 2350 Edit an existing Mozypro partner as an admin
    When I add a phoenix Pro partner:
      | period | base plan | country       | server plan |
      | 24     | 100 GB    | United States | yes         |
    Then the order summary looks like:
      | Description           | Price     | Quantity | Amount    |
      | 100 GB - Biennial     | $839.79   | 1        | $839.79   |
      | Server Plan - Biennial| $272.79   | 1        | $272.79   |
      | Total Charge          | $1,112.58 |          | $1,112.58 |
    And the partner is successfully added.
    When I log in bus admin console as administrator
    And I view partner details by @partner_name
    Then Partner contact information should be:
      | Contact Address: | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: |
      | @address         | @city         | @state         | @zip_code                | @country         |
    When I change the partner contact information to:
      | Contact Address: | Contact Country: | Contact City: | Contact ZIP/Postal Code: | Contact State: |
      | address          | Canada           | city          | 123456                   | AB             |
    Then Partner contact information is changed
    And Partner contact information should be:
      | Contact Address: | Contact Country: | Contact City: | Contact ZIP/Postal Code: | Contact State: |
      | address          | Canada           | city          | 123456                   | AB             |

  @TC.2351
  Scenario: 2351 Edit an existing MozyHome user as an admin
    When I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          | $5.99 |          | $5.99  |
    Then the user is successfully added
    When I log in bus admin console as administrator
    And I view MozyHome user details by @user_name
    Then MozyHome user details should be:
      | Country: |
      | @country |

  @TC.2354 @partly_correct
  Scenario: 2354 Edit an existing MozyHome user as a user
    When I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          | $5.99 |          | $5.99  |
    Then the user is successfully added
    When I log in bus admin console as administrator
    And I view MozyHome user details by @user_name
    When I verify the user
    Then The user is verified
    When I Log in as the user
    Then I will see the account page
    When I navigate to My Profile section in Phoenix
    And I change my profile to:
      | Name: | Street Address: | City: | State/Province: | Zip/Postal Code: | Country: |
      | Name  | Street Address  | City  | State/Province  | 123456           | Thailand |
    Then The profile is saved
    And The profile should be:
      | Name: | Street Address: | City: | State/Province: | Zip/Postal Code: | Country: |
      | Name  | Street Address  | City  | State/Province  | 123456           | Thailand |
    When I close phoenix account page
    And I refresh User Details section
    Then MozyHome user details should be:
      | Country: |
      | Thailand |

  @TC.2361
  Scenario: 2361 Change credit card information for a MozyPro partner
    When I log in bus admin console as administrator
    And I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Change Payment Information section from bus admin console page
    And I update payment contact information to:
      | address | phone     | city | country | state abbrev | zip    | email           |
      | address | 12345678  | city | Canada  | AB           |123456  | email@email.com |
    And I save payment information changes
    Then Payment information should be updated
    And Payment billing information should be:
      | Billing Street Address: | Billing Phone: | Billing City: | Billing Country: | Billing State/Province: | Billing ZIP/Postal Code: | Billing Email   |
      | address                 | 12345678       | city          | Canada           | AB                      | 123456                   | email@email.com |

  @TC.2362 @firefox
  Scenario: 2362 Edit an existing MozyHome user as a user
    When I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          | $5.99 |          | $5.99  |
    Then the user is successfully added
    When I log in bus admin console as administrator
    And I view MozyHome user details by @user_name
    When I verify the user
    Then The user is verified
    When I Log in as the user
    Then I will see the account page
    When I navigate to Upgrade section in Phoenix
    And I change credit card info to:
      | Name: | Street Address: | City: | Zip/Postal Code: | Country: |
      | Name  | Street Address  | City  | 123456           | Canada   |
    Then the user is successfully added