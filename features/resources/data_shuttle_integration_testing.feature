Feature:
  Data shuttle integration testing

  Background:
    Given I log in bus admin console as administrator

  ###############################################################################

  # Purchase Resources

  ###############################################################################
  @bus @TC.12676 @resources @tasks_p1
  Scenario: 12676 Partner purchase data shuttle order
    When I add a new MozyPro partner:
      | period  | base plan | server plan | net terms |
      | 12      | 32 TB     | yes         | yes       |
    And New partner should be created
    And I change root role to FedID role
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type  | storage_limit | devices |
      | (default user group) | Desktop       | 10240         | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 1     |
    Then Data shuttle order should be created
    And I get the data shuttle seed id
    When I search order in view data shuttle orders section by newly created partner company name
    Then order search results in data shuttle orders section should be:
      | Pro Partner Name               | # of Drives | Drives Ordered |
      | <%=@partner.company_info.name%>| 1           | Yes            |
    When I view data shuttle order details
    Then data shuttle order details info should be
      | License Key            | Quota(GB) |
      | @order.licensee_key[0] | 1         |
    And I should not query resources orders record from DB for the data shuttle order
    And I search and delete partner account by newly created partner company name

  @bus @TC.12809 @resources @tasks_p1
  Scenario: 12809 Overdraft partner purchase data shuttle order for an activated machine
    And I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 2              | yes         |
    Then New partner should be created
    And I get the partner_id
    And I act as newly created partner
    And I navigate to Billing Information section from bus admin console page
    And I Enable billing info autogrow
    And I add new user(s):
      | user_group           | storage_type | devices |
      | (default user group) | Server       | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Server device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 1     |
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @bus @TC.12784 @resources @tasks_p1
  Scenario: 12784 Billing history for purchase data shuttle order
    When I add a new MozyPro partner:
      | period  | base plan | server plan | net terms |
      | 12      | 32 TB     | yes         | yes       |
    And New partner should be created
    And I change root role to FedID role
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type  | storage_limit | devices |
      | (default user group) | Desktop       | 10240         | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 1800  |
    Then Data shuttle order should be created
    Then Data shuttle order summary should be:
      | Description         | Quantity | Total    |
      | Data Shuttle 3.6 TB | 1        | $375.00  |
      | Total Price         |          | $375.00  |
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | $375.00 | $375.00    | $0.00       |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @bus @TC.12836 @resources @tasks_p1
  Scenario: 12836 Billing history for overdraft partner purchase data shuttle order for an activated machine
    And I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 2              | yes         |
    Then New partner should be created
    And I get the partner_id
    And I act as newly created partner
    And I navigate to Billing Information section from bus admin console page
    And I Enable billing info autogrow
    And I add new user(s):
      | user_group           | storage_type | devices |
      | (default user group) | Server       | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Server device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 1800  |
    Then Data shuttle order should be created
    Then Data shuttle order summary should be:
      | Description         | Quantity | Total    |
      | Data Shuttle 3.6 TB | 1        | $375.00  |
      | Total Price         |          | $375.00  |
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | $375.00 | $375.00    | $0.00       |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @bus @TC.13533 @resources @tasks_p1
  Scenario: 13533 Add a 100% discount to a charge and quota (add link invoiced partner)
    When I add a new MozyPro partner:
      | period  | base plan | server plan | net terms |
      | 12      | 2 TB      | yes         | yes       |
    And New partner should be created
    And I change root role to FedID role
    When I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.13533.User1 | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by TC.12684.User1
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name   | user_name                | machine_type |
      | Machine1_13533 | <%=@new_users[0].email%> | Desktop      |
    Then I stop masquerading
    When I fill in data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 1     |
    And I input discount percentage value 100
    And I refresh process data shuttle section
    Then Data shuttle order summary should be:
      | Description         | Quantity | Total |
      | Data Shuttle 1.8 TB | 1        | $0.00 |
      | Total Price         |          | $0.00 |
    When I click finish button
    Then Data shuttle order should be created
    And Data shuttle order summary should be:
      | Description         | Quantity | Total |
      | Data Shuttle 1.8 TB | 1        | $0.00 |
      | Total Price         |          | $0.00 |
    When I search order in view data shuttle orders section by newly created partner company name
    Then order search results in data shuttle orders section should be:
      | Pro Partner Name               | # of Drives | Drives Ordered |
      | <%=@partner.company_info.name%>| 1           | Yes            |
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And Partner billing history should be:
      | Date  | Amount     | Total Paid | Balance Due |
      | today | $2,275.00  | $0.00      | $2,275.00   |
    And I act as newly created partner account
    And I navigate to User Group List section from bus admin console page
    When I view (default user group) user group details
    And I open Keys tab
    Then The key appears marked as a data shuttle order
    And I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | $190.00 | $190.00    | $0.00       |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

