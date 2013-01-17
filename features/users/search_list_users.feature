Feature: Search and list user

  @smoke
  Scenario: Search user
    Given I log in bus admin console as mozypro test account
    When I search user by:
      | keywords                   | filter |
      | qa1+new+user+test@mozy.com | None   |
    Then user search results should be:
      | User                       | Name       | Machines | Storage | Storage Used | Created  | Backed Up |
      | qa1+new+user+test@mozy.com | new user 1 | 0        | 0 bytes | none         | 08/15/12 | never     |