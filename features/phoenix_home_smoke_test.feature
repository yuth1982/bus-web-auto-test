Feature: Mozy Home Smoke Test via Phoenix

  As a private citizen, I want to create a fr4ee-user account through phoenix [##@PROD-53##]
    Afterwards, I want to do the following:
      1. log in to the account as its admin [##@PROD-54##]
      2. upgrade the acct to paid [##@PROD-58##]
      3. change profile data: billing address/credit card info, username & password [##@PROD-55,176##]
        a. verify change in password via log out and login
      4. change newly paid acct (upgrade)
      5. change the newly paid & recently upgraded acct billing interval (renewal)
        b. verify all changes to user within the bus admin console as root admin

  Background:
  # info to be added here: coverage matrix

  @TC.53 @TC.54 @TC.55 @TC.58 @TC.176 @bus @regression_test @phoenix @mozyhome @free @email
  Scenario: 53 54 55 58 176 Add a new US monthly free MozyHome user
    When I am at dom selection point:
    And I add a phoenix Free user:
      | base plan | country |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I verify the user account.
    And I upgrade my free account to:
      | base plan | period |
      | 50 GB     | 1      |
    And I change my profile attributes to:
      | new_password | new_cc_num       | new_cc_type | last_four_digs | new_username_first | new_username_last | new_username_full |
      | Naich4yei8   | 5555555555554444 | MasterCard  | 4444           | TcUsrFirst         | Smith             | TcUsrFirst Smith  |
    And I upgrade my user account to:
      | base plan | addl storage |
      | 125 GB    | 2            |
    And I login under changed password on the account.
    And I change my user account to:
       | period |
       | 12     |
    And I logout of my user account
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: | Name:               |
      | MozyHome (change) | @country | @user_name (change) |
    And MozyHome subscription details should be:
      | Subscription     |
      | MozyHome 125 GB, + 40 GB, 3 machines, yearly |
    And I delete user
