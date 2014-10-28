Feature: BUS Regression partner test

  Background:
    Given I log in bus admin console as administrator


    @TC.1649 @selenium @bus @others
    Scenario: 1649 Set a partners subdomain
    When I add a new MozyPro partner:
    | period | base plan |
    | 1      | 50 GB     |
    Then New partner should be created
    When I change the subdomain to @subdomain
    Then The subdomain is created with name https://@subdomain.mozypro.com/
    And The subdomain in BUS will be @subdomain
    And I delete partner account

    @TC.2168 @bus @others
    Scenario: 2168 Export to CSV
    When I act as partner by:
    | name                     |
    | Topicstorm 46083 Company |
    And I navigate to Search / List Users section from bus admin console page
    And I export the users csv
    And I navigate to Search / List Machines section from bus admin console page
    And I export the machines csv
    Then users.csv and machines.csv are downloaded