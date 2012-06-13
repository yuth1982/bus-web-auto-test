Feature: Search and list partner

  Background:
    Given I log in bus admin console as administrator

  Scenario: Display search results table header
    Given I log in bus admin console as administrator
    When I search partner by Roob, Sanford and Braun
    Then Search results content should be ,Roob, Sanford and Braun,02/13/12,qa6+violette+emmerich@mozy.com,Business,0,20,540 GB
    Then Search results table header should be External ID,Partner,Created,Root Admin,Type,Users,Licenses,Quota

  @test-1111
  Scenario Outline: Search partner by keywords
    When I search partner by <search keywords>
    Then Search results content should be <expected content>

  Scenarios:
    | search keywords          | expected content                                                                       |
    | Roob, Sanford and Braun  | ,Roob, Sanford and Braun,02/13/12,qa6+violette+emmerich@mozy.com,Business,0,20,540 GB  |
    | qa6+Polly+Kuhn@mozy.com  | ,Grady-Hegmann,02/14/12,qa6+polly+kuhn@mozy.com,Business,0,20,1240 GB                  |
