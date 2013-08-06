Feature: BUS Regression Test

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

  @TC.2188 @bus @others
  Scenario: 2188 XXS issues and input validation
    When I search partner by <script>alert('foo')</script>
    Then I will see alert('foo') in the search partner input box

  @TC.18897 @bus @others
  Scenario: 18897 Deletion is triggered by admins in the bus(Mozypro,business,yearly)
    When I add a new MozyPro partner:
      | period | users | server plan | server add on |
      | 12     | 10    | 100 GB      | 1             |
    And New partner should be created
    And I get partner aria id
    And I delete partner account
    When API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label |
      | CANCELLED    |