Feature: Reap Script Verification
  As a Mozy employee, I verify the reap script is working

  @TC.10491 @bus @reap @email @env_dependent
  Scenario: 10491:MozyHome delinquent payment.
    Given I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I log in bus admin console as administrator
    And I search user by:
     | keywords       |
     | @mh_user_email |
    And I view user details by newly created MozyHome username
    Then I get the user id
    Then I force current MozyHome account to delinquent state
    Then I run identification reap script
    Then I run first notification reap script
    Then I run second notification reap script
    Then I run third notification reap script
    Then I run fourth notification reap script
    Then I run fifth notification reap script
    Then I run final notification reap script
    Then I run deletion reap script
    Then I close user details section
    And I search user by:
      | keywords         | filter          |
      | @mh_user_email   | Deleted Users   |
    And I view user details by newly created MozyHome username

  @TC.22019 @bus @reap @z-date @email @env_dependent
  Scenario: Mozy-22019:Long delinquent account z date set
    Given I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    Then I get the user id
    Then I force current MozyHome account to delinquent state
    Then I run identification reap script with z-dates
    Then I run first notification reap script with z-dates
    Then I run second notification reap script with z-dates
    Then I run third notification reap script with z-dates
    Then I run fourth notification reap script with z-dates
    Then I run fifth notification reap script with z-dates
    Then I run sixth notification reap script with z-dates
    Then I run seventh notification reap script with z-dates
    Then I run final notification reap script with z-dates
    Then I run deletion reap script with z-dates
    Then I close user details section
    And I search user by:
      | keywords         | filter          |
      | @mh_user_email   | Deleted Users   |
    And I view user details by newly created MozyHome username
