Feature: Search and list partner

  Background:
    Given I log in bus admin console as administrator

  @smoke_test @search_partner_basic
  Scenario: Search partner by company name
    When I search partner by:
      | keywords                         | filter  | including sub-partners |
      | Izio Oil & Gas Pipelines Company | None    | yes                    |
    Then Partner search results should be:
      | External ID | Partner                          | Created  | Root Admin                  | Type           | Users    | Licenses | Quota    |
      |             | Izio Oil & Gas Pipelines Company | 07/11/12 | qa1+frank+hamilton@mozy.com | MozyEnterprise | 0        | 201      | 625 GB   |