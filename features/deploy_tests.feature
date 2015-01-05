Feature: These are the test we run for every deploy

  These are the tests we run for deploys. The correspond to testlink cases
  -Things to do before you can run
  -- $ export BUS_ENV=<environment>
  - If you are running in prod
  -- $ ruby set_credit_card.rb


  Additional Things to check:
  - Delete partner if in prod
  - Prod 50 - Check Download Manifests
  - Prod 29 - Check the support link
  - Prod 89 - Activate in Email

  @bus_smoke
  Scenario: Bus Mozypro smoke
    #Prod 20
    Given I log in bus admin console as administrator
    #Prod 21
    When I add a new MozyPro partner:
    | period | base plan | coupon                | net terms | server plan | root role               |
    | 24     | 10 GB     | <%=QA_ENV['coupon']%> | yes       | yes         | Bundle Pro Partner Root |
    Then New partner should be created
    #Prod 73, 197
    And I get partner aria id
  #TODO Fix staging
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |
    But I activate the partner
    #Prod 22
    When I act as newly created partner account
    #Prod 23
    And I add a new Bundled user group:
      | name   | storage_type |
      | alpha | Shared       |
    Then alpha user group should be created
    When I add a new Bundled user group:
      | name   | storage_type |
      | omega | Shared       |
    Then omega user group should be created
    #Prod 36 - Delete user group
    When I add a new Bundled user group:
      | name   | storage_type |
      | gamma | Shared       |
    Then gamma user group should be created
    When I delete user group details by name: gamma
    Then gamma user group should be deleted
    #Prod 24 - Create a user
    And I add new user(s):
      | name | user_group | storage_type |  devices |
      | user | alpha      | Desktop      |  1       |
    Then 1 new user should be created
    #Prod 31 - Run report
    Given I build a new report:
      | type            | name                |
      | Billing Detail  | billing detail test |
    Then Billing detail report should be created
    And Scheduled report list should be:
      | Name                | Type            | Recipients                      | Schedule | Actions |
      | billing detail test | Billing Detail  | <%=@partner.admin_info.email%>  | Daily    | Run     |
#TODO download report
    When I delete billing detail test scheduled report
    Then I should see No results found in scheduled reports list
    #Prod 177 - Update a username & password
    Given  I navigate to Search / List Users section from bus admin console page
    When I view user details by @user_email
    Then edit user details:
      | email                  |
      | <%=create_user_email%> |
    Then I update the user password to Test1234
    #Prod 26
    But I reassign the user to user group omega
    Then the user's user group should be omega
    #I close the user detail page
    #Prod 32
    Given I delete user
    #Prod 27 - Open all Resources headers
    Given I navigate to Resource Summary section from bus admin console page
    When I navigate to User Group List section from bus admin console page
    Then I navigate to Change Plan section from bus admin console page
    And  I navigate to Billing Information section from bus admin console page
    But  I navigate to Billing History section from bus admin console page
    Then I navigate to Change Payment Information section from bus admin console page
    When I navigate to Download * Client section from bus admin console page
    #Prod 49 - Delete partner and test that they are in Pending Delete
    When I stop masquerading
    Then I delete partner and verify pending delete

  @bus_smoke
  Scenario: MozyEnterprise smoke
    #Prod 198,179
    Given I log in bus admin console as administrator
    When I add a new MozyEnterprise partner:
      | period | users  | coupon                |  server plan | net terms |
      | 24     | 10     | <%=QA_ENV['coupon']%> |  100 GB      | yes       |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Server       | 10            | 3       |
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
    When I stop masquerading
    Then I delete partner and verify pending delete

  @bus_smoke
  Scenario: MozyFortress smoke
    #Prod 199
    Given I log in bus admin console as administrator
    When I act as partner by:
      | name     | including sub-partners |
      | Fortress | no                     |
    And I add a new sub partner:
      | Company Name                       |
      | Fortress Internal Test Sub Partner |
    Then New partner should be created
    When I stop masquerading
    And I search partner by Fortress Internal Test Sub Partner
    And I view partner details by Fortress Internal Test Sub Partner
    Then partner account details should be:
      | Account Type | Sales Origin | Sales Channel |
      | N/A (change) | Sales        | N/A (change)  |
    And I delete partner account

  @bus_smoke
  Scenario: MozyPro smoke: others for BUS_US
    #Prod 377 order data shuttle
    Given I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | create under | server plan | net terms |
      | 1      | 100 GB    | MozyPro      | yes         | yes       |
    And New partner should be created
    #Prod 180.1
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 100       | 100      | 0    | Unlimited | Unlimited |
    And I change root role to FedID role
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 30            | 1       |
    And I search user by:
      | keywords |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    #Prod 25 - client config
    When I create a new client config:
      | name                 | type   |
      | deploy_client_config | Server |
    Then client configuration section message should be Your configuration was saved.
    Then I stop masquerading
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    #Prod 180.2
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 100       | 100      | 1    | Unlimited | Unlimited |
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 20    |
    Then Data shuttle order should be created
    #Prod 178
    When I navigate to Search / List Machines section from bus admin console page
    Then Search list machines section is opened
    And I search and delete partner account by newly created partner company name


