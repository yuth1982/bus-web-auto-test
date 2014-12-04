Feature: MozyHome user change renewal plan through phoenix

  As a MozyHome paid user
  I want to change renewal plan
  So that I can have new renewal plan

  #
  # 50 GB Cases
  #
  @TC.230001 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us @BUG.129199
  Scenario: 230001 Change US MozyHome user renwal plan computers
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl computers | country       | billing country |
      | 1      | 50 GB     | 4              | United States | United States   |
    Then the billing summary looks like:
      | Description                           | Price  | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99  | 1        | $5.99   |
      | Additional Computers - Monthly        | $2.00  | 4        | $8.00   |
      | Total Charge                          | $13.99 |          | $13.99  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | computers |
      | 1         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 1                |
      | Subscription:       | Monthly          |
      | Total:              | $5.99            |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 GB             |
      | Computers:          | 1                |
      | Subscription:       | Monthly          |
      | Total:              | $5.99            |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.230002 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 230002 Change US MozyHome user renwal plan
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 12     | 50 GB     | United States | United States   |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | $65.89 | 1        | $65.89 |
      | Total Charge                         | $65.89 |          | $65.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | addl storage |
      | 125 GB    | 3            |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 3 x 20 GB = 60 GB |
      | Total Storage:      | 185 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Yearly            |
      | Term Discount:      | 1 month free      |
      | Total:              | $175.89           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 60 GB           |
      | Computers:          | 3               |
      | Subscription:       | Yearly          |
      | Term Discount:      | 1 month free    |
      | Total:              | $175.89         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.230003 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 230003 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 24     | 50 GB     | United States | United States   |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Total Charge                           | $125.79 |          | $125.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period |
      | 12     |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 1                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Total:              | $65.89           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 1              |
      | Subscription:       | Yearly         |
      | Term Discount:      | 1 month free   |
      | Total:              | $65.89         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 GB Cases
  #
  @TC.230004 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 230004 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 1      | 125 GB    | United States | United States   |
    Then the billing summary looks like:
      | Description                                   | Price | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99 | 1        | $9.99  |
      | Total Charge                                  | $9.99 |          | $9.99  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | computers |
      | 24     | 5         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 125 GB           |
      | Computers:          | 5                |
      | Subscription:       | Biennial         |
      | Term Discount:      | 3 months free    |
      | Total:              | $293.79          |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 0 GB            |
      | Computers:          | 5               |
      | Subscription:       | Biennial        |
      | Term Discount:      | 3 months free   |
      | Total:              | $293.79         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.230005 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 230005 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 12     | 125 GB    | United States | United States   |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Total Charge                                 | $109.89 |          | $109.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan |
      | 50 GB     |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 1                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Total:              | $65.89           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 1              |
      | Subscription:       | Yearly         |
      | Term Discount:      | 1 month free   |
      | Total:              | $65.89         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.230006 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 230006 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 24     | 125 GB    | United States | United States   |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | Total Charge                                   | $209.79 |          | $209.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | computers | addl storage |
      | 50 GB     | 12      | 5        | 10           |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB      |
      | Additional Storage: | 10 x 20 GB = 200 GB |
      | Total Storage:      | 250 GB              |
      | Computers:          | 5                   |
      | Subscription:       | Yearly              |
      | Term Discount:      | 1 month free        |
      | Total:              | $373.89             |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 200 GB         |
      | Computers:          | 5              |
      | Subscription:       | Yearly         |
      | Term Discount:      | 1 month free   |
      | Total:              | $373.89        |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 50 GB Cases
  #
  @TC.230007 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: 230007 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl storage |
      | 1      | 50 GB     | United States | United States   | 1            |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | 20 Additional Storage - Monthly       | $2.00 | 1        | $2.00  |
      | Total Charge                          | $7.99 |          | $7.99  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan |
      | 125 GB    |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 1 x 20 GB = 20 GB |
      | Total Storage:      | 145 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Monthly           |
      | Total:              | $11.99            |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 20 GB             |
      | Computers:          | 3                 |
      | Subscription:       | Monthly           |
      | Total:              | $11.99            |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.230008 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us @bug
  Scenario: 230008 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl computers |
      | 12     | 50 GB     | United States | United States   | 1              |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | $65.89 | 1        | $65.89 |
      | Additional Computers - Annual        | $22.00 | 1        | $22.00 |
      | Total Charge                         | $87.89 |          | $87.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    ### need to remove the data of computer when bug is fixed
    And I change my user account to:
      | period | computers |
      | 24     | 2         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 2                |
      | Subscription:       | Biennial         |
      | Term Discount:      | 3 months free    |
      | Total:              | $167.79          |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 2              |
      | Subscription:       | Biennial       |
      | Term Discount:      | 3 months free  |
      | Total:              | $167.79        |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user


  @TC.230009 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us @qa6_dependent
  Scenario: 230009 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | coupon       |
      | 24     | 50 GB     | United States | United States   | 10percentoff |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Subscription Price                     | $125.79 |          | $125.79 |
      | 24 months at 10.0% off                 | $-12.57 |          | $-12.57 |
      | Total Charge                           | $113.22 |          | $113.22 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period |
      | 1      |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 1                |
      | Subscription:       | Monthly          |
      | Total:              | $5.99            |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 1              |
      | Subscription:       | Monthly        |
      | Total:              | $5.99          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 GB Cases
  #
  @TC.2300010 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: 2300010 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl storage | addl computers |
      | 1      | 125 GB    | United States | United States   | 2            | 2              |
    Then the billing summary looks like:
      | Description                                   | Price  | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99  | 1        | $9.99  |
      | 20 Additional Storage - Monthly               | $2.00  | 2        | $4.00  |
      | Additional Computers - Monthly                | $2.00  | 2        | $4.00  |
      | Total Charge                                  | $17.99 |          | $17.99 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period |
      | 24     |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 1                |
      | Subscription:       | Monthly          |
      | Total:              | $5.99            |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 1              |
      | Subscription:       | Monthly        |
      | Total:              | $5.99          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.2300011 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: 2300011 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl storage |
      | 12     | 125 GB    | United States | United States   | 98           |
    Then the billing summary looks like:
      | Description                                  | Price     | Quantity | Amount    |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89   | 1        | $109.89   |
      | 20 Additional Storage - Annual               | $22.00    | 98       | $2,156.00 |
      | Total Charge                                 | $2,265.89 |          | $2,265.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period |
      | 50 GB     | 1      |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB        |
      | Additional Storage: | 98 x 20 GB = 1,960 GB |
      | Total Storage:      | 2,010 GB              |
      | Computers:          | 1                     |
      | Subscription:       | Monthly               |
      | Total:              | $201.99               |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 1.9 TB         |
      | Computers:          | 1              |
      | Subscription:       | Monthly        |
      | Total:              | $201.99        |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.2300012 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: 2300012 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl computers |
      | 24     | 125 GB    | United States | United States   | 1              |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | Additional Computers - Biennial                | $42.00  | 1        | $42.00  |
      | Total Charge                                   | $251.79 |          | $251.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | computers | addl storage |
      | 12     | 5         | 5            |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB    |
      | Additional Storage: | 5 x 20 GB = 100 GB |
      | Total Storage:      | 225 GB             |
      | Computers:          | 5                  |
      | Subscription:       | Yearly             |
      | Term Discount:      | 1 month free       |
      | Total:              | $263.89            |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 100 GB          |
      | Computers:          | 5               |
      | Subscription:       | Yearly          |
      | Term Discount:      | 1 month free    |
      | Total:              | $263.89         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 50 GB Cases
  #
  @TC.2300013 @BUG.128707 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr
  Scenario: 2300013 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl storage | addl computers | coupon       |
      | 1      | 50 GB     | United States | France          | 99           | 2              | 10percentoff |
    # need to update 24 months at 10.0% off when the bug is fixed
    Then the billing summary looks like:
      | Description                           | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99   | 1        | $5.99   |
      | 20 Additional Storage - Monthly       | $2.00   | 99       | $198.00 |
      | Additional Computers - Monthly        | $2.00   | 2        | $4.00   |
      | Subscription Price                    | $207.99 |          | $207.99 |
      | 24 months at 10.0% off                  | $-20.79 |          | $-20.79 |
      | Total Charge                          | $187.20 |          | $187.20 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period |
      | 125 GB    | 24     |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB       |
      | Additional Storage: | 99 x 20 GB = 1,980 GB |
      | Total Storage:      | 2,105 GB              |
      | Computers:          | 3                     |
      | Subscription:       | Biennial              |
      | Term Discount:      | 3 months free         |
      | Total:              | $4367.79              |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 0 GB            |
      | Computers:          | 3               |
      | Subscription:       | Biennial        |
      | Term Discount:      | 3 months free   |
      | Total:              | $4,367.79       |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.2300014 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr
  Scenario: 2300014 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 12     | 50 GB     | United States | France          |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | $65.89 | 1        | $65.89 |
      | Total Charge                         | $65.89 |          | $65.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | addl storage |
      | 125 GB    | 1      | 99           |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB       |
      | Additional Storage: | 99 x 20 GB = 1,980 GB |
      | Total Storage:      | 2,105 GB              |
      | Computers:          | 3                     |
      | Subscription:       | Monthly               |
      | Total:              | $207.99               |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 1.9 TB          |
      | Computers:          | 3               |
      | Subscription:       | Monthly         |
      | Total:              | $207.99         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.2300015 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr @BUG.129199
  Scenario: 2300015 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl computers | country       | billing country |
      | 24     | 50 GB     | 4              | United States | France          |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Additional Computers - Biennial        | $42.00  | 4        | $168.00 |
      | Total Charge                           | $147.79 |          | $147.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | computers |
      | 1      | 2         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 2                |
      | Subscription:       | Monthly          |
      | Total:              | $7.99            |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 2              |
      | Subscription:       | Monthly        |
      | Total:              | $7.99          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 GB Cases
  #
  @TC.2300016 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr @BUG.129110
  Scenario: 2300016 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl computers | addl storage | country       | billing country |
      | 1      | 125 GB    | 2              | 10           | United States | France          |
    Then the billing summary looks like:
      | Description                                   | Price  | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99  | 1        | $9.99  |
      | 20 Additional Storage - Monthly               | $2.00  | 10       | $20.00 |
      | Additional Computers - Monthly                | $2.00  | 2        | $4.00  |
      | Total Charge                                  | $33.99 |          | $33.99 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    ## need to move computers data when bug fixed
    And I change my user account to:
      | period | addl storage | computers |
      | 12     | 20           | 5         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB     |
      | Additional Storage: | 20 x 20 GB = 400 GB |
      | Total Storage:      | 525 GB              |
      | Computers:          | 5                   |
      | Subscription:       | Yearly              |
      | Term Discount:      | 1 month free        |
      | Total:              | $593.89             |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 400 GB          |
      | Computers:          | 5               |
      | Subscription:       | Yearly          |
      | Term Discount:      | 1 month free    |
      | Total:              | $593.89         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.2300017 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr @BUG.129199
  Scenario: 2300017 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl storage | addl computers | country       | billing country |
      | 12     | 125 GB    | 10           | 2              | United States | France          |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | 20 Additional Storage - Annual               | $22.00  | 10       | $220.00 |
      | Additional Computers - Annual                | $22.00  | 2        | $44.00  |
      | Total Charge                                 | $373.89 |          | $373.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | addl storage | computers |
      | 1            | 3         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 1 x 20 GB = 20 GB |
      | Total Storage:      | 145 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Yearly            |
      | Term Discount:      | 1 month free      |
      | Total:              | $131.89           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 20 GB           |
      | Computers:          | 3               |
      | Subscription:       | Yearly          |
      | Term Discount:      | 1 month free    |
      | Total:              | $131.89         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.2300018 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr
  Scenario: 2300018 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 24     | 125 GB    | United States | France          |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | Total Charge                                   | $209.79 |          | $209.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | base plan |
      | 1      | 50 GB     |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 1                |
      | Subscription:       | Monthly          |
      | Total:              | $5.99            |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 1              |
      | Subscription:       | Monthly        |
      | Total:              | $5.99          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 50 GB Cases
  #
  @TC.2300019 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 2300019 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl storage | addl computers | country       | billing country |
      | 1      | 50 GB     | 30           | 2              | United States | China           |
    Then the billing summary looks like:
      | Description                           | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99  | 1        | $5.99  |
      | 20 Additional Storage - Monthly       | $2.00  | 30       | $60.00 |
      | Additional Computers - Monthly        | $2.00  | 2        | $4.00  |
      | Total Charge                          | $69.99 |          | $69.99 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | addl storage | computers |
      | 10           | 2         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB      |
      | Additional Storage: | 10 x 20 GB = 200 GB |
      | Total Storage:      | 250 GB              |
      | Computers:          | 2                   |
      | Subscription:       | Monthly             |
      | Total:              | $27.99              |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 0 GB            |
      | Computers:          | 3               |
      | Subscription:       | Monthly         |
      | Total:              | $27.99          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.2300020 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 2300020 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl computers | country       | billing country |
      | 12     | 50 GB     | 2              | United States | China           |
    Then the billing summary looks like:
      | Description                          | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Annual | $65.89  | 1        | $65.89  |
      | Additional Computers - Annual        | $22.00  | 2        | $44.00  |
      | Total Charge                         | $109.89 |          | $109.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | computers |
      | 1      | 1         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 1                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Total:              | $87.89           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 1              |
      | Subscription:       | Yearly         |
      | Term Discount:      | 1 month free   |
      | Total:              | $87.89         |
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.2300021 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 2300021 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 24     | 50 GB     | United States | China           |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Total Charge                           | $125.79 |          | $125.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan |
      | 125 GB    |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 125 GB           |
      | Computers:          | 3                |
      | Subscription:       | Biennial         |
      | Term Discount:      | 3 months free    |
      | Total:              | $209.79          |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 0 GB            |
      | Computers:          | 3               |
      | Subscription:       | Biennial        |
      | Term Discount:      | 3 months free   |
      | Total:              | $209.79         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 GB Cases
  #
  @TC.2300022 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 2300022 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl storage | addl computers | country       | billing country |
      | 1      | 125 GB    | 4            | 4              | United States | China           |
    Then the billing summary looks like:
      | Description                                   | Price  | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99  | 1        | $9.99  |
      | 20 Additional Storage - Monthly               | $2.00  | 4        | $8.00  |
      | Additional Computers - Monthly                | $2.00  | 4        | $8.00  |
      | Total Charge                                  | $25.99 |          | $25.99 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | addl storage | computers |
      | 50 GB     | 3            | 4         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB    |
      | Additional Storage: | 3 x 20 GB = 60 GB |
      | Total Storage:      | 110 GB            |
      | Computers:          | 4                 |
      | Subscription:       | Monthly           |
      | Total:              | $17.99            |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 60 GB          |
      | Computers:          | 4              |
      | Subscription:       | Monthly        |
      | Total:              | $17.99         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.2300023 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 2300023 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl storage | addl computers | country       | billing country |
      | 12     | 125 GB    | 99           | 2              | United States | China           |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount    |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89   |
      | 20 Additional Storage - Annual               | $22.00  | 99       | $2,178.00 |
      | Additional Computers - Annual                | $22.00  | 2        | $44.00    |
      | Total Charge                                 | $109.89 |          | $2,331.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | addl storage | addl computers |
      | 50 GB     | 1      | 0            | 1              |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 1                |
      | Subscription:       | Monthly          |
      | Total:              | $5.99            |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 1              |
      | Subscription:       | Monthly        |
      | Total:              | $5.99          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.2300024 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 2300024 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl storage | addl computers | country       | billing country |
      | 24     | 125 GB    | 1            | 1              | United States | China           |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | 20 Additional Storage - Biennial               | $42.00  | 1        | $42.00  |
      | Additional Computers - Biennial                | $42.00  | 1        | $42.00  |
      | Total Charge                                   | $209.79 |          | $293.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | addl storage | computers |
      | 0            | 3         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 125 GB           |
      | Computers:          | 3                |
      | Subscription:       | Biennial         |
      | Term Discount:      | 3 months free    |
      | Total:              | $209.79          |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 0 GB            |
      | Computers:          | 3               |
      | Subscription:       | Biennial        |
      | Term Discount:      | 3 months free   |
      | Total:              | $209.79         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.2300025 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 2300025 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 1      | 50 GB     | United States | China           |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          | $5.99 |          | $5.99  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | computers | addl storage |
      | 12     | 5         | 5            |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB     |
      | Additional Storage: | 5 x 20 GB = 100 GB |
      | Total Storage:      | 150 GB             |
      | Computers:          | 5                  |
      | Subscription:       | Yearly             |
      | Term Discount:      | 1 month free       |
      | Total:              | $263.89            |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 100 GB         |
      | Computers:          | 5              |
      | Subscription:       | Yearly         |
      | Term Discount:      | 1 month free   |
      | Total:              | $263.89        |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.2300026 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 2300026 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 12     | 50 GB     | United States | China           |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | $65.89 | 1        | $65.89 |
      | Total Charge                         | $65.89 |          | $65.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | computers |
      | 125 GB    | 5         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 125 GB           |
      | Computers:          | 5                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Total:              | $153.89          |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 5              |
      | Subscription:       | Yearly         |
      | Term Discount:      | 1 month free   |
      | Total:              | $153.89        |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.2300027 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 2300027 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 24     | 50 GB     | United States | China           |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Total Charge                           | $125.79 |          | $125.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | addl storage |
      | 125 GB    | 1      | 98           |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB       |
      | Additional Storage: | 98 x 20 GB = 1,960 GB |
      | Total Storage:      | 2,085 GB              |
      | Computers:          | 3                     |
      | Subscription:       | Monthly               |
      | Total:              | $205.99               |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 1.9 TB          |
      | Computers:          | 3               |
      | Subscription:       | Monthly         |
      | Total:              | $205.99         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 GB Cases
  #
  @TC.2300028 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 2300028 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 1      | 125 GB    | United States | China           |
    Then the billing summary looks like:
      | Description                                   | Price | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99 | 1        | $9.99  |
      | Total Charge                                  | $9.99 |          | $9.99  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan |
      | 50 GB     |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 1                |
      | Subscription:       | Monthly          |
      | Total:              | $5.99            |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 50 GB          |
      | Computers:          | 3              |
      | Subscription:       | Monthly        |
      | Total:              | $5.99          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.2300029 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 2300029 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 12     | 125 GB    | United States | United States   |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Total Charge                                 | $109.89 |          | $109.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | computers | addl storage |
      | 24     | 4         | 1            |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 1 x 20 GB = 20 GB |
      | Total Storage:      | 145 GB            |
      | Computers:          | 4                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Total:              | $293.79          |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 20 GB           |
      | Computers:          | 4               |
      | Subscription:       | Biennial        |
      | Term Discount:      | 3 months free   |
      | Total:              | $293.79         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.2300030 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 2300030 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 24     | 125 GB    | United States | China           |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | 20 Additional Storage - Biennial               | $42.00  | 1        | $42.00  |
      | Additional Computers - Biennial                | $42.00  | 1        | $42.00  |
      | Total Charge                                   | $209.79 |          | $209.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | computers |
      | 50 GB     | 12     | 2         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 2                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Total:              | $87.89           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 2              |
      | Subscription:       | Yearly         |
      | Term Discount:      | 1 month free   |
      | Total:              | $87.89         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 50 GB Cases
  #
  @TC.2300031 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=fr
  Scenario: 2300031 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl storage | addl computers | country       | billing country |
      | 1      | 50 GB     | 3            | 2              | United States | France          |
    Then the billing summary looks like:
      | Description                           | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99  | 1        | $5.99  |
      | 20 Additional Storage - Monthly       | $2.00  | 3        | $6.00  |
      | Additional Computers - Monthly        | $2.00  | 2        | $4.00  |
      | Total Charge                          | $15.99 |          | $15.99 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | computers | addl storage |
      | 125GB     | 12     | 4         | 10           |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB     |
      | Additional Storage: | 10 x 20 GB = 200 GB |
      | Total Storage:      | 325 GB              |
      | Computers:          | 4                   |
      | Subscription:       | Yearly              |
      | Term Discount:      | 1 month free        |
      | Total:              | $351.89             |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 2              |
      | Subscription:       | Yearly         |
      | Term Discount:      | 1 month free   |
      | Total:              | $351.89        |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.2300032 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=fr
  Scenario: 2300032 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl storage | addl computers | country       | billing country |
      | 12     | 50 GB     | 10           | 2              | United States | France          |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Annual | $65.89 | 1        | $65.89  |
      | 20 Additional Storage - Annual       | $22.00 | 10       | $220.00 |
      | Additional Computers - Annual        | $22.00 | 2        | $44.00  |
      | Total Charge                         | $65.89 |          | $329.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | computers |
      | 24     | 5         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB      |
      | Additional Storage: | 10 x 20 GB = 200 GB |
      | Total Storage:      | 250 GB              |
      | Computers:          | 5                   |
      | Subscription:       | Yearly              |
      | Term Discount:      | 1 month free        |
      | Total:              | $373.89             |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 200 GB         |
      | Computers:          | 5              |
      | Subscription:       | Yearly         |
      | Term Discount:      | 1 month free   |
      | Total:              | $373.89        |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.2300033 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=fr
  Scenario: 2300033 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl storage | country       | billing country |
      | 24     | 50 GB     | 99           | United States | France          |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount    |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79   |
      | 20 Additional Storage - Biennial       | $42.00  | 99       | $4,158.00 |
      | Total Charge                           | $125.79 |          | $4,283.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | add storage |
      | 125 GB    | 0           |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 125 GB           |
      | Computers:          | 3                |
      | Subscription:       | Biennial         |
      | Term Discount:      | 3 months free    |
      | Total:              | $209.79          |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 2              |
      | Subscription:       | Biennial       |
      | Term Discount:      | 3 months free  |
      | Total:              | $209.79        |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 GB Cases
  #
  @TC.2300034 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=fr
  Scenario: 2300034 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 1      | 125 GB    | United States | France          |
    Then the billing summary looks like:
      | Description                                   | Price | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99 | 1        | $9.99  |
      | Total Charge                                  | $9.99 |          | $9.99  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period |
      | 50 GB     | 12     |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 1                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Total:              | $65.89           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 1              |
      | Subscription:       | Yearly         |
      | Term Discount:      | 1 month free   |
      | Total:              | $65.89         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.2300035 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=fr
  Scenario: 2300035 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl storage | country       | billing country |
      | 12     | 125 GB    | 4            | United States | France          |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | 20 Additional Storage - Annual               | $22.00  | 4        | $88.00  |
      | Total Charge                                 | $197.89 |          | $197.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | computers |
      | 50 GB     | 24     | 3         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB    |
      | Additional Storage: | 4 x 20 GB = 80 GB |
      | Total Storage:      | 130 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Total:              | $557.89           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 80 GB          |
      | Computers:          | 3              |
      | Subscription:       | Biennial       |
      | Term Discount:      | 3 months free  |
      | Total:              | $557.89        |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.2300036 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=fr
  Scenario: 2300036 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl computers | addl storage | country       | billing country |
      | 24     | 125 GB    | 2              | 10           | United States | France          |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | 20 Additional Storage - Biennial               | $42.00  | 10       | $420.00 |
      | Additional Computers - Biennial                | $42.00  | 2        | $84.00  |
      | Total Charge                                   | $713.79 |          | $713.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | computers | addl storage |
      | 12     | 3         | 1            |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 1 x 20 GB = 20 GB |
      | Total Storage:      | 145 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Yearly            |
      | Term Discount:      | 1 month free      |
      | Total:              | $151.89           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 20 GB           |
      | Computers:          | 3               |
      | Subscription:       | Yearly          |
      | Term Discount:      | 1 month free    |
      | Total:              | $151.89         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user



  ######### VAT applied ####
  #
  # 50 Go Cases
  #
  @TC.237001 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 237001 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 1      | 50 Go     | France  | France          |
    Then the billing summary looks like:
      | Description                             | Prix  | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Mensuel | 4,16€ | 1        |
      | Montant:                                | 4,16€ |          |
      | VAT Rate (20.0%):                       | 0,83€ |          |
      | Montant total des frais:                | 4,99€ |          |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period |
      | 125 Go    | 12     |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 0 x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 125 Go           |
      | Ordinateurs :                       | 3                |
      | Abonnement :                        | Annuel           |
      | Remise : 	                        | 1 mois gratuit   |
      | Montant: 	                        | 82,41€           |
      | VAT Rate (20.0%):                   | 16,48€           |
      | Total : 	                        | 98,89€           |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 0 Go             |
      | Ordinateurs :                       | 3                |
      | Abonnement :                        | Annuel           |
      | Remise : 	                        | 1 mois gratuit   |
      | Montant: 	                        | 82,41€           |
      | VAT Rate (20.0%):                   | 16,48€           |
      | Total : 	                        | 98,89€           |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237002 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 237002 Add a new FR yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 50 Go     | France  | France          |
    Then the billing summary looks like:
      | Description                            | Prix   | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Annuel | 45,74€ | 1        |
      | Montant:                               | 45,74€ |          |
      | VAT Rate (20.0%):                      | 9,15€  |          |
      | Montant total des frais:               | 54,89€ |          |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period |
      | 125 Go    | 24     |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 0	x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 125 Go           |
      | Ordinateurs :                       | 3                |
      | Abonnement :                        | Bisannuel        |
      | Remise : 	                        | 3 mois gratuits  |
      | Montant: 	                        | 157,32€          |
      | VAT Rate (20.0%):                   | 31,47€           |
      | Total : 	                        | 188,79€          |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 125 Go |
      | Espace de stockage supplémentaire : | 0 Go            |
      | Ordinateurs :                       | 3               |
      | Abonnement :                        | Bisannuel       |
      | Remise : 	                        | 3 mois gratuits |
      | Montant: 	                        | 157,32€         |
      | VAT Rate (20.0%):                   | 31,47€          |
      | Total : 	                        | 188,79€         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237003 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 237003 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 24     | 50 Go     | France  | France          |
    Then the billing summary looks like:
      | Description                               | Prix    | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Bisannuel | 87,32€  | 1        |
      | Montant:                                  | 87,32€  |          |
      | VAT Rate (20.0%):                         | 17,47€  |          |
      | Montant total des frais:                  | 104,79€ |          |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period |
      | 1     |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 50 Go   |
      | Espace de stockage supplémentaire : | 0	x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 50 Go            |
      | Ordinateurs :                       | 1                |
      | Abonnement :                        | Mensuel          |
      | Montant: 	                        | 4,16€            |
      | VAT Rate (20.0%):                   | 0,83€            |
      | Total : 	                        | 4,99€            |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 50 Go |
      | Espace de stockage supplémentaire : | 0 Go           |
      | Ordinateurs :                       | 1              |
      | Abonnement :                        | Mensuel        |
      | Montant: 	                        | 4,16€          |
      | VAT Rate (20.0%):                   | 0,83€          |
      | Total : 	                        | 4,99€          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 Go Cases
  #
  @TC.237004 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 237004 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 1      | 125 Go    | France  | France          |
    Then the billing summary looks like:
      | Description                                       | Prix  | Quantité |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Mensuel | 7,49€ | 1        |
      | Montant:                                          | 7,49€ |          |
      | VAT Rate (20.0%):                                 | 1,50€ |          |
      | Montant total des frais:                          | 8,99€ |          |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | computers |
      | 24     | 5         |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 0	x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 125 Go           |
      | Ordinateurs :                       | 5                |
      | Abonnement :                        | Bisannuel        |
      | Remise : 	                        | 3 mois gratuits  |
      | Montant: 	                        | 227,33€          |
      | VAT Rate (20.0%):                   | 45,47€           |
      | Total : 	                        | 272,79€          |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 125 Go |
      | Espace de stockage supplémentaire : | 0 Go            |
      | Ordinateurs :                       | 5               |
      | Abonnement :                        | Bisannuel       |
      | Remise : 	                        | 3 mois gratuits |
      | Montant: 	                        | 227,33€         |
      | VAT Rate (20.0%):                   | 45,47€          |
      | Total : 	                        | 272,79€         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237005 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 237005 Add a new FR yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 Go    | France  | France          |
    Then the billing summary looks like:
      | Description                                      | Prix   | Quantité |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Annuel | 82,41€ | 1        |
      | Montant:                                         | 82,41€ |          |
      | VAT Rate (20.0%):                                | 16,48€ |          |
      | Montant total des frais:                         | 98,89€ |          |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period |
      | 1     |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 0	x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 125 Go           |
      | Ordinateurs :                       | 3                |
      | Abonnement :                        | Mensuel          |
      | Montant: 	                        | 7,49€            |
      | VAT Rate (20.0%):                   | 1,50€            |
      | Total : 	                        | 8,99€            |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 125 Go |
      | Espace de stockage supplémentaire : | 0 Go            |
      | Ordinateurs :                       | 3               |
      | Abonnement :                        | Mensuel         |
      | Montant: 	                        | 7,49€           |
      | VAT Rate (20.0%):                   | 1,50€           |
      | Total : 	                        | 8,99€           |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237006 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 237006 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 24     | 125 Go    | France  | France          |
    Then the billing summary looks like:
      | Description                                         | Prix    | Quantité |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Bisannuel | 157,32€ | 1        |
      | Montant:                                            | 157,32€ |          |
      | VAT Rate (20.0%):                                   | 31,47€  |          |
      | Montant total des frais:                            | 188,79€ |          |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | addl storage |
      | 12     | 99           |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 125 Go       |
      | Espace de stockage supplémentaire : | 99 x 20 Go = 1 980 Go |
      | Espace total de stockage : 	        | 2 105 Go              |
      | Ordinateurs :                       | 3                     |
      | Abonnement :                        | Annuel                |
      | Remise : 	                        | 1 mois gratuit        |
      | Montant: 	                        | 1 897,41€             |
      | VAT Rate (20.0%):                   | 379,48€               |
      | Total : 	                        | 2 276,89€             |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 125 Go |
      | Espace de stockage supplémentaire : | 1,9 To          |
      | Ordinateurs :                       | 3               |
      | Abonnement :                        | Annuel          |
      | Remise : 	                        | 1 mois gratuit  |
      | Montant: 	                        | 1 897,41€       |
      | VAT Rate (20.0%):                   | 379,48€         |
      | Total : 	                        | 2 276,89€       |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 50 Go Cases
  #
  @TC.237007 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 237007 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl storage |
      | 1      | 50 Go     | France  | Royaume-Uni     | 1            |
    Then the billing summary looks like:
      | Description                             | Prix  | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Mensuel | 4,16€ | 1        |
      | 20 Stockage supplémentaire - Mensuel    | 1,67€ | 1        |
      | Montant:                                | 5,82€ |          |
      | VAT Rate (20.0%):                       | 1,17€ |          |
      | Montant total des frais:                | 6,99€ |          |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | addl storage |
      | 125 Go    | 24     | 98           |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 125 Go       |
      | Espace de stockage supplémentaire : | 98 x 20 Go = 1 960 Go |
      | Espace total de stockage : 	        | 2 085 Go              |
      | Ordinateurs :                       | 3                     |
      | Abonnement :                        | Bisannuel             |
      | Remise : 	                        | 3 mois gratuits       |
      | Montant: 	                        | 3 587,32€             |
      | VAT Rate (20.0%):                   | 717,47€               |
      | Total : 	                        | 4 304,79€             |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 125 Go |
      | Espace de stockage supplémentaire : | 1,9 To          |
      | Ordinateurs :                       | 3               |
      | Abonnement :                        | Bisannuel       |
      | Remise : 	                        | 3 mois gratuits |
      | Montant: 	                        | 3 587,32€       |
      | VAT Rate (20.0%):                   | 717,47€         |
      | Total : 	                        | 4 304,79€       |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237008 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 237008 Add a new fr yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl computers |
      | 12     | 50 Go     | France  | Royaume-Uni     | 1              |
    Then the billing summary looks like:
      | Description                            | Prix   | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Annuel | 45,74€ | 1        |
      | Ordinateurs supplémentaires - Annuel   | 18,37€ | 1        |
      | Montant:                               | 64,07€ |          |
      | VAT Rate (20.0%):                      | 12,82€ |          |
      | Montant total des frais:               | 76,89€ |          |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | computers |
      | 1      | 1         |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 50 Go   |
      | Espace de stockage supplémentaire : | 0	x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 50 Go            |
      | Ordinateurs :                       | 1                |
      | Abonnement :                        | Mensuel          |
      | Montant: 	                        | 4,16€            |
      | VAT Rate (20.0%):                   | 0,83€            |
      | Total : 	                        | 4,99€            |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 50 Go |
      | Espace de stockage supplémentaire : | 0 Go           |
      | Ordinateurs :                       | 1              |
      | Abonnement :                        | Mensuel        |
      | Montant: 	                        | 4,16€          |
      | VAT Rate (20.0%):                   | 0,83€          |
      | Total : 	                        | 4,99€          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237009 @BUG.128707 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk @qa6_dependent
  Scenario: 237009 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | coupon       |
      | 24     | 50 Go     | France  | Royaume-Uni     | 10percentoff |
    Then the billing summary looks like:
      | Description                               | Prix   | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Bisannuel | 87,32€ | 1        |
      | Prix d'abonnement                         | 87,32€ |          |
      | 24 mois à 10.0 % de réduction:            | -8,72€ |          |
      | Montant:                                  | 78,60€ |          |
      | VAT Rate (20.0%):                         | 15,72€ |          |
      | Montant total des frais:                  | 94,32€ |          |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | computers |
      | 125 Go    | 5         |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 0 x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 125 Go           |
      | Ordinateurs :                       | 5                |
      | Abonnement :                        | Bisannuel        |
      | Remise : 	                        | 3 mois gratuits  |
      | Montant: 	                        | 227,33€          |
      | VAT Rate (20.0%):                   | 45,47€           |
      | Total : 	                        | 272,79€          |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 125 Go |
      | Espace de stockage supplémentaire : | 0 Go            |
      | Ordinateurs :                       | 5               |
      | Abonnement :                        | Bisannuel       |
      | Remise : 	                        | 3 mois gratuits |
      | Montant: 	                        | 227,33€         |
      | VAT Rate (20.0%):                   | 45,47€          |
      | Total : 	                        | 272,79€         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 Go Cases
  #
  @TC.237010 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 237010 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl storage | addl computers |
      | 1      | 125 Go    | France  | Royaume-Uni     | 2            | 2              |
    Then the billing summary looks like:
      | Description                                       | Prix   | Quantité |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Mensuel | 7,49€  | 1        |
      | 20 Stockage supplémentaire - Mensuel              | 1,67€  | 2        |
      | Ordinateurs supplémentaires - Mensuel             | 1,67€  | 2        |
      | Montant:                                          | 14,16€ |          |
      | VAT Rate (20.0%):                                 | 2,83€  |          |
      | Montant total des frais:                          | 16,99€ |          |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | addl storage | computers |
      | 50 Go     | 12     | 3            | 1         |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 50 Go    |
      | Espace de stockage supplémentaire : | 3 x 20 Go = 60 Go |
      | Espace total de stockage : 	        | 110 Go            |
      | Ordinateurs :                       | 1                 |
      | Abonnement :                        | Annuel            |
      | Remise : 	                        | 1 mois gratuit    |
      | Montant: 	                        | 100,74€           |
      | VAT Rate (20.0%):                   | 20,15€            |
      | Total : 	                        | 120,89€           |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 50 Go  |
      | Espace de stockage supplémentaire : | 60 Go           |
      | Ordinateurs :                       | 1               |
      | Abonnement :                        | Annuel          |
      | Remise : 	                        | 1 mois gratuit  |
      | Montant: 	                        | 100,74€         |
      | VAT Rate (20.0%):                   | 20,15€          |
      | Total : 	                        | 120,89€         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237011 @BUG.128707 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk @qa6_dependent
  Scenario: 237011 Add a new FR yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl storage | coupon       |
      | 12     | 125 Go    | France  | Royaume-Uni     | 98           | 10percentoff |
    Then the billing summary looks like:
      | Description                                      | Prix      | Quantité |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Annuel | 82,41€    | 1        |
      | 20 Stockage supplémentaire - Annuel              | 18,37€    | 98       |
      | Prix d'abonnement                                | 1 879,07€ |          |
      | 24 mois à 10.0 % de réduction:                   | -187,90€  |          |
      | Montant:                                         | 1 691,17€ |          |
      | VAT Rate (20.0%):                                | 338,24€   |          |
      | Montant total des frais:                         | 2 029,41€ |          |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | addl storage |
      | 24     | 10           |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 125 Go     |
      | Espace de stockage supplémentaire : | 10 x 20 Go = 200 Go |
      | Espace total de stockage : 	        | 325 Go              |
      | Ordinateurs :                       | 3                   |
      | Abonnement :                        | Bisannuel           |
      | Remise : 	                        | 3 mois gratuits     |
      | Montant: 	                        | 507,33€             |
      | VAT Rate (20.0%):                   | 101,47€             |
      | Total : 	                        | 608,79€             |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 125 Go |
      | Espace de stockage supplémentaire : | 200 Go          |
      | Ordinateurs :                       | 3               |
      | Abonnement :                        | Bisannuel       |
      | Remise : 	                        | 3 mois gratuits |
      | Montant: 	                        | 507,33€         |
      | VAT Rate (20.0%):                   | 101,47€         |
      | Total : 	                        | 608,79€         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237012 @BUG.128707 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk @qa6_dependent
  Scenario: 237012 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl computers | coupon       |
      | 24     | 125 Go    | France  | Royaume-Uni     | 1              | 10percentoff |
    Then the billing summary looks like:
      | Description                                         | Prix    | Quantité |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Bisannuel | 157,32€ | 1        |
      | Ordinateurs supplémentaires - Bisannuel             | 35,07€  | 1        |
      | Prix d'abonnement                                   | 192,32€ |          |
      | 24 mois à 10.0 % de réduction:                      | -19,22€ |          |
      | Montant:                                            | 173,10€ |          |
      | VAT Rate (20.0%):                                   | 34,62€  |          |
      | Montant total des frais:                            | 207,72€ |          |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period |
      | 50 Go     | 1      |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 50 Go   |
      | Espace de stockage supplémentaire : | 0	x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 50 Go            |
      | Ordinateurs :                       | 1                |
      | Abonnement :                        | Mensuel          |
      | Montant: 	                        | 4,16€            |
      | VAT Rate (20.0%):                   | 0,83€            |
      | Total : 	                        | 4,99€            |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 50 Go |
      | Espace de stockage supplémentaire : | 0 Go           |
      | Ordinateurs :                       | 1              |
      | Abonnement :                        | Mensuel        |
      | Montant: 	                        | 4,16€          |
      | VAT Rate (20.0%):                   | 0,83€          |
      | Total : 	                        | 4,99€          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 50 Go Cases
  #
  @TC.237013 @BUG.128707 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr @qa6_dependent
  Scenario: 237013 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl storage | addl computers | coupon       |
      | 1      | 50 Go     | France  | France          | 99           | 2              | 10percentoff |
    Then the billing summary looks like:
      | Description                             | Prix    | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Mensuel | 4,16€   | 1        |
      | 20 Stockage supplémentaire - Mensuel    | 1,67€   | 99       |
      | Ordinateurs supplémentaires - Mensuel   | 1,67€   | 2        |
      | Prix d'abonnement                       | 172,49€ |          |
      | 24 mois à 10.0 % de réduction:          | -17,24€ |          |
      | Montant:                                | 155,25€ |          |
      | VAT Rate (20.0%):                       | 31,05€  |          |
      | Montant total des frais:                | 186,30€ |          |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | addl storage | computers |
      | 1            | 2         |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 50 Go    |
      | Espace de stockage supplémentaire : | 1	x 20 Go = 20 Go |
      | Espace total de stockage : 	        | 70 Go             |
      | Ordinateurs :                       | 2                 |
      | Abonnement :                        | Mensuel           |
      | Montant: 	                        | 7,49€             |
      | VAT Rate (20.0%):                   | 1,50€             |
      | Total : 	                        | 8,99€             |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 50 Go |
      | Espace de stockage supplémentaire : | 20 Go          |
      | Ordinateurs :                       | 2              |
      | Abonnement :                        | Mensuel        |
      | Montant: 	                        | 7,49€          |
      | VAT Rate (20.0%):                   | 1,50€          |
      | Total : 	                        | 8,99€          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237014 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 237014 Add a new FR yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 50 Go     | France  | France          |
    Then the billing summary looks like:
      | Description                            | Prix   | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Annuel | 45,74€ | 1        |
      | Montant:                               | 45,74€ |          |
      | VAT Rate (20.0%):                      | 9,15€  |          |
      | Montant total des frais:               | 54,89€ |          |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan |
      | 125 Go    |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 125 Go  |
      | Espace de sockage supplémentaire :  | 0 x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 125 Go           |
      | Ordinateurs :                       | 3                |
      | Abonnement :                        | Annuel           |
      | Remise : 	                        | 1 mois gratuit   |
      | Montant: 	                        | 82,41€           |
      | VAT Rate (20.0%):                   | 16,48€           |
      | Total : 	                        | 98,89€           |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 125 Go |
      | Espace de stockage supplémentaire : | 0 Go            |
      | Ordinateurs :                       | 3               |
      | Abonnement :                        | Annuel          |
      | Remise : 	                        | 1 mois gratuit  |
      | Montant: 	                        | 82,41€          |
      | VAT Rate (20.0%):                   | 16,48€          |
      | Total : 	                        | 98,89€          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237015 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 237015 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 24     | 50 Go     | France  | France          |
    Then the billing summary looks like:
      | Description                               | Prix    | Quantité |
      | MozyHome 50 Go (1 ordinateur) - Bisannuel | 87,32€  | 1        |
      | Montant:                                  | 87,32€  |          |
      | VAT Rate (20.0%):                         | 17,47€  |          |
      | Montant total des frais:                  | 104,79€ |          |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | computers |
      | 125 Go    | 12     | 4         |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 125 Go  |
      | Espace de sockage supplémentaire :  | 0 x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 125 Go           |
      | Ordinateurs :                       | 4                |
      | Abonnement :                        | Annuel           |
      | Remise : 	                        | 1 mois gratuit   |
      | Montant: 	                        | 100,74€          |
      | VAT Rate (20.0%):                   | 20,15€           |
      | Total : 	                        | 120,89€          |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 125 Go |
      | Espace de stockage supplémentaire : | 0 Go            |
      | Ordinateurs :                       | 4               |
      | Abonnement :                        | Annuel          |
      | Remise : 	                        | 1 mois gratuit  |
      | Montant: 	                        | 100,74€         |
      | VAT Rate (20.0%):                   | 20,15€          |
      | Total : 	                        | 120,89€         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 Go Cases
  #
  @TC.237016 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 237016 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 1      | 125 Go    | France  | France          |
    Then the billing summary looks like:
      | Description                                       | Prix  | Quantité |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Mensuel | 7,49€ | 1        |
      | Montant:                                          | 7,49€ |          |
      | VAT Rate (20.0%):                                 | 1,50€ |          |
      | Montant total des frais:                          | 8,99€ |          |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan |
      | 50 Go     |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 50 Go   |
      | Espace de stockage supplémentaire : | 0	x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 50 Go            |
      | Ordinateurs :                       | 1                |
      | Abonnement :                        | Mensuel          |
      | Montant: 	                        | 4,16€            |
      | VAT Rate (20.0%):                   | 0,83€            |
      | Total : 	                        | 4,99€            |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 50 Go |
      | Espace de stockage supplémentaire : | 0 Go           |
      | Ordinateurs :                       | 1              |
      | Abonnement :                        | Mensuel        |
      | Montant: 	                        | 4,16€          |
      | VAT Rate (20.0%):                   | 0,83€          |
      | Total : 	                        | 4,99€          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237017 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 237017 Add a new FR yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 12     | 125 Go    | France  | France          |
    Then the billing summary looks like:
      | Description                                      | Prix   | Quantité |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Annuel | 82,41€ | 1        |
      | Montant:                                         | 82,41€ |          |
      | VAT Rate (20.0%):                                | 16,48€ |          |
      | Montant total des frais:                         | 98,89€ |          |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | computers | addl storage |
      | 50 Go     | 12     | 3         | 10           |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 50 Go      |
      | Espace de sockage supplémentaire :  | 10 x 20 Go = 200 Go |
      | Espace total de stockage : 	        | 250 Go              |
      | Ordinateurs :                       | 3                   |
      | Abonnement :                        | Annuel              |
      | Remise : 	                        | 1 mois gratuit      |
      | Montant: 	                        | 265,74€             |
      | VAT Rate (20.0%):                   | 53,15€              |
      | Total : 	                        | 318,89€             |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 50 Go |
      | Espace de stockage supplémentaire : | 200 Go         |
      | Ordinateurs :                       | 4              |
      | Abonnement :                        | Annuel         |
      | Remise : 	                        | 1 mois gratuit |
      | Montant: 	                        | 265,74€        |
      | VAT Rate (20.0%):                   | 53,15€         |
      | Total : 	                        | 318,89€        |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.237018 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 237018 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country |
      | 24     | 125 Go    | France  | France          |
    Then the billing summary looks like:
      | Description                                         | Prix    | Quantité |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Bisannuel | 157,32€ | 1        |
      | Montant:                                            | 157,32€ |          |
      | VAT Rate (20.0%):                                   | 31,47€  |          |
      | Montant total des frais:                            | 188,79€ |          |
    Then the user is successfully added.
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period |
      | 50 Go     | 12     |
    And the renewal plan subscription looks like:
      | Plan de base :                   	| MozyHome 50 Go   |
      | Espace de sockage supplémentaire :  | 0 x 20 Go = 0 Go |
      | Espace total de stockage : 	        | 50 Go            |
      | Ordinateurs :                       | 3                |
      | Abonnement :                        | Annuel           |
      | Remise : 	                        | 1 mois gratuit   |
      | Montant: 	                        | 45,74€           |
      | VAT Rate (20.0%):                   | 9,15€            |
      | Total : 	                        | 54,89€           |
    And the renewal plan summary looks like:
      | Plan de base :                   	| MozyHome 50 Go |
      | Espace de stockage supplémentaire : | 0 Go           |
      | Ordinateurs :                       | 3              |
      | Abonnement :                        | Annuel         |
      | Remise : 	                        | 1 mois gratuit |
      | Montant: 	                        | 45,74€         |
      | VAT Rate (20.0%):                   | 9,15€          |
      | Total : 	                        | 54,89€         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user