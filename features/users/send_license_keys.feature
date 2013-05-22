Feature: Send activated / unactivated license keys

  Background:
    Given I log in bus admin console as administrator

  @TC.20947
  Scenario: 20947 [Itemized][Server License]Admin can send activated/unactived license keys
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name            |
      | 12     | 10    | 100 GB      | yes       | [Itemized] Add New User |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.20947-1 | (default user group) | Server       | 10            | 3       | no           |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then Number of Server activated keys should be 0
    And Number of Server unactivated keys should be 3
    When I click Send Keys button
    And I search emails by keywords:
      | content                |
      | <%=@unactivated_keys%> |
    Then I should see 1 email(s)
    And I can find 0 Activated Server license key(s) from the mail
    And I can find 3 Unactivated Server license key(s) from the mail
    When I update the user password to default password
    And activate the user's Server device without a key and with the default password
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I refresh User Details section
    And I view the user's product keys
    Then Number of Server activated keys should be 1
    And Number of Server unactivated keys should be 2
    When I click Send Keys button
    And I search emails by keywords:
      | content                                  |
      | <%=@activated_keys + @unactivated_keys%> |
    Then I should see 2 email(s)
    And I can find 1 Activated Server license key(s) from the mail
    And I can find 2 Unactivated Server license key(s) from the mail
    When activate the user's Server device without a key and with the default password
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And activate the user's Server device without a key and with the default password
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I refresh User Details section
    And I view the user's product keys
    Then Number of Server activated keys should be 3
    And Number of Server unactivated keys should be 0
    When I click Send Keys button
    And I search emails by keywords:
      | content              |
      | <%=@activated_keys%> |
    Then I should see 3 email(s)
    And I can find 3 Activated Server license key(s) from the mail
    And I can find 0 Unactivated Server license key(s) from the mail

  @TC.21006
  Scenario: 21006 [BundleReseller][Desktop License]Admin can send activated/unactivated license keys
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 100            | no          |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21006-1 | (default user group) | Desktop      | 25            | 3       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then Number of Desktop activated keys should be 0
    And Number of Desktop unactivated keys should be 3
    When I click Send Keys button
    And I search emails by keywords:
      | content                |
      | <%=@unactivated_keys%> |
    Then I should see 1 email(s)
    And I can find 0 Activated Desktop license key(s) from the mail
    And I can find 3 Unactivated Desktop license key(s) from the mail
    When I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I refresh User Details section
    And I view the user's product keys
    Then Number of Desktop activated keys should be 1
    And Number of Desktop unactivated keys should be 2
    When I click Send Keys button
    And I search emails by keywords:
      | content                                  |
      | <%=@activated_keys + @unactivated_keys%> |
    Then I should see 2 email(s)
    And I can find 1 Activated Desktop license key(s) from the mail
    And I can find 2 Unactivated Desktop license key(s) from the mail
    When activate the user's Desktop device without a key and with the default password
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And activate the user's Desktop device without a key and with the default password
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I refresh User Details section
    And I view the user's product keys
    Then Number of Desktop activated keys should be 3
    And Number of Desktop unactivated keys should be 0
    When I click Send Keys button
    And I search emails by keywords:
      | content              |
      | <%=@activated_keys%> |
    Then I should see 3 email(s)
    And I can find 3 Activated Desktop license key(s) from the mail
    And I can find 0 Unactivated Desktop license key(s) from the mail
