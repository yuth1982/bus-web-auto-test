Feature: Search and list partner

  Background:
    Given I log in bus admin console as administrator

  @smoke @search_partner_basic
  Scenario: Search partner by company name
    When I search partner by:
      | email                       | filter  | including sub-partners |
      | qa1+frank+hamilton@mozy.com | None    | yes                    |
    Then Partner search results should be:
      | External ID | Partner                          | Created  | Root Admin                  | Type           | Users    | Licenses | Quota    |
      |             | Izio Oil & Gas Pipelines Company | 07/11/12 | qa1+frank+hamilton@mozy.com | MozyEnterprise | 0        | 201      | 625 GB   |