Feature: MozyHome user changes current plan in phoenix

  As a private citizen
  I want to create current plan through phoenix

  #Background:
  # info to be added here: coverage matrix

#---------------------------------------------------------------------------------
# precondition
# ssh root@phoenix01.qa6.mozyops.com  QAP@SSw0rd
# /var/www/phoenix/app/controllers/account_controller.rb
# /var/www/phoenix/app/controllers/registration_controller.rb
# IpCountry.country_with_ip(request.remote_ip)
# set to 'FR' if @ip_country=fr
# restart: /etc/init.d/apache2 restart
#---------------------------------------------------------------------------------

  #
  # 50 GB Cases
  #

  @TC.130001 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us @change_plan
  Scenario: 130001 Change plan for US monthly basic MozyHome user to 125 GB addl storage
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 1      | 50 GB     | United States | United States   | 4018121111111122  |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          |       |          | $5.99  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | base plan | addl storage |
      | 125 GB    | 2            |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB            |
      | Additional Storage: | 2 x 20 GB         |
      | Total Storage:      | 165 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Monthly           |
      | Next Billing: 	    | @1 month from now |
      | Total:              | $13.99            |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 40 GB             |
      | Computers:          | 3                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $13.99            |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130002 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us @change_plan
  Scenario: 130002 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 12     | 50 GB     | United States | United States   | 4018121111111122  |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | $65.89 | 1        | $65.89 |
      | Total Charge                         |        |          | $65.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | base plan | addl computers |
      | 125 GB    | 4              |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB           |
      | Additional Storage: | 0 x 20 GB        |
      | Total Storage:      | 125 GB           |
      | Computers:          | 4                |
      | Subscription:       | Yearly           |
      | Next Billing: 	    | @1 year from now |
      | Total:              | $131.89          |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 0 GB             |
      | Computers:          | 4                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $131.89           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130003 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us @change_plan
  Scenario: 130003 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 24     | 50 GB     | United States | United States   | 4018121111111122  |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Total Charge                           |         |          | $125.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | base plan | addl storage | addl computers |
      | 125 GB    | 3            | 4              |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB            |
      | Additional Storage: | 3 x 20 GB         |
      | Total Storage:      | 185 GB            |
      | Computers:          | 4                 |
      | Subscription:       | Biennial          |
      | Next Billing: 	    | @2 years from now |
      | Total:              | $377.79           |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 60 GB             |
      | Computers:          | 4                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Next Billing:       | @2 years from now |
      | Total:              | $377.79           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 GB Cases
  #
  @TC.130004 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us @change_plan
  Scenario: 130004 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 1      | 125 GB    | United States | United States   | 4018121111111122  |
    Then the billing summary looks like:
      | Description                                   | Price | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99 | 1        | $9.99  |
      | Total Charge                                  |       |          | $9.99  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl storage |
      | 10           |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB            |
      | Additional Storage: | 10 x 20 GB        |
      | Total Storage:      | 325 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Monthly           |
      | Next Billing: 	    | @1 month from now |
      | Total:              | $29.99            |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 200 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $29.99            |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130005 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us @change_plan
  Scenario: 130005 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 12     | 125 GB    | United States | United States   | 4018121111111122  |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Total Charge                                 |         |          | $109.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl computers |
      | 5              |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB           |
      | Additional Storage: | 0 x 20 GB        |
      | Total Storage:      | 125 GB           |
      | Computers:          | 5                |
      | Subscription:       | Yearly           |
      | Next Billing: 	    | @1 year from now |
      | Total:              | $153.89          |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 0 GB             |
      | Computers:          | 5                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $153.89          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130006 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us @change_plan
  Scenario: 130006 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 24     | 125 GB    | United States | United States   | 4018121111111122  |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | Total Charge                                   |         |          | $209.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl storage | addl computers |
      | 1            | 4              |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB            |
      | Additional Storage: | 1 x 20 GB         |
      | Total Storage:      | 145 GB            |
      | Computers:          | 4                 |
      | Subscription:       | Biennial          |
      | Next Billing: 	    | @2 years from now |
      | Total:              | $293.79           |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 20 GB             |
      | Computers:          | 4                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Next Billing:       | @2 years from now |
      | Total:              | $293.79           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 50 GB Cases
  #
  @TC.130007 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us @change_plan
  Scenario: 130007 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl storage | cc number        |
      | 1      | 50 GB     | United States | United States   | 1            | 4018121111111122  |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | 20 Additional Storage - Monthly       | $2.00 | 1        | $2.00  |
      | Total Charge                          |       |          | $7.99  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | base plan |
      | 125 GB    |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB            |
      | Additional Storage: | 1 x 20 GB         |
      | Total Storage:      | 145 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Monthly           |
      | Next Billing: 	    | @1 month from now |
      | Total:              | $11.99            |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 20 GB             |
      | Computers:          | 3                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $11.99            |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130008 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us @change_plan
  Scenario: 130008 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl computers | cc number        |
      | 12     | 50 GB     | United States | United States   | 1              | 4018121111111122  |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | $65.89 | 1        | $65.89 |
      | Additional Computers - Annual        | $22.00 | 1        | $22.00 |
      | Total Charge                         |        |          | $87.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | base plan | addl computers |
      | 125 GB    | 5              |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB           |
      | Additional Storage: | 0 x 20 GB        |
      | Total Storage:      | 125 GB           |
      | Computers:          | 5                |
      | Subscription:       | Yearly           |
      | Next Billing: 	    | @1 year from now |
      | Total:              | $153.89          |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 0 GB             |
      | Computers:          | 5                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $153.89          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user


  @TC.130009 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us @qa6_dependent @change_plan
  Scenario: 130009 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | coupon       | cc number        |
      | 24     | 50 GB     | United States | United States   | 10percentoff | 4018121111111122  |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Subscription Price                     | $125.79 |          | $125.79 |
      | 24 months at 10.0% off                 | $-12.57 |          | $-12.57 |
      | Total Charge                           |         |          | $113.22 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | base plan | addl storage |
      | 125 GB    | 10           |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB            |
      | Additional Storage: | 10 x 20 GB        |
      | Total Storage:      | 325 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Biennial          |
      | Next Billing: 	    | @2 years from now |
      | Total:              | $629.79           |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 200 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Next Billing:       | @2 years from now |
      | Total:              | $629.79           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 GB Cases
  #
  @TC.130010 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us @change_plan
  Scenario: 130010 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl storage | addl computers | cc number        |
      | 1      | 125 GB    | United States | United States   | 2            | 2              | 4018121111111122  |
    Then the billing summary looks like:
      | Description                                   | Price  | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99  | 1        | $9.99  |
      | 20 Additional Storage - Monthly               | $2.00  | 2        | $4.00  |
      | Additional Computers - Monthly                | $2.00  | 2        | $4.00  |
      | Total Charge                                  |        |          | $17.99 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl storage |
      | 3            |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB            |
      | Additional Storage: | 3 x 20 GB         |
      | Total Storage:      | 185 GB            |
      | Computers:          | 5                 |
      | Subscription:       | Monthly           |
      | Next Billing: 	    | @1 month from now |
      | Total:              | $19.99            |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 60 GB             |
      | Computers:          | 5                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $19.99            |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130011 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us @change_plan
  Scenario: 130011 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl storage | coupon       | cc number        |
      | 12     | 125 GB    | United States | United States   | 98           | 10percentoff | 4018121111111122  |
    Then the billing summary looks like:
      | Description                                  | Price     | Quantity | Amount    |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89   | 1        | $109.89   |
      | 20 Additional Storage - Annual               | $22.00    | 98       | $2,156.00 |
      | Subscription Price                           | $2,265.89 |          | $2,265.89 |
      | 12 months at 10.0% off                       | $-226.58  |          | $-226.58  |
      | Total Charge                                 |           |          | $2,039.31 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl storage |
      | 99           |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB           |
      | Additional Storage: | 99 x 20 GB       |
      | Total Storage:      | 2.1 TB           |
      | Computers:          | 3                |
      | Subscription:       | Yearly           |
      | Next Billing: 	    | @1 year from now |
      | Total:              | $2,287.89        |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 1.9 TB           |
      | Computers:          | 3                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $2,287.89        |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130012 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us @change_plan
  Scenario: 130012 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl computers | coupon       | cc number        |
      | 24     | 125 GB    | United States | United States   | 1              | 10percentoff | 4018121111111122  |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | Additional Computers - Biennial                | $42.00  | 1        | $42.00  |
      | Subscription Price                             | $251.79 |          | $251.79 |
      | 24 months at 10.0% off                         | $-25.17 |          | $-25.17 |
      | Total Charge                                   |         |          | $226.62 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl storage | addl computers |
      | 5            | 5              |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB            |
      | Additional Storage: | 5 x 20 GB         |
      | Total Storage:      | 225 GB            |
      | Computers:          | 5                 |
      | Subscription:       | Biennial          |
      | Next Billing: 	    | @2 years from now |
      | Total:              | $503.79           |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 100 GB            |
      | Computers:          | 5                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Next Billing:       | @2 years from now |
      | Total:              | $503.79           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 50 GB Cases
  #
  @TC.130013 @BUG.128707 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr @change_plan
  Scenario: 130013 Add a new US monthly basic MozyHome user
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
      | 1 month at 10.0% off                 | $-20.79 |          | $-20.79 |
      | Total Charge                          |         |          | $187.20 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | base plan |
      | 125 GB    |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB            |
      | Additional Storage: | 99 x 20 GB        |
      | Total Storage:      | 2.1 TB            |
      | Computers:          | 3                 |
      | Subscription:       | Monthly           |
      | Next Billing: 	    | @1 month from now |
      | Total:              | $207.99           |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 1.9 TB            |
      | Computers:          | 3                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $207.99           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130014 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr @change_plan
  Scenario: 130014 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 12     | 50 GB     | United States | France          | 4485393141463880  |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | $65.89 | 1        | $65.89 |
      | Total Charge                         |        |          | $65.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | base plan | addl storage |
      | 125 GB    | 99           |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB           |
      | Additional Storage: | 99 x 20 GB       |
      | Total Storage:      | 2.1 TB           |
      | Computers:          | 3                |
      | Subscription:       | Yearly           |
      | Next Billing: 	    | @1 year from now |
      | Total:              | $2,287.89        |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 1.9 TB           |
      | Computers:          | 3                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $2,287.89        |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130015 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr @change_plan
  Scenario: 130015 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 24     | 50 GB     | United States | France          | 4485393141463880  |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Total Charge                           |         |          | $125.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | base plan | addl computers |
      | 125 GB    | 5              |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB            |
      | Additional Storage: | 0 x 20 GB         |
      | Total Storage:      | 125 GB            |
      | Computers:          | 5                 |
      | Subscription:       | Biennial          |
      | Next Billing: 	    | @2 years from now |
      | Total:              | $293.79           |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 0 GB              |
      | Computers:          | 5                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Next Billing:       | @2 years from now |
      | Total:              | $293.79           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 GB Cases
  #
  @TC.130016 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr @change_plan
  Scenario: 130016 Add a new US monthly basic MozyHome user
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
    And I upgrade my user account to:
      | addl computers |
      | 4              |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB            |
      | Additional Storage: | 0 x 20 GB         |
      | Total Storage:      | 125 GB            |
      | Computers:          | 4                 |
      | Subscription:       | Monthly           |
      | Next Billing: 	    | @1 month from now |
      | Total:              | $11.99            |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 0 GB              |
      | Computers:          | 4                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $11.99            |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130017 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr @change_plan
  Scenario: 130017 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 12     | 125 GB    | United States | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Total Charge                                 |         |          | $109.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl computers | addl storage |
      | 4              | 5            |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB           |
      | Additional Storage: | 5 x 20 GB        |
      | Total Storage:      | 225 GB           |
      | Computers:          | 4                |
      | Subscription:       | Yearly           |
      | Next Billing: 	    | @1 year from now |
      | Total:              | $241.89          |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 100 GB           |
      | Computers:          | 4                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $241.89          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130018 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr @change_plan
  Scenario: 130018 Add a new US biennial basic MozyHome user
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
    And I upgrade my user account to:
      | addl storage |
      | 2            |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB            |
      | Additional Storage: | 2 x 20 GB         |
      | Total Storage:      | 165 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Biennial          |
      | Next Billing: 	    | @2 years from now |
      | Total:              | $293.79           |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 40 GB             |
      | Computers:          | 3                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Next Billing:       | @2 years from now |
      | Total:              | $293.79           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 50 GB Cases
  #
  @TC.130019 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn @change_plan
  Scenario: 130019 Add a new US monthly basic MozyHome user
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
    And I upgrade my user account to:
      | addl computers | addl storage |
      | 2              | 2            |
    And the payment details summary looks like:
      | Base Plan:       	| 50 GB             |
      | Additional Storage: | 2 x 20 GB         |
      | Total Storage:      | 90 GB             |
      | Computers:          | 2                 |
      | Subscription:       | Monthly           |
      | Next Billing: 	    | @1 month from now |
      | Total:              | $11.99            |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 50 GB    |
      | Additional Storage: | 40 GB             |
      | Computers:          | 2                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $11.99            |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130020 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn @change_plan
  Scenario: 130020 Add a new US yearly basic MozyHome user
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
    And I upgrade my user account to:
      | base plan | addl computers |
      | 125 GB    | 5              |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB           |
      | Additional Storage: | 0 x 20 GB        |
      | Total Storage:      | 125 GB           |
      | Computers:          | 5                |
      | Subscription:       | Yearly           |
      | Next Billing: 	    | @1 year from now |
      | Total:              | $153.89          |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 0 GB             |
      | Computers:          | 5                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $153.89          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130021 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn @change_plan
  Scenario: 130021 Add a new US biennial basic MozyHome user
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
    And I upgrade my user account to:
      | base plan | addl storage |
      | 125 GB    | 99           |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB            |
      | Additional Storage: | 99 x 20 GB        |
      | Total Storage:      | 2.1 TB            |
      | Computers:          | 3                 |
      | Subscription:       | Biennial          |
      | Next Billing: 	    | @2 years from now |
      | Total:              | $4,367.79         |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 1.9 TB            |
      | Computers:          | 3                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Next Billing:       | @2 years from now |
      | Total:              | $4,367.79         |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 GB Cases
  #
  @TC.130022 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn @change_plan
  Scenario: 130022 Add a new US monthly basic MozyHome user
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
    And I upgrade my user account to:
      | addl storage |
      | 10           |
    And the payment details summary looks like:
      | Base Plan:          | 125 GB            |
      | Additional Storage: | 10 x 20 GB        |
      | Total Storage:      | 325 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Monthly           |
      | Next Billing: 	    | @1 month from now |
      | Total:              | $29.99            |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 200 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $29.99            |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130023 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn @change_plan
  Scenario: 130023 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 12     | 125 GB    | United States | China           | 4357441111111222 |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Total Charge                                 |         |          | $109.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl storage |
      | 3            |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB           |
      | Additional Storage: | 3 x 20 GB        |
      | Total Storage:      | 185 GB           |
      | Computers:          | 3                |
      | Subscription:       | Yearly           |
      | Next Billing: 	    | @1 year from now |
      | Total:              | $175.89          |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 60 GB            |
      | Computers:          | 3                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $175.89          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130024 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn @change_plan
  Scenario: 130024 Add a new US biennial basic MozyHome user
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
    And I upgrade my user account to:
      | addl computers | addl storage |
      | 4              | 14           |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB            |
      | Additional Storage: | 14 x 20 GB        |
      | Total Storage:      | 405 GB            |
      | Computers:          | 4                 |
      | Subscription:       | Biennial          |
      | Next Billing: 	    | @2 years from now |
      | Total:              | $839.79           |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 280 GB            |
      | Computers:          | 4                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Next Billing:       | @2 years from now |
      | Total:              | $839.79           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user
  #
  # 50 GB Cases
  #
  @TC.130025 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn @change_plan
  Scenario: 130025 Add a new US monthly basic MozyHome user
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
    And I upgrade my user account to:
      | addl storage |
      | 7            |
    And the payment details summary looks like:
      | Base Plan:          | 50 GB             |
      | Additional Storage: | 7 x 20 GB         |
      | Total Storage:      | 190 GB            |
      | Computers:          | 1                 |
      | Subscription:       | Monthly           |
      | Next Billing: 	    | @1 month from now |
      | Total:              | $19.99            |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 50 GB    |
      | Additional Storage: | 140 GB            |
      | Computers:          | 1                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $19.99            |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130026 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn @change_plan
  Scenario: 130026 Add a new US yearly basic MozyHome user
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
    And I upgrade my user account to:
      | base plan |
      | 125       |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB           |
      | Additional Storage: | 0 x 20 GB        |
      | Total Storage:      | 125 GB           |
      | Computers:          | 3                |
      | Subscription:       | Yearly           |
      | Next Billing: 	    | @1 year from now |
      | Total:              | $109.89          |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 0 GB             |
      | Computers:          | 3                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $109.89          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130027 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn @change_plan
  Scenario: 130027 Add a new US biennial basic MozyHome user
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
    And I upgrade my user account to:
      | base plan | addl computers | addl storage |
      | 125 GB    | 4              | 11           |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB           |
      | Additional Storage: | 11 x 20 GB        |
      | Total Storage:      | 345 GB            |
      | Computers:          | 4                 |
      | Subscription:       | Biennial          |
      | Next Billing: 	    | @2 years from now |
      | Total:              | $713.79           |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 220 GB            |
      | Computers:          | 4                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Next Billing:       | @2 years from now |
      | Total:              | $713.79           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 GB Cases
  #
  @TC.130028 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn @change_plan
  Scenario: 130028 Add a new US monthly basic MozyHome user
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
    And I upgrade my user account to:
      | addl computers |
      | 4              |
    And the payment details summary looks like:
      | Base Plan:          | 125 GB           |
      | Additional Storage: | 0 x 20 GB         |
      | Total Storage:      | 125 GB            |
      | Computers:          | 4                 |
      | Subscription:       | Monthly           |
      | Next Billing: 	    | @1 month from now |
      | Total:              | $11.99            |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 0 GB              |
      | Computers:          | 4                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $11.99            |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130029 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn @change_plan
  Scenario: 130029 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 12     | 125 GB    | United States | China           | 4357441111111222 |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Total Charge                                 |         |          | $109.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl computers | addl storage |
      | 5              | 20           |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB           |
      | Additional Storage: | 20 x 20 GB       |
      | Total Storage:      | 525 GB           |
      | Computers:          | 5                |
      | Subscription:       | Yearly           |
      | Next Billing: 	    | @1 year from now |
      | Total:              | $593.89          |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 400 GB           |
      | Computers:          | 5                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $593.89          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130030 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn @change_plan
  Scenario: 130030 Add a new US biennial basic MozyHome user
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
    And I upgrade my user account to:
      | addl computers |
      | 4              |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB            |
      | Additional Storage: | 0 x 20 GB         |
      | Total Storage:      | 125 GB            |
      | Computers:          | 4                 |
      | Subscription:       | Biennial          |
      | Next Billing: 	    | @2 years from now |
      | Total:              | $251.79           |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 0 GB              |
      | Computers:          | 4                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Next Billing:       | @2 years from now |
      | Total:              | $251.79           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 50 GB Cases
  #
  @TC.130031 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=fr @change_plan
  Scenario: 130031 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 1      | 50 GB     | United States | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          |       |          | $5.99  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | base plan |
      | 125 GB    |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB            |
      | Additional Storage: | 0 x 20 GB         |
      | Total Storage:      | 125 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Monthly           |
      | Next Billing: 	    | @1 month from now |
      | Total:              | $9.99             |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 0 GB              |
      | Computers:          | 3                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $9.99             |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130032 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=fr @change_plan
  Scenario: 130032 Add a new US yearly basic MozyHome user
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
    And I upgrade my user account to:
      | addl storage |
      | 99           |
    And the payment details summary looks like:
      | Base Plan:          | 50 GB            |
      | Additional Storage: | 99 x 20 GB       |
      | Total Storage:      | 2 TB             |
      | Computers:          | 1                |
      | Subscription:       | Yearly           |
      | Next Billing: 	    | @1 year from now |
      | Total:              | $2,243.89        |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 1.9 TB           |
      | Computers:          | 1                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $2,243.89        |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130033 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=fr @change_plan
  Scenario: 130033 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 24     | 50 GB     | United States | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Total Charge                           |         |          | $125.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl computers | addl storage |
      | 2              | 2            |
    And the payment details summary looks like:
      | Base Plan:          | 50 GB             |
      | Additional Storage: | 2 x 20 GB         |
      | Total Storage:      | 90 GB             |
      | Computers:          | 2                 |
      | Subscription:       | Biennial          |
      | Next Billing: 	    | @2 years from now |
      | Total:              | $251.79           |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 50 GB    |
      | Additional Storage: | 40 GB             |
      | Computers:          | 2                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Next Billing:       | @2 years from now |
      | Total:              | $251.79           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 GB Cases
  #
  @TC.130034 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=fr @change_plan
  Scenario: 130034 Add a new US monthly basic MozyHome user
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
    And I upgrade my user account to:
      | addl computers | addl storage |
      | 4              | 31           |
    And the payment details summary looks like:
      | Base Plan:          | 125 GB            |
      | Additional Storage: | 31 x 20 GB        |
      | Total Storage:      | 745 GB            |
      | Computers:          | 4                 |
      | Subscription:       | Monthly           |
      | Next Billing: 	    | @1 month from now |
      | Total:              | $73.99            |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 620 GB            |
      | Computers:          | 4                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $73.99            |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130035 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=fr @change_plan
  Scenario: 130035 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 12     | 125 GB    | United States | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Total Charge                                 |         |          | $109.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl computers |
      | 5              |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB           |
      | Additional Storage: | 0 x 20 GB        |
      | Total Storage:      | 125 GB           |
      | Computers:          | 5                |
      | Subscription:       | Yearly           |
      | Next Billing: 	    | @1 year from now |
      | Total:              | $153.89          |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 0 GB             |
      | Computers:          | 5                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $153.89          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130036 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=fr @change_plan
  Scenario: 130036 Add a new US biennial basic MozyHome user
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
    And I upgrade my user account to:
      | addl storage |
      | 2            |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB            |
      | Additional Storage: | 2 x 20 GB         |
      | Total Storage:      | 165 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Biennial          |
      | Next Billing: 	    | @2 years from now |
      | Total:              | $293.79           |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 40 GB             |
      | Computers:          | 3                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Next Billing:       | @2 years from now |
      | Total:              | $293.79           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user