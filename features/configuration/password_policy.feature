Feature: Password policy is saved successfully to db

  Background:
    Given I log in bus admin console as administrator

  @TC.120092 @bus
  Scenario: 120092 [MozyEnterprise]Hipaa partner password policy settings should be saved to database correctly
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | root role  | security |
      | 12     | 18    | 100 GB      | yes       | FedID role | HIPAA    |
    Then New partner should be created
    When I act as newly created partner account
    Then The user password policy from database will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The user password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    Then The admin password policy from database will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The admin password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I add a new sub partner:
      | Company Name | Pricing Plan | Admin Name |
      | subpartner   | subplan      | subadmin   |
    Then New partner should be created
    And I act as newly created subpartner account
    Then The subpartner user password policy from rails console will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The user password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    Then The subpartner admin password policy from rails console will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The admin password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    Then I stop masquerading from subpartner
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name


  @TC.120103 @bus
  Scenario: 120103 [Reseller]Hipaa partner password policy settings should be saved to database correctly
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms | security |
      | 12     | Silver        | 100            | yes       | HIPAA    |
    Then New partner should be created
    And I act as newly created partner account
    Then The user password policy from database will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The user password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    Then The admin password policy from database will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The admin password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent        |
      | subrole | Partner admin | Reseller Root |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I add a new sub partner:
      | Company Name | Pricing Plan | Admin Name |
      | subpartner   | subplan      | subadmin   |
    Then New partner should be created
    And I act as newly created subpartner account
    Then The subpartner user password policy from rails console will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The user password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    Then The subpartner admin password policy from rails console will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The admin password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    Then I stop masquerading from subpartner
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.120104 @bus
  Scenario: 120104 [OEM]Hipaa partner password policy settings should be saved to database correctly
    When I act as partner by: 
      | name     | including sub-partners |
      | Fortress | no                     |
    And I act as partner by: 
      | name    | including sub-partners |
      | MozyOEM | no                     |
    And I add a new sub partner:          
      | Security |
      | HIPAA    |
    Then New partner should be created
    When I act as newly created partner account
    Then The user password policy from database will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The user password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    Then The admin password policy from database will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The admin password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | subrole | Partner admin |
    And I check all the capabilities for the new role
    And I add a new sub partner:
      | Company Name | Admin Name |
      | subpartner   | subadmin   |
    Then New partner should be created
    And I act as newly created subpartner account
    Then The subpartner user password policy from rails console will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The user password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    Then The subpartner admin password policy from rails console will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The admin password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    Then I stop masquerading from subpartner
    And I search and delete partner account by newly created subpartner company name

  @TC.120088  @bus
  Scenario: 120088 [MozyEnterprise]Hipaa admin cannot see the password policy link in admin console
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | root role  | security |
      | 12     | 18    | 100 GB      | yes       | FedID role | HIPAA    |
    Then New partner should be created
    When I act as newly created partner account
    Then I will not see the Password Policy link from navigation links
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I add a new sub partner:
      | Company Name | Pricing Plan | Admin Name |
      | subpartner   | subplan      | subadmin   |
    Then New partner should be created
    And I act as newly created subpartner account
    Then I will not see the Password Policy link from navigation links
    Then I stop masquerading from subpartner
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.120089  @bus
  Scenario: [Reseller]120089 Hipaa admin cannot see the password policy link in admin console
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms | security |
      | 12     | Silver        | 100            | yes       | HIPAA    |
    Then New partner should be created
    And I act as newly created partner account
    Then I will not see the Password Policy link from navigation links
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent        |
      | subrole | Partner admin | Reseller Root |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I add a new sub partner:
      | Company Name | Pricing Plan | Admin Name |
      | subpartner   | subplan      | subadmin   |
    Then New partner should be created
    And I act as newly created subpartner account
    Then I will not see the Password Policy link from navigation links
    Then I stop masquerading from subpartner
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.120090 @bus
  Scenario: 120090 [OEM]Hippa admin cannot see the password policy link in admin console
    When I add a new OEM partner:
      | Security |
      | HIPAA    |
    Then New partner should be created
    When I view the newly created subpartner admin details
    And I act as newly created partner account
    Then I will not see the Password Policy link from navigation links
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | subrole | Partner admin |
    And I check all the capabilities for the new role
    And I add a new sub partner:
      | Company Name | Admin Name |
      | subpartner   | subadmin   |
    Then New partner should be created
    And I act as newly created subpartner account
    Then I will not see the Password Policy link from navigation links
    Then I stop masquerading from subpartner
    And I search and delete partner account by newly created subpartner company name