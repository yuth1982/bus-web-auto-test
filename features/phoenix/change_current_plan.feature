Feature: Add a new user through phoenix

  As a private citizen
  I want to create a user account through phoenix
  So that I can organize my personal life in a way that works for me

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
  @TC.130001 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 130001 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 1      | 50 GB     | United States | United States   |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          | $5.99 |          | $5.99  |
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

  @TC.130002 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 130002 Add a new US yearly basic MozyHome user
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

  @TC.130003 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 130003 Add a new US biennial basic MozyHome user
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
  @TC.130004 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 130004 Add a new US monthly basic MozyHome user
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

  @TC.130005 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 130005 Add a new US yearly basic MozyHome user
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

  @TC.130006 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 130006 Add a new US biennial basic MozyHome user
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
  @TC.130007 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: 130007 Add a new US monthly basic MozyHome user
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

  @TC.130008 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: 130008 Add a new US yearly basic MozyHome user
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


  @TC.130009 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us @qa6_dependent
  Scenario: 130009 Add a new US biennial basic MozyHome user
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
  @TC.130010 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: 130010 Add a new US monthly basic MozyHome user
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

  @TC.130011 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: 130011 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl storage | coupon       |
      | 12     | 125 GB    | United States | United States   | 98           | 10percentoff |
    Then the billing summary looks like:
      | Description                                  | Price     | Quantity | Amount    |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89   | 1        | $109.89   |
      | 20 Additional Storage - Annual               | $22.00    | 98       | $2,156.00 |
      | Subscription Price                           | $2,265.89 |          | $2,265.89 |
      | 12 months at 10.0% off                       | $-226.58  |          | $-226.58  |
      | Total Charge                                 | $2,039.31 |          | $2,039.31 |
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

  @TC.130012 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: 130012 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl computers | coupon       |
      | 24     | 125 GB    | United States | United States   | 1              | 10percentoff |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | Additional Computers - Biennial                | $42.00  | 1        | $42.00  |
      | Subscription Price                             | $251.79 |          | $251.79 |
      | 24 months at 10.0% off                         | $-25.17 |          | $-25.17 |
      | Total Charge                                   | $226.62 |          | $226.62 |
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
  @TC.130013 @BUG.128707 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr
  Scenario: 130013 Add a new US monthly basic MozyHome user
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

  @TC.130014 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr
  Scenario: 130014 Add a new US yearly basic MozyHome user
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

  @TC.130015 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr
  Scenario: 130015 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 24     | 50 GB     | United States | France          |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Total Charge                           | $125.79 |          | $125.79 |
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
  @TC.130016 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr
  Scenario: 130016 Add a new US monthly basic MozyHome user
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

  @TC.130017 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr
  Scenario: 130017 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 12     | 125 GB    | United States | France          |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Total Charge                                 | $109.89 |          | $109.89 |
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

  @TC.130018 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=fr
  Scenario: 130018 Add a new US biennial basic MozyHome user
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
  @TC.130019 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 130019 Add a new US monthly basic MozyHome user
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

  @TC.130020 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 130020 Add a new US yearly basic MozyHome user
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

  @TC.130021 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 130021 Add a new US biennial basic MozyHome user
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
    And the current   summary looks like:
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
  @TC.130022 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 130022 Add a new US monthly basic MozyHome user
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

  @TC.130023 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 130023 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 12     | 125 GB    | United States | China           |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Total Charge                                 | $109.89 |          | $109.89 |
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

  @TC.130024 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 130024 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 24     | 125 GB    | United States | China           |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | Total Charge                                   | $209.79 |          | $209.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl computers | addl storage |
      | 4              | 14           |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB           |
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
  @TC.130025 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 130025 Add a new US monthly basic MozyHome user
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

  @TC.130026 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 130026 Add a new US yearly basic MozyHome user
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

  @TC.130027 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 130027 Add a new US biennial basic MozyHome user
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
  @TC.130028 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 130028 Add a new US monthly basic MozyHome user
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

  @TC.130029 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 130029 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 12     | 125 GB    | United States | China           |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Total Charge                                 | $109.89 |          | $109.89 |
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

  @TC.130030 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 130030 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 24     | 125 GB    | United States | China           |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | Total Charge                                   | $209.79 |          | $209.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl computers |
      | 4              |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB           |
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
  @TC.130031 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=fr
  Scenario: 130031 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 1      | 50 GB     | United States | France          |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          | $5.99 |          | $5.99  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | base plan |
      | 125 GB    |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB           |
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

  @TC.130032 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=fr
  Scenario: 130032 Add a new US yearly basic MozyHome user
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
    And I upgrade my user account to:
      | addl storage |
      | 99           |
    And the payment details summary looks like:
      | Base Plan:          | 50 GB            |
      | Additional Storage: | 99 x 20 GB       |
      | Total Storage:      | 2.0 TB           |
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

  @TC.130033 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=fr
  Scenario: 130033 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 24     | 50 GB     | United States | France          |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Total Charge                           | $125.79 |          | $125.79 |
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
      | Base Plan:          | MozyHome 125 GB   |
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
  @TC.130034 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=fr
  Scenario: 130034 Add a new US monthly basic MozyHome user
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
      | Total:              | $77.99            |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 620 GB            |
      | Computers:          | 4                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $77.99            |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.130035 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=fr
  Scenario: 130035 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 12     | 125 GB    | United States | France          |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Total Charge                                 | $109.89 |          | $109.89 |
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

  @TC.130036 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=fr
  Scenario: 130036 Add a new US biennial basic MozyHome user
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
    And I upgrade my user account to:
      | addl storage |
      | 2            |
    And the payment details summary looks like:
      | Base Plan:       	| 125 GB           |
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
  # 50 Go Cases
  #
  @TC.137001 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 137001 Add a new FR monthly basic MozyHome user
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
    And I upgrade my user account to:
      | base plan |
      | 125 Go    |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go            |
      | Espace de stockage supplémentaire :| 0 x 20 Go         |
      | Espace total de stockage :         | 125 Go            |
      | Ordinateurs :                      | 3                 |
      | Abonnement :                       | Mensuel           |
      | Prochaine facture :                | @1 month from now |
      | Montant: 	                       | 7,49€             |
      | VAT Rate (20.0%):                  | 1,50€             |
      | Total : 	                       | 8,99€             |
      | Prorated Cost: 	                   | 3,33€             |
      | VAT Rate (20.0%):                  | 0,67€             |
      | Total : 	                       | 4,00€             |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 125 Go   |
      | Espace de stockage supplémentaire : | 0 Go              |
      | Ordinateurs : 	                    | 3                 |
      | Abonnement : 	                    | Mensuel           |
      | Prochaine facture :                 | @1 month from now |
      | Montant: 	                        | 7,49€             |
      | VAT Rate (20.0%): 	                | 1,50€             |
      | Total :                             | 8,99€             |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.137002 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 137002 Add a new FR yearly basic MozyHome user
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
    And I upgrade my user account to:
      | base plan |
      | 125 GB    |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go           |
      | Espace de stockage supplémentaire :| 0 x 20 Go        |
      | Espace total de stockage :         | 125 Go           |
      | Ordinateurs :                      | 3                |
      | Abonnement :                       | Annuel           |
      | Remise : 	                       | 1 mois gratuit   |
      | Prochaine facture :                | @1 year from now |
      | Montant: 	                       | 82,41€           |
      | VAT Rate (20.0%):                  | 16,48€           |
      | Total : 	                       | 98,89€           |
      | Prorated Cost: 	                   | 36,67€           |
      | VAT Rate (20.0%):                  | 7,33€            |
      | Total : 	                       | 44,00€           |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 0 Go             |
      | Ordinateurs : 	                    | 3                |
      | Abonnement : 	                    | Annuel           |
      | Remise : 	                        | 1 mois gratuit   |
      | Prochaine facture :                 | @1 year from now |
      | Montant: 	                        | 82,41€           |
      | VAT Rate (20.0%): 	                | 16,48€           |
      | Total :                             | 98,89€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.137003 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 137003 Add a new FR biennial basic MozyHome user
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
    And I upgrade my user account to:
      | addl computers | addl storage |
      | 5              | 2            |
    And the payment details summary looks like:
      | Plan de base :                     | 50 Go             |
      | Espace de stockage supplémentaire :| 2 x 20 Go         |
      | Espace total de stockage :         | 90 Go             |
      | Ordinateurs :                      | 5                 |
      | Abonnement :                       | Bisannuel         |
      | Remise : 	                       | 3 mois gratuits   |
      | Prochaine facture :                | @2 years from now |
      | Montant: 	                       | 179,17€           |
      | VAT Rate (20.0%):                  | 35,83€            |
      | Total : 	                       | 215,00€           |
      | Prorated Cost: 	                   | 91,85€            |
      | VAT Rate (20.0%):                  | 18,37€            |
      | Total : 	                       | 110,22€           |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 125 Go   |
      | Espace de stockage supplémentaire : | 40 Go             |
      | Ordinateurs : 	                    | 5                 |
      | Abonnement : 	                    | Bisannuel         |
      | Remise : 	                        | 3 mois gratuits   |
      | Prochaine facture :                 | @2 years from now |
      | Montant: 	                        | 179,17€           |
      | VAT Rate (20.0%): 	                | 35,83€            |
      | Total :                             | 215,00€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 Go Cases
  #
  @TC.137004 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 137004 Add a new FR monthly basic MozyHome user
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
    And I upgrade my user account to:
      | addl storage |
      | 99           |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go            |
      | Espace de stockage supplémentaire :| 99 x 20 Go        |
      | Espace total de stockage :         | 2,1 To            |
      | Ordinateurs :                      | 3                 |
      | Abonnement :                       | Mensuel           |
      | Prochaine facture :                | @1 month from now |
      | Montant: 	                       | 172,82€           |
      | VAT Rate (20.0%):                  | 34,56€            |
      | Total : 	                       | 207,38€           |
      | Prorated Cost: 	                   | 165,33€           |
      | VAT Rate (20.0%):                  | 33,07€            |
      | Total : 	                       | 198,40€           |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 125 Go   |
      | Espace de stockage supplémentaire : | 1,9 To            |
      | Ordinateurs : 	                    | 3                 |
      | Abonnement : 	                    | Mensuel           |
      | Prochaine facture :                 | @1 month from now |
      | Montant: 	                        | 172,82€           |
      | VAT Rate (20.0%): 	                | 34,56€            |
      | Total :                             | 207,38€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.137005 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 137005 Add a new FR yearly basic MozyHome user
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
    And I upgrade my user account to:
      | addl computers |
      | 4              |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go           |
      | Espace de stockage supplémentaire :| 0 x 20 Go        |
      | Espace total de stockage :         | 125 Go           |
      | Ordinateurs :                      | 4                |
      | Abonnement :                       | Annuel           |
      | Remise : 	                       | 1 mois gratuit   |
      | Prochaine facture :                | @1 year from now |
      | Montant: 	                       | 100,78€          |
      | VAT Rate (20.0%):                  | 20,16€           |
      | Total : 	                       | 120,94€          |
      | Prorated Cost: 	                   | 18,37€           |
      | VAT Rate (20.0%):                  | 3,67€            |
      | Total : 	                       | 22,04€           |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 0 Go             |
      | Ordinateurs : 	                    | 4                |
      | Abonnement : 	                    | Annuel           |
      | Remise : 	                        | 1 mois gratuit   |
      | Prochaine facture :                 | @1 year from now |
      | Montant: 	                        | 100,78€          |
      | VAT Rate (20.0%): 	                | 20,16€           |
      | Total :                             | 120,94€          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.137006 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 137006 Add a new FR biennial basic MozyHome user
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
    And I upgrade my user account to:
      | addl computers | addl storage |
      | 5              | 5            |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go            |
      | Espace de stockage supplémentaire :| 5 x 20 Go         |
      | Espace total de stockage :         | 225 Go            |
      | Ordinateurs :                      | 5                 |
      | Abonnement :                       | Bisannuel         |
      | Remise : 	                       | 3 mois gratuits   |
      | Prochaine facture :                | @2 years from now |
      | Montant: 	                       | 402,81€           |
      | VAT Rate (20.0%):                  | 80,56€            |
      | Total : 	                       | 483,37€           |
      | Prorated Cost: 	                   | 245,49€           |
      | VAT Rate (20.0%):                  | 49,10€            |
      | Total : 	                       | 294,59€           |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 125 Go   |
      | Espace de stockage supplémentaire : | 100 Go            |
      | Ordinateurs : 	                    | 5                 |
      | Abonnement : 	                    | Bisannuel         |
      | Remise : 	                        | 3 mois gratuits   |
      | Prochaine facture :                 | @2 years from now |
      | Montant: 	                        | 402,81€           |
      | VAT Rate (20.0%): 	                | 80,56€            |
      | Total :                             | 483,37€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 50 Go Cases
  #
  @TC.137007 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 137007 Add a new FR monthly basic MozyHome user
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
    And I upgrade my user account to:
      | base plan | addl storage |
      | 125 Go    | 2            |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go            |
      | Espace de stockage supplémentaire :| 2 x 20 Go         |
      | Espace total de stockage :         | 165 Go            |
      | Ordinateurs :                      | 3                 |
      | Abonnement :                       | Mensuel           |
      | Prochaine facture :                | @1 month from now |
      | Montant: 	                       | 10,83€            |
      | VAT Rate (20.0%):                  | 2,17€             |
      | Total : 	                       | 13,00€            |
      | Prorated Cost: 	                   | 5,01€             |
      | VAT Rate (20.0%):                  | 1,00€             |
      | Total : 	                       | 6,01€             |
    And the current plan summary looks like:
      | Plan de base :                    	| MozyHome 125 Go   |
      | Espace de stockage supplémentaire : | 40 Go             |
      | Ordinateurs : 	                    | 3                 |
      | Abonnement : 	                    | Mensuel           |
      | Prochaine facture :                 | @1 month from now |
      | Montant: 	                        | 10,83€            |
      | VAT Rate (20.0%): 	                | 2,17€             |
      | Total :                             | 13,00€            |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.137008 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 137008 Add a new fr yearly basic MozyHome user
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
    And I upgrade my user account to:
      | addl computers |
      | 5              |
    And the payment details summary looks like:
      | Plan de base :                     | 50 Go            |
      | Espace de stockage supplémentaire :| 0 x 20 Go        |
      | Espace total de stockage :         | 125 Go           |
      | Ordinateurs :                      | 5                |
      | Abonnement :                       | Annuel           |
      | Remise : 	                       | 1 mois gratuit   |
      | Prochaine facture :                | @1 year from now |
      | Montant: 	                       | 119,22€          |
      | VAT Rate (20.0%):                  | 23,84€           |
      | Total : 	                       | 143,06€          |
      | Prorated Cost: 	                   | 55,11€           |
      | VAT Rate (20.0%):                  | 110,22€          |
      | Total : 	                       | 165,33€          |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 50 Go   |
      | Espace de stockage supplémentaire : | 0 Go             |
      | Ordinateurs : 	                    | 5                |
      | Abonnement : 	                    | Annuel           |
      | Remise : 	                        | 1 mois gratuit   |
      | Prochaine facture :                 | @1 year from now |
      | Montant: 	                        | 119,22€          |
      | VAT Rate (20.0%): 	                | 23,84€           |
      | Total :                             | 143,06€          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.137009 @BUG.128707 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk @qa6_dependent
  Scenario: 137009 Add a new FR biennial basic MozyHome user
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
    And I upgrade my user account to:
      | base plan |
      | 125 GB    |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go            |
      | Espace de stockage supplémentaire :| 0 x 20 Go         |
      | Espace total de stockage :         | 125 Go            |
      | Ordinateurs :                      | 3                 |
      | Abonnement :                       | Bisnnuel          |
      | Remise : 	                       | 3 mois gratuits   |
      | Prochaine facture :                | @2 years from now |
      | Montant: 	                       | 157,32€           |
      | VAT Rate (20.0%):                  | 31,46€            |
      | Total : 	                       | 188,78€           |
      | Prorated Cost: 	                   | 101,46€           |
      | VAT Rate (20.0%):                  | 20,29€            |
      | Total : 	                       | 121,75€           |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 125 Go   |
      | Espace de stockage supplémentaire : | 0 Go              |
      | Ordinateurs : 	                    | 3                 |
      | Abonnement : 	                    | Bisnnuel          |
      | Remise : 	                        | 3 mois gratuits   |
      | Prochaine facture :                 | @2 years from now |
      | Montant: 	                        | 157,32€           |
      | VAT Rate (20.0%): 	                | 31,46€            |
      | Total :                             | 188,78€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 Go Cases
  #
  @TC.137010 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 137010 Add a new FR monthly basic MozyHome user
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
    And I upgrade my user account to:
      | addl computers | addl storage |
      | 4              | 10           |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go            |
      | Espace de stockage supplémentaire :| 10 x 20 Go        |
      | Espace total de stockage :         | 325 Go            |
      | Ordinateurs :                      | 4                 |
      | Abonnement :                       | Mensuel           |
      | Prochaine facture :                | @1 month from now |
      | Montant: 	                       | 22,53€            |
      | VAT Rate (20.0%):                  | 4,52€             |
      | Total : 	                       | 27,05€            |
      | Prorated Cost: 	                   | 8,37€             |
      | VAT Rate (20.0%):                  | 1,67€             |
      | Total : 	                       | 10,04€            |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 125 Go   |
      | Espace de stockage supplémentaire : | 200 Go            |
      | Ordinateurs : 	                    | 4                 |
      | Abonnement : 	                    | Mensuel           |
      | Prochaine facture :                 | @1 month from now |
      | Montant: 	                        | 22,53€            |
      | VAT Rate (20.0%): 	                | 4,52€             |
      | Total :                             | 27,05€            |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.137011 @BUG.128707 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk @qa6_dependent
  Scenario: 137011 Add a new FR yearly basic MozyHome user
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
    And I upgrade my user account to:
      | addl computers |
      | 5              |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go           |
      | Espace de stockage supplémentaire :| 98 x 20 Go       |
      | Espace total de stockage :         | 2 To             |
      | Ordinateurs :                      | 5                |
      | Abonnement :                       | Annuel           |
      | Remise : 	                       | 1 mois gratuit   |
      | Prochaine facture :                | @1 year from now |
      | Montant: 	                       | 1 915,74€        |
      | VAT Rate (20.0%):                  | 383,15€          |
      | Total : 	                       | 2 298,89€        |
      | Prorated Cost: 	                   | 36,74€           |
      | VAT Rate (20.0%):                  | 7,35€            |
      | Total : 	                       | 44,09€           |
    And the current plan summary looks like:
      | Plan de base :                  	| MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 1 980 Go             |
      | Ordinateurs : 	                    | 5                |
      | Abonnement : 	                    | Annuel           |
      | Remise : 	                        | 1 mois gratuit   |
      | Prochaine facture :                 | @1 year from now |
      | Montant: 	                        | 1 915,74€        |
      | VAT Rate (20.0%): 	                | 383,15€          |
      | Total :                             | 2 298,89€        |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.137012 @BUG.128707 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk @qa6_dependent
  Scenario: 137012 Add a new FR biennial basic MozyHome user
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
    And I upgrade my user account to:
      | addl storage |
      | 1            |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go            |
      | Espace de stockage supplémentaire :| 1 x 20 Go         |
      | Espace total de stockage :         | 145 Go            |
      | Ordinateurs :                      | 3                 |
      | Abonnement :                       | Bisnnuel          |
      | Remise : 	                       | 3 mois gratuits   |
      | Prochaine facture :                | @2 years from now |
      | Montant: 	                       | 227,39€           |
      | VAT Rate (20.0%):                  | 45,58€            |
      | Total : 	                       | 272,97€           |
      | Prorated Cost: 	                   | 35,07€            |
      | VAT Rate (20.0%):                  | 7,01€             |
      | Total : 	                       | 42,08€            |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 125 Go   |
      | Espace de stockage supplémentaire : | 0 Go              |
      | Ordinateurs : 	                    | 3                 |
      | Abonnement : 	                    | Bisnnuel          |
      | Remise : 	                        | 3 mois gratuits   |
      | Prochaine facture :                 | @2 years from now |
      | Montant: 	                        | 227,39€           |
      | VAT Rate (20.0%): 	                | 45,58€            |
      | Total :                             | 272,97€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 50 Go Cases
  #
  @TC.137013 @BUG.128707 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr @qa6_dependent
  Scenario: 137013 Add a new FR monthly basic MozyHome user
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
    And I upgrade my user account to:
      | addl computers |
      | 4            |
    And the payment details summary looks like:
      | Plan de base :                     | 50 Go             |
      | Espace de stockage supplémentaire :| 99 x 20 Go        |
      | Espace total de stockage :         | 2,0 To            |
      | Ordinateurs :                      | 4                 |
      | Abonnement :                       | Mensuel           |
      | Prochaine facture :                | @1 month from now |
      | Montant: 	                       | 174,50€           |
      | VAT Rate (20.0%):                  | 34,90€            |
      | Total : 	                       | 209,40€           |
      | Prorated Cost: 	                   | 36,91€            |
      | VAT Rate (20.0%):                  | 7,38€             |
      | Total : 	                       | 44,29€            |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 50 Go    |
      | Espace de stockage supplémentaire : | 1,9 To            |
      | Ordinateurs : 	                    | 4                 |
      | Abonnement : 	                    | Mensuel           |
      | Prochaine facture :                 | @1 month from now |
      | Montant: 	                        | 174,50€           |
      | VAT Rate (20.0%): 	                | 34,90€            |
      | Total :                             | 209,40€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.137014 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 137014 Add a new FR yearly basic MozyHome user
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
    And I upgrade my user account to:
      | base plan | addl storage |
      | 125 GB    | 98           |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go           |
      | Espace de stockage supplémentaire :| 98 x 20 Go       |
      | Espace total de stockage :         | 2,0 To           |
      | Ordinateurs :                      | 3                |
      | Abonnement :                       | Annuel           |
      | Remise : 	                       | 1 mois gratuit   |
      | Prochaine facture :                | @1 year from now |
      | Montant: 	                       | 1 882,67€        |
      | VAT Rate (20.0%):                  | 376,53€          |
      | Total : 	                       | 2 259.20€        |
      | Prorated Cost: 	                   | 1 836,93€        |
      | VAT Rate (20.0%):                  | 367,39€          |
      | Total : 	                       | 2 204,32€        |
    And the current plan summary looks like:
      | Plan de base :                      | MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 1,9 To           |
      | Ordinateurs : 	                    | 3                |
      | Abonnement : 	                    | Annuel           |
      | Remise : 	                        | 1 mois gratuit   |
      | Prochaine facture :                 | @1 year from now |
      | Montant: 	                        | 1 882,67€        |
      | VAT Rate (20.0%): 	                | 376,53€          |
      | Total :                             | 2 259.20€        |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.137015 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 137015 Add a new FR biennial basic MozyHome user
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
    And I upgrade my user account to:
      | base plan | addl computers |
      | 125 GB    | 5             |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go            |
      | Espace de stockage supplémentaire :| 0 x 20 Go         |
      | Espace total de stockage :         | 125 Go            |
      | Ordinateurs :                      | 5                 |
      | Abonnement :                       | Bisnnuel          |
      | Remise : 	                       | 3 mois gratuits   |
      | Prochaine facture :                | @2 years from now |
      | Montant: 	                       | 227,46€           |
      | VAT Rate (20.0%):                  | 45,49€            |
      | Total : 	                       | 272,95€           |
      | Prorated Cost: 	                   | 140,14€           |
      | VAT Rate (20.0%):                  | 28,03€            |
      | Total : 	                       | 168,17€           |
    And the current plan summary looks like:
      | Plan de base :                   	| MozyHome 125 Go   |
      | Espace de stockage supplémentaire : | 0 Go              |
      | Ordinateurs : 	                    | 5                 |
      | Abonnement : 	                    | Bisnnuel          |
      | Remise : 	                        | 3 mois gratuits   |
      | Prochaine facture :                 | @2 years from now |
      | Montant: 	                        | 227,46€           |
      | VAT Rate (20.0%): 	                | 45,49€            |
      | Total :                             | 272,95€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 Go Cases
  #
  @TC.137016 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 137016 Add a new FR monthly basic MozyHome user
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
    And I upgrade my user account to:
      | addl computers |
      | 4            |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go            |
      | Espace de stockage supplémentaire :| 0 x 20 Go         |
      | Espace total de stockage :         | 125 Go            |
      | Ordinateurs :                      | 4                 |
      | Abonnement :                       | Mensuel           |
      | Prochaine facture :                | @1 month from now |
      | Montant: 	                       | 9,16€             |
      | VAT Rate (20.0%):                  | 1,83€             |
      | Total : 	                       | 10,99€            |
      | Prorated Cost: 	                   | 1,67€             |
      | VAT Rate (20.0%):                  | 0,33€             |
      | Total : 	                       | 2,00€             |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 125 Go   |
      | Espace de stockage supplémentaire : | 0 Go              |
      | Ordinateurs : 	                    | 3                 |
      | Abonnement : 	                    | Mensuel           |
      | Prochaine facture :                 | @1 month from now |
      | Montant: 	                        | 9,16€             |
      | VAT Rate (20.0%): 	                | 1,83€             |
      | Total :                             | 10,99€            |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.137017 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 137017 Add a new FR yearly basic MozyHome user
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
    And I upgrade my user account to:
      | addl storage |
      | 1            |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go           |
      | Espace de stockage supplémentaire :| 1 x 20 Go        |
      | Espace total de stockage :         | 145 Go           |
      | Ordinateurs :                      | 3                |
      | Abonnement :                       | Annuel           |
      | Remise : 	                       | 1 mois gratuit   |
      | Prochaine facture :                | @1 year from now |
      | Montant: 	                       | 100,78€          |
      | VAT Rate (20.0%):                  | 20,16€           |
      | Total : 	                       | 120,94€          |
      | Prorated Cost: 	                   | 18,37€           |
      | VAT Rate (20.0%):                  | 3,67€            |
      | Total : 	                       | 22,00€           |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 20 Go            |
      | Ordinateurs : 	                    | 3                |
      | Abonnement : 	                    | Annuel           |
      | Remise : 	                        | 1 mois gratuit   |
      | Prochaine facture :                 | @1 year from now |
      | Montant: 	                        | 100,78€          |
      | VAT Rate (20.0%): 	                | 20,16€           |
      | Total :                             | 120,94€          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.137018 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 137018 Add a new FR biennial basic MozyHome user
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
    And I upgrade my user account to:
      | addl computers |
      | 4            |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go            |
      | Espace de stockage supplémentaire :| 0 x 20 Go         |
      | Espace total de stockage :         | 125 Go            |
      | Ordinateurs :                      | 4                 |
      | Abonnement :                       | Bisnnuel          |
      | Remise : 	                       | 3 mois gratuits   |
      | Prochaine facture :                | @2 years from now |
      | Montant: 	                       | 192,39€           |
      | VAT Rate (20.0%):                  | 38,48€            |
      | Total : 	                       | 230,87€           |
      | Prorated Cost: 	                   | 35,07€            |
      | VAT Rate (20.0%):                  | 7,01€             |
      | Total : 	                       | 42,00€            |
    And the current plan summary looks like:
      | Plan de base : 	| MozyHome 125 Go   |
      | Espace de stockage supplémentaire : | 0 Go              |
      | Ordinateurs : 	                    | 3                 |
      | Abonnement : 	                    | Bisnnuel          |
      | Remise : 	                       | 3 mois gratuits    |
      | Prochaine facture :                 | @2 years from now |
      | Montant: 	                        | 7,49€             |
      | VAT Rate (20.0%): 	                | 1,50€             |
      | Total :                             | 8,99€             |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

