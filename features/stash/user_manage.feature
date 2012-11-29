Feature: User stash setting management

  As a Mozy customer admin
  I want to turn-on Stash for a new user group
  so that I can add Stash to the users within that group

  Background:
    Given I log in bus admin console as administrator

  @TC.18972 @BSA.2040
  Scenario: 18972 Add Stash link is not available in user view when stash is not enabled for the user
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 50 GB     |
    Then New partner should be created
    When I act as newly created partner account
    And I add a new user:
      | name           | email                        |
      | TC.18972 user  | qa1+tc+18972+user1@mozy.com  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by qa1+tc+18972+user1@mozy.com
    Then I should not see Enable Stash setting on user details section


  @TC.18973 @BSA.2040
  Scenario: 18973 Add Stash link is available in user view when stash is enabled for the user
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 50 GB     |
    Then New partner should be created
    When I enable stash for the partner with default stash storage
    Then Partner general information should be:
      | Enable Stash: | Default Stash Storage: |
      | Yes           | 2 GB (change)          |
    When I act as newly created partner account
    And I add a new user:
      | name           | email                        |
      | TC.18973 user  | qa1+tc+18973+user1@mozy.com  |
    Then New user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by qa1+tc+18973+user1@mozy.com
    Then User details should be:
      | Name:                  | Enable Stash:  |
      | TC.18973 user (change) | No (Add Stash) |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name