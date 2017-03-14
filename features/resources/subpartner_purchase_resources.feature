Feature: Sub partners can purchase resources

  # Limitations:
  #  Test accounts have been created on QA6 for existing partners cases
  #
  Background:
    Given I log in bus admin console as administrator

  @TC.19864 @need_test_account @bus @subpartner_purchase_resources @env_dependent @regression
  Scenario: 19864 Existing OEM partner with sub partners whose sub partners can purchase resources
    When I act as partner by:
      | email                          | filter |
      | qa1+tc+19867+reserved@mozy.com | OEMs   |
    And I act as partner by:
      | email                          |
      | qa1+tc+19811+admin1@mozy.com   |
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 10           |
    Then Resources should be purchased
    And Current purchased resources should increase:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 10           |

  @TC.19865 @need_test_account @bus @subpartner_purchase_resources @env_dependent @regression
  Scenario: 19865 Existing OEM partner with sub partners whose OEM partner can purchase resources
    When I act as partner by:
      | email                          | filter |
      | qa1+tc+19867+reserved@mozy.com | OEMs   |
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | user group         | desktop license | desktop quota | server license | server quota |
      | default user group | 1               | 10            | 1              | 5            |
    Then Resources should be purchased
    And Current purchased resources should increase:
      | desktop license | desktop quota | server license | server quota |
      | 1               | 10            | 1              | 5            |

  @TC.19867 @need_test_account @bus @subpartner_purchase_resources @env_dependent @regression
  Scenario: 19867 Existing OEM partner without subpartners can purchase resources
    When I act as partner by:
      | email                                   | filter |
      | redacted-374495@notarealdomain.mozy.com | OEMs   |
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | user group         | desktop license | desktop quota | server license | server quota |
      | default user group | 1               | 10            | 1              | 5            |
    Then Resources should be purchased
    And Current purchased resources should increase:
      | desktop license | desktop quota | server license | server quota |
      | 1               | 10            | 1              | 5            |

  @TC.19869 @bus @subpartner_purchase_resources @regression
  Scenario: 19869 New MozyPro bundle partner without sub partner can purchase resource
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 100 GB    |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 500 GB    | yes         |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19870 @bus @subpartner_purchase_resources @regression
  Scenario: 19870 New Reseller Metallic partner without sub partner can purchase resources
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 100            |
    Then New partner should be created
    When I act as newly created partner account
    When I change Reseller account plan to:
      | server plan | storage add-on |
      | yes         | 2              |
    And the Reseller account plan should be changed
    And MozyPro new plan should be:
      | server plan | storage add-on |
      | yes         | 2              |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19873 @bus @subpartner_purchase_resources @regression
  Scenario: 19873 New Enterprise partner without subpartner can purchase resources
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan | server add-on |
      | 15    | 100 GB      | 5             |
    Then the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan | server add-on |
      | 15    | 100 GB      | 5             |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19953 @need_test_account @bus @subpartner_purchase_resources @env_dependent @regression
  Scenario: 19953 Existing MozyPro bundle partner without sub partner can purchase resource
    When I act as partner by:
      | email                          |
      | qa1+tc+19953+reserved@mozy.com |
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 100 GB    | yes         |
    Then the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | yes         |
    When I refresh Change Plan section
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 50 GB     | no          |
    Then the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 50 GB     | no          |

  @TC.19954 @need_test_account @bus @subpartner_purchase_resources @env_dependent @regression
  Scenario: 19954 Existing Reseller Metallic partner without sub partner can purchase resource
    When I act as partner by:
      | email                          |
      | qa1+tc+19954+reserved@mozy.com |
    And I change Reseller account plan to:
      | storage add-on |
      | 10             |
    Then the Reseller account plan should be changed
    And Reseller new plan should be:
      | storage add-on | server plan |
      | 10             | yes         |
    When I refresh Change Plan section
    And I change Reseller account plan to:
      | storage add-on |
      | 5              |
    Then the Reseller account plan should be changed
    And Reseller new plan should be:
      | storage add-on | server plan |
      | 5              | yes         |

#   @TC.19871 @need_test_account @not_implemented    @bus @subpartner_purchase_resources @env_dependent
#   Scenario: 19871 Reseller Metallic partner with subparnter whose subparnter buy resources will raise error message
#    When I act as partner by:
#      | email                          |
#      | qa1+tc+19871+reserved@mozy.com |
#    When I act as partner by:
#      | email                          |
#      | qa1+sub+admin+19871@mozy.com   |
#    And I navigate to Purchase Resources section from bus admin console page
#    And I purchase resources:
#      | desktop license | desktop quota |
#      | 1               | 10            |
#    # Suppose to check resource NOT purchased message, but not implemented yet, refactor later
#    And I navigate to Manage Resources section from bus admin console page
#    # Bug 92091
#    Then Partner resources general information should be:
#      | Total Account Storage: | Unallocated Storage: | Server Enabled: |
#      | 0 GB                   | 0 GB                 | No              |

  @TC.19868 @need_test_account @bus @subpartner_purchase_resources @env_dependent @regression
  Scenario: 19868 Existing Reseller itemized partner without subpartners can purchase resources
    When I log in to legacy bus01 as administrator
    And I successfully add an itemized Reseller partner:
      | period | server licenses | server quota | desktop licenses | desktop quota |
      | 12     | 10              | 250          | 10               | 250           |
    And I log in bus admin console as administrator
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And I view partner details by newly created partner company name
    And I get the partner_id
    And I migrate the partner to aria
    And I log in bus admin console as administrator
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And Partner search results should be:
      | Partner       | Type              |
      | @company_name | Reseller Itemized |
    And I view partner details by newly created partner company name
    And I act as newly created partner
    When I navigate to Change Plan section from bus admin console page
    And I increase Itemized account plan by:
      | desktop license | desktop quota | server license | server quota |
      | 1               | 10            | 1              | 5            |
    Then the Itemized account plan should be changed
    And Current itemized resources should increase:
      | desktop license | desktop quota | server license | server quota |
      | 1               | 10            | 1              | 5            |

  # need to find another account, this one will meet billing system error
  @TC.19872 @need_test_account @bus @subpartner_purchase_resources @env_dependent @regression
  Scenario: 19872 Existing MozyPro itemized partner without subpartners can purchase resources
    When I log in to legacy bus01 as administrator
    And I successfully add an itemized MozyPro partner:
      | period | server licenses | server quota | desktop licenses | desktop quota |
      | 12     | 5               | 50           | 5                | 50            |
    And I log in bus admin console as administrator
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And I view partner details by newly created partner company name
    And I get the partner_id
    And I migrate the partner to aria
    And I log in bus admin console as administrator
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And Partner search results should be:
      | Partner       | Type             |
      | @company_name | MozyPro Itemized |
    And I view partner details by newly created partner company name
    And I act as newly created partner
    When I navigate to Change Plan section from bus admin console page
    And I increase Itemized account plan by:
      | desktop license | desktop quota | server license | server quota |
      | 1               | 10            | 1              | 5            |
    Then the Itemized account plan should be changed
    And Current itemized resources should increase:
      | desktop license | desktop quota | server license | server quota |
      | 1               | 10            | 1              | 5            |

  @TC.19370 @need_test_account @bus @subpartner_purchase_resources @env_dependent @regression
  Scenario: 19370 Existing Reseller itemized partner with subpartners whose subpartner can purchase resources
    When I act as partner by:
      | email                           |
      | mozyautotest+ona1s8qlqt@emc.com |
    And I act as partner by:
      | email                             |
      | mozyautotest+kysdtufbkj9x@emc.com |
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 1               | 10            | 1              | 5            |
    Then Resources should be purchased
    And Current purchased resources should increase:
      | desktop license | desktop quota | server license | server quota |
      | 1               | 10            | 1              | 5            |
