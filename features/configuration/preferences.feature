Feature: Preferences


  Background:
    Given I log in bus admin console as administrator

  @TC.1336 @client_configuration @bus
  Scenario: 1336 Edit a client config (Server)
    When I add a new MozyPro partner:
      | period |  base plan |   server plan |  net terms |
      |   1    |  50 GB     |       yes     |     yes    |
    Then New partner should be created
    When I act as newly created partner account
    When I create a new client config:
      | name                        | type   |
      | TC1336-server-client-config | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit client config:
      | name                        | all settings |
      | TC1336-server-client-config | uncheck      |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC1336-server-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | all settings |
      | unchecked    |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.1337 @client_configuration @bus
  Scenario: 1337 Edit a client config (Desktop)
    When I add a new MozyPro partner:
      | period |  base plan |   server plan |
      |   12   |  250 GB    |   yes         |
    Then New partner should be created
    When I act as newly created partner account
    When I create a new client config:
      | name                         | type    |
      | TC1337-desktop-client-config | Desktop |
    Then client configuration section message should be Your configuration was saved.
    And I edit client config:
      | name                         | all settings   |
      | TC1337-desktop-client-config | uncheck        |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC1337-desktop-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | all settings |
      | unchecked    |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.488 @client_configuration @bus
  Scenario: 488 Set a client config option to Cascade -prefrences tab
    When I add a new MozyEnterprise partner:
      | company name   | period | users | server plan | net terms  | root role  |
      | TC.488_partner |   36   | 130   | 16 TB       | yes        | FedID role |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I create a new client config:
      | name                | type    |
      | TC488-client-config | Desktop |
    Then client configuration section message should be Your configuration was saved.
    And I edit client config:
      | name                | warning days |
      | TC488-client-config | 15:cascade   |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC488-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | warning days |
      | 15:cascade   |
    When I add a new sub partner:
      | Company Name       |
      | TC.488_sub_partner |
    Then New partner should be created
    When I act as newly created partner account
    When I create a new client config:
      | name                  | type    |
      | TC488-client-config-2 | Desktop |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC488-client-config-2
    And I click tab Preferences
    Then preferences settings should be:
      | warning days | warning days editable |
      | 15:cascade   | all disabled          |
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.488_sub_partner
    And I stop masquerading
    And I search and delete partner account by TC.488_partner

  @TC.884 @client_configuration @bus
  Scenario: 884 Create a new client config (Desktop)
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      |   24   | 2     | 250 GB      | FedID role |
    Then New partner should be created
    When I act as newly created partner account
    When I create a new client config:
      | name                        | type    | all settings  |
      | TC884-desktop-client-config | Desktop | check         |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC884-desktop-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | all settings    |
      | checked         |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.885 @client_configuration @bus
  Scenario: 885 Create a new client config (Server)
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  | net terms |
      |   12   | 18    | 100 GB      | FedID role | yes       |
    Then New partner should be created
    When I act as newly created partner account
    When I create a new client config:
      | name                       | type   | all settings   |
      | TC885-server-client-config | Server | check          |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC885-server-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | all settings  |
      | checked       |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name





