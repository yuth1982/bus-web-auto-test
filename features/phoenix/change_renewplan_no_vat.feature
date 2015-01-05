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
      | period | base plan | addl computers | country       | billing country | cc number         |
      | 1      | 50 GB     | 4              | United States | United States   | 4018121111111122  |
    Then the billing summary looks like:
      | Description                           | Price  | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99  | 1        | $5.99   |
      | Additional Computers - Monthly        | $2.00  | 4        | $8.00   |
      | Total Charge                          |        |          | $13.99  |
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
      | Total Charge                         |        |          | $65.89 |
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
      | Total Charge                           |         |          | $125.79 |
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
      | Total Charge                                  |       |          | $9.99  |
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
      | Total Charge                                 |         |          | $109.89 |
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
      | Total Charge                                   |         |          | $209.79 |
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
      | Total Charge                          |       |          | $7.99  |
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
      | Total Charge                         |        |          | $87.89 |
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
      | Total Charge                           |         |          | $113.22 |
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
      | Total Charge                                  |        |          | $17.99 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period |
      | 24     |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 2 x 20 GB = 40 GB |
      | Total Storage:      | 165 GB            |
      | Computers:          | 5                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Total:              | $377.79           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 40 GB           |
      | Computers:          | 5               |
      | Subscription:       | Biennial        |
      | Term Discount:      | 3 months free   |
      | Total:              | $377.79         |
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
      | Total Charge                                 |           |          | $2,265.89 |
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
      | Total Charge                                   |         |          | $251.79 |
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
      | period | base plan | country       | billing country | addl storage | addl computers | coupon       | cc number        |
      | 1      | 50 GB     | United States | France          | 99           | 2              | 10percentoff | 4485393141463880 |
    # need to update 24 months at 10.0% off when the bug is fixed
    Then the billing summary looks like:
      | Description                           | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99   | 1        | $5.99   |
      | 20 Additional Storage - Monthly       | $2.00   | 99       | $198.00 |
      | Additional Computers - Monthly        | $2.00   | 2        | $4.00   |
      | Subscription Price                    | $207.99 |          | $207.99 |
      | 1 month at 10.0% off                  | $-20.79 |          | $-20.79 |
      | Total Charge                          |         |          | $187.20 |
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
      | Total:              | $4,367.79              |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 1.9 TB            |
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
      | period | base plan | country       | billing country | cc number        |
      | 12     | 50 GB     | United States | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | $65.89 | 1        | $65.89 |
      | Total Charge                         |        |          | $65.89 |
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
      | period | base plan | addl computers | country       | billing country | cc number        |
      | 24     | 50 GB     | 4              | United States | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Additional Computers - Biennial        | $42.00  | 4        | $168.00 |
      | Total Charge                           |         |          | $293.79 |
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
      | period | base plan | addl computers | addl storage | country       | billing country | cc number        |
      | 1      | 125 GB    | 2              | 10           | United States | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                   | Price  | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99  | 1        | $9.99  |
      | 20 Additional Storage - Monthly               | $2.00  | 10       | $20.00 |
      | Additional Computers - Monthly                | $2.00  | 2        | $4.00  |
      | Total Charge                                  |        |          | $33.99 |
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
      | period | base plan | addl storage | addl computers | country       | billing country | cc number        |
      | 12     | 125 GB    | 10           | 2              | United States | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | 20 Additional Storage - Annual               | $22.00  | 10       | $220.00 |
      | Additional Computers - Annual                | $22.00  | 2        | $44.00  |
      | Total Charge                                 |         |          | $373.89 |
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
      | period | base plan | country       | billing country | cc number        |
      | 24     | 125 GB    | United States | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | Total Charge                                   |         |          | $209.79 |
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
      | period | base plan | addl storage | addl computers | country       | billing country | cc number        |
      | 1      | 50 GB     | 30           | 2              | United States | China           | 4357441111111222 |
    Then the billing summary looks like:
      | Description                           | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99  | 1        | $5.99  |
      | 20 Additional Storage - Monthly       | $2.00  | 30       | $60.00 |
      | Additional Computers - Monthly        | $2.00  | 2        | $4.00  |
      | Total Charge                          |        |          | $69.99 |
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
      | Base Plan:          | MozyHome 50 GB  |
      | Additional Storage: | 200 GB          |
      | Computers:          | 2               |
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
      | period | base plan | addl computers | country       | billing country | cc number        |
      | 12     | 50 GB     | 2              | United States | China           | 4357441111111222 |
    Then the billing summary looks like:
      | Description                          | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Annual | $65.89  | 1        | $65.89  |
      | Additional Computers - Annual        | $22.00  | 2        | $44.00  |
      | Total Charge                         |         |          | $109.89 |
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

  @TC.2300021 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 2300021 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 24     | 50 GB     | United States | China           | 4357441111111222 |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Total Charge                           |         |          | $125.79 |
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
      | period | base plan | addl storage | addl computers | country       | billing country | cc number        |
      | 1      | 125 GB    | 4            | 2              | United States | China           | 4357441111111222 |
    Then the billing summary looks like:
      | Description                                   | Price  | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99  | 1        | $9.99  |
      | 20 Additional Storage - Monthly               | $2.00  | 4        | $8.00  |
      | Additional Computers - Monthly                | $2.00  | 2        | $4.00  |
      | Total Charge                                  |        |          | $21.99 |
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
      | period | base plan | addl storage | addl computers | country       | billing country | cc number        |
      | 12     | 125 GB    | 99           | 2              | United States | China           | 4357441111111222 |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount    |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89   |
      | 20 Additional Storage - Annual               | $22.00  | 99       | $2,178.00 |
      | Additional Computers - Annual                | $22.00  | 2        | $44.00    |
      | Total Charge                                 |         |          | $2,331.89 |
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
      | period | base plan | addl storage | addl computers | country       | billing country | cc number        |
      | 24     | 125 GB    | 1            | 1              | United States | China           | 4357441111111222 |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | 20 Additional Storage - Biennial               | $42.00  | 1        | $42.00  |
      | Additional Computers - Biennial                | $42.00  | 1        | $42.00  |
      | Total Charge                                   |         |          | $293.79 |
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
      | period | base plan | country       | billing country | cc number        |
      | 1      | 50 GB     | United States | China           | 4357441111111222 |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          |       |          | $5.99  |
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
      | period | base plan | country       | billing country | cc number        |
      | 12     | 50 GB     | United States | China           | 4357441111111222 |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | $65.89 | 1        | $65.89 |
      | Total Charge                         |        |          | $65.89 |
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
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 0 GB            |
      | Computers:          | 5               |
      | Subscription:       | Yearly          |
      | Term Discount:      | 1 month free    |
      | Total:              | $153.89         |
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
      | period | base plan | country       | billing country | cc number        |
      | 24     | 50 GB     | United States | China           | 4357441111111222 |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Total Charge                           |         |          | $125.79 |
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
      | period | base plan | country       | billing country | cc number        |
      | 1      | 125 GB    | United States | China           | 4357441111111222 |
    Then the billing summary looks like:
      | Description                                   | Price | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99 | 1        | $9.99  |
      | Total Charge                                  |       |          | $9.99  |
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

  @TC.2300029 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 2300029 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 12     | 125 GB    | United States | United States   | 4357441111111222 |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Total Charge                                 |         |          | $109.89 |
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
      | period | base plan | country       | billing country | cc number        |
      | 24     | 125 GB    | United States | China           | 4357441111111222 |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | Total Charge                                   |         |          | $209.79 |
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
      | period | base plan | addl storage | addl computers | country       | billing country | cc number        |
      | 1      | 50 GB     | 3            | 2              | United States | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                           | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99  | 1        | $5.99  |
      | 20 Additional Storage - Monthly       | $2.00  | 3        | $6.00  |
      | Additional Computers - Monthly        | $2.00  | 2        | $4.00  |
      | Total Charge                          |        |          | $15.99 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | computers | addl storage |
      | 125 GB    | 12     | 4         | 10           |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB     |
      | Additional Storage: | 10 x 20 GB = 200 GB |
      | Total Storage:      | 325 GB              |
      | Computers:          | 4                   |
      | Subscription:       | Yearly              |
      | Term Discount:      | 1 month free        |
      | Total:              | $351.89             |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 200 GB          |
      | Computers:          | 4               |
      | Subscription:       | Yearly          |
      | Term Discount:      | 1 month free    |
      | Total:              | $351.89         |
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
      | period | base plan | addl storage | addl computers | country       | billing country | cc number        |
      | 12     | 50 GB     | 10           | 2              | United States | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Annual | $65.89 | 1        | $65.89  |
      | 20 Additional Storage - Annual       | $22.00 | 10       | $220.00 |
      | Additional Computers - Annual        | $22.00 | 2        | $44.00  |
      | Total Charge                         |        |          | $329.89 |
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
      | Subscription:       | Biennial            |
      | Term Discount:      | 3 months free       |
      | Total:              | $713.79             |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 200 GB         |
      | Computers:          | 5              |
      | Subscription:       | Biennial       |
      | Term Discount:      | 3 months free  |
      | Total:              | $713.79        |
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
      | period | base plan | addl storage | country       | billing country | cc number        |
      | 24     | 50 GB     | 99           | United States | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount    |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79   |
      | 20 Additional Storage - Biennial       | $42.00  | 99       | $4,158.00 |
      | Total Charge                           |         |          | $4,283.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | addl storage |
      | 125 GB    | 0            |
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
  @TC.2300034 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=fr
  Scenario: 2300034 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 1      | 125 GB    | United States | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                   | Price | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99 | 1        | $9.99  |
      | Total Charge                                  |       |          | $9.99  |
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
      | period | base plan | addl storage | country       | billing country | cc number        |
      | 12     | 125 GB    | 4            | United States | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | 20 Additional Storage - Annual               | $22.00  | 4        | $88.00  |
      | Total Charge                                 |         |          | $197.89 |
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
      | Total:              | $377.79           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 80 GB          |
      | Computers:          | 3              |
      | Subscription:       | Biennial       |
      | Term Discount:      | 3 months free  |
      | Total:              | $377.79        |
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
      | period | base plan | addl computers | addl storage | country       | billing country | cc number        |
      | 24     | 125 GB    | 2              | 10           | United States | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | 20 Additional Storage - Biennial               | $42.00  | 10       | $420.00 |
      | Additional Computers - Biennial                | $42.00  | 2        | $84.00  |
      | Total Charge                                   |         |          | $713.79 |
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
