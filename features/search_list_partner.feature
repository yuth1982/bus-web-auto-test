Feature: Search and list partner

  Background:
    Given I log in bus admin console as administrator

  @smoke_test @search_partner_basic
  Scenario: Search partner by company name
    When I search partner by Centizu Company
    Then Search results table header should be External ID,Partner,Created,Root Admin,Type,Users,Licenses,Quota
    Then Search results content should be ,Centizu Company,06/18/12,qa1+anna+willis@mozy.com,MozyPro,0,200,50 GB

  Scenario Outline: Search partner by keywords
    When I search partner by <search keywords>
    Then Search results content should be <expected content>

  Scenarios:
    | search keywords           | expected content                                                                      |
    | Tanoodle Company          | ,Tanoodle Company,05/30/12,qa1+martha+garcia@mozy.com,MozyEnterprise,0,201,25 GB      |
    | qa1+andrea+rose@mozy.com  | ,Yambee Company,06/20/12,qa1+andrea+rose@mozy.com,MozyEnterprise,0,1,25 GB            |