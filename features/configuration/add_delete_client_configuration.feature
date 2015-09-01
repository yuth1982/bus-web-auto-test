Feature: Add/Delete Client Configuration

  Background:
    Given I log in bus admin console as administrator

  @TC.123901 @client_configuration @bus
  Scenario: 123901 Add more user groups for the client configuration
    When I add a new MozyPro partner:
      | period | base plan | net terms | server plan | root role               |
      | 24     | 10 GB     | yes       | yes         | Bundle Pro Partner Root |
    Then New partner should be created
    And I act as newly created partner account
    When I add a new Bundled user group:
      | name             | storage_type | server_support |
      | TC123901-group-1 | Shared       | yes            |
    Then TC123901-group-1 user group should be created
    When I add a new Bundled user group:
      | name             | storage_type | server_support |
      | TC123901-group-2 | Shared       | yes            |
    Then TC123901-group-2 user group should be created
    When I create a new client config:
      | name                          | type   | user group                        |
      | TC123901-server-client-config | Server | TC123901-group-1,TC123901-group-2 |
    Then client configuration section message should be Your configuration was saved.
    When I create a new client config:
      | name                           | type    | user group                         |
      | TC123901-desktop-client-config | Desktop | TC123901-group-1,TC123901-group-2  |
    Then client configuration section message should be Your configuration was saved.
    When I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: TC123901-group-1
    And I open Client Configuration tab
    Then Server client configuration should be TC123901-server-client-config
    Then Desktop client configuration should be TC123901-desktop-client-config
    And I close the user group detail page
    When I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: TC123901-group-2
    And I open Client Configuration tab
    Then Server client configuration should be TC123901-server-client-config
    Then Desktop client configuration should be TC123901-desktop-client-config
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.123904 @client_configuration @bus
  Scenario: 123904 Remove more user groups for the client configuration
    When I add a new MozyPro partner:
      | period | base plan | server plan | root role               |
      | 1      | 500 GB    | yes         | Bundle Pro Partner Root |
    Then New partner should be created
    And I act as newly created partner account
    When I add a new Bundled user group:
      | name             | storage_type | server_support |
      | TC123904-group-1 | Shared       | yes            |
    Then TC123904-group-1 user group should be created
    When I add a new Bundled user group:
      | name             | storage_type | server_support |
      | TC123904-group-2 | Shared       | yes            |
    Then TC123904-group-2 user group should be created
    When I create a new client config:
      | name                          | type   | user group                         |
      | TC123904-server-client-config | Server | TC123904-group-1,TC123904-group-2  |
    Then client configuration section message should be Your configuration was saved.
    When I create a new client config:
      | name                           | type    | user group                        |
      | TC123904-desktop-client-config | Desktop | TC123904-group-1,TC123904-group-2 |
    Then client configuration section message should be Your configuration was saved.
    When I edit the new created config TC123904-server-client-config
    And I click tab User Groups
    Then I remove user group: TC123904-group-1 from the configuration
    And I remove user group: TC123904-group-2 from the configuration
    Then I save the client configuration changes
    When I edit the new created config TC123904-desktop-client-config
    And I click tab User Groups
    Then I remove user group: TC123904-group-1 from the configuration
    And I remove user group: TC123904-group-2 from the configuration
    Then I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    When I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: TC123904-group-1
    And I open Client Configuration tab
    Then Server client configuration should be None (Inherited defaults from parent partner)
    Then Desktop client configuration should be None (Inherited defaults from parent partner)
    And I close the user group detail page
    When I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: TC123904-group-2
    And I open Client Configuration tab
    Then Server client configuration should be None (Inherited defaults from parent partner)
    Then Desktop client configuration should be None (Inherited defaults from parent partner)
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.1338 @client_configuration @bus
  Scenario: 1338:Edit a client config (Desktop) scheduling
    When I add a new MozyPro partner:
      | period | base plan | net terms | server plan |
      | 24     | 10 GB     | yes       | yes         |
    Then New partner should be created
    When I act as newly created partner account
    And I create a new client config:
      | name                         | type    | automatic max load | automatic min idle | automatic interval |
      | TC1338-desktop-client-config | Desktop | 10                 | 10                 | 7:lock             |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC1338-desktop-client-config
    And I click tab Scheduling
    Then scheduling settings should be:
      | automatic max load | automatic min idle | automatic interval |
      | 10                 | 10                 | 7:lock             |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name
















