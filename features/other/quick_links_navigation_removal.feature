Feature: Quick Links section & Link removal from left navigation

  Background:
    Given I log in bus admin console as administrator

  #
  # Base case for nav link removal
  #   Redmine: 99538
  #
  @TC.21175
  Scenario: 21175 Removal of nav menu items
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    And I act as newly created partner
    And navigation items should be removed
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  #
  #   Cases for bundled Pro/Metallic Reseller/Enterprise
  #
    @TC.21176
    Scenario: 21176 MozyPro - BUS Admin UI - New Quick Link Section
      When I add a new MozyPro partner:
        | period | base plan | server plan | net terms |
        | 1      | 100 GB    | yes         | yes       |
      And New partner should be created
      And I act as newly created partner
      And navigation items should be removed
      And I stop masquerading
      And I search and delete partner account by newly created partner company name

    @TC.21178
    Scenario: 21178 Metallic Reseller - BUS Admin UI - New Quick Link Section
      When I add a new Reseller partner:
        | period | reseller type | reseller quota | server plan | net terms |
        | 12     | Gold          | 750            | yes         | yes       |
      And New partner should be created
      And I act as newly created partner
      And navigation items should be removed
      And I stop masquerading
      And I search and delete partner account by newly created partner company name

    @TC.21179
    Scenario: 21179 MozyEnterprise BUS Admin UI - New Quick Link Section
      When I add a new MozyEnterprise partner:
        | period | users | server plan | net terms |
        | 12     | 10    | 250 GB      | yes       |
      And New partner should be created
      And I act as newly created partner
      And navigation items should be removed
      And I stop masquerading
      And I search and delete partner account by newly created partner company name

  #
  # Base case for Quick Link section
  #   Section heading is only a title, as each link goes to different modules
  #   Redmine: 99171
  #
  @TC.21295
  Scenario: 21295 New Quick Link Section
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 100 GB    | yes         | yes       |
    And New partner should be created
    And I act as newly created partner
    And new section & navigation items are present for MozyPro partner
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  #
  #   Cases for bundled Pro/Metallic Reseller/Enterprise
  #
  @TC.21296
  Scenario: 21296 MozyPro - BUS Admin UI - New Quick Link Section
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 100 GB    | yes         | yes       |
    And New partner should be created
    And I act as newly created partner
    And new section & navigation items are present for MozyPro partner
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21298
  Scenario: 21298 Metallic Reseller - BUS Admin UI - New Quick Link Section
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms |
      | 12     | Gold          | 750            | yes         | yes       |
    And New partner should be created
    And I act as newly created partner
    And new section & navigation items are present for Reseller partner
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21299
  Scenario: 21299 MozyEnterprise BUS Admin UI - New Quick Link Section
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 250 GB      | yes       |
    And New partner should be created
    And I act as newly created partner
    And new section & navigation items are present for MozyEnterprise partner
    And I stop masquerading
    And I search and delete partner account by newly created partner company name
