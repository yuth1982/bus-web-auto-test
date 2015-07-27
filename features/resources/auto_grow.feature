Feature: Auto Grow

  As an admin,
  I would like to give partners the option to consume more resources than allocated and be billed for those resources,
  So that their business can grow easily and with minimal hassle

  Success Criteria:

  @TC.14115 @bus @env_dependent
  Scenario: Mozy-14115::Enable autogrow partner admin
#    When I log in to legacy bus01 as administrator
#    And I successfully add an itemized Reseller partner:
#      | period | desktop licenses | desktop quota |
#      | 12     | 2                | 2             |
#    And I log in bus admin console as administrator
#    And I search partner by:
#      | name          | filter |
#      | @company_name | None   |
#    And I view partner details by newly created partner company name
#    And I get the partner_id
#    And I migrate the partner to aria
#    And I Enable partner details autogrow
#    Then partner details message should be
#    """
#    Autogrow protection enabled.
#    """
#    And I migrate the partner to pooled storage
    When I log in bus admin console as administrator
    When I search partner by Itemized_Reseller_DONOT_ChangePlan(Migrate)
    And I view partner details by Itemized_Reseller_DONOT_ChangePlan(Migrate)
    And I get the partner_id
    And I get the partners name Itemized_Reseller_DONOT_ChangePlan(Migrate) and type Reseller
    When I act as partner by:
      | email                  |
      | qa1+ruby_gem@decho.com |
    And I add new user(s):
      | user_group | storage_type | devices |
      | UG 1       | Desktop      | 1        |
    And 1 new user should be created
    And I search user by:
      | keywords   | user type                                         |
      | @user_name | Itemized_Reseller_DONOT_ChangePlan(Migrate) Users |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    And I get the machine_id by license_key
    And I upload 1 GB of data to device
    Then tds returns successful upload
    And I delete user


  @TC.14116 @bus
  Scenario: Mozy-14116::Autogrow enabled billing
    When I log in bus admin console as administrator
    And I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 2              | yes         |
    Then New partner should be created
    And I get the partner_id
    And I act as newly created partner
    And I navigate to Billing Information section from bus admin console page
    And I Enable billing info autogrow
    And I add a new Bundled user group:
      | name | storage_type | limited_quota | server_support |
      | UG 1 | Limited      | 1             | yes            |
    Then UG 1 user group should be created
    And I add new user(s):
      | user_group | storage_type | devices |
      | UG 1       | Server       | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Server device without a key and with the default password
    And I get the machine_id by license_key
    And I upload 2 GB of data to device
    Then tds return message should be:
    """
    Account or container quota has been exceeded
    """
    And I add a new Bundled user group:
      | name | storage_type | server_support |
      | UG 2 | Shared       | yes            |
    Then UG 2 user group should be created
    And I add new user(s):
      | user_group | storage_type | devices |
      | UG 2       | Desktop      | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    And I get the machine_id by license_key
    And I upload 2 GB of data to device
    Then tds returns successful upload
    And I stop masquerading
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And I view partner details by newly created partner company name
    And I search and delete partner account by newly created partner company name

  @TC.21963 @bus @slow @env_dependent
  Scenario: 21963 - Autogrow Smoke - A Partner with Autogrow Enabled Can Overdraft Resources on Shared Usergroups
    When an Auto Grow Org is created
    And I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | User                    | Name          | User Group  | Machines | Storage | Storage Used |
      | <%=@users.first.email%> | Jane Assigned | Assigned UG | 0        | Shared  | None         |
      | <%=@users[2].email%>    | Jane Limited  | Limited UG  | 0        | Shared  | None         |
      | <%=@users[1].email%>    | John Shared   | Shared UG   | 0        | Shared  | None         |
    And I view details of <%=@users[1].email%>'s user group
    Then User group details should be:
      | Available Quota: |
      | 15 GB(Shared)    |
    And I close the user group detail page
    And I close the user detail page
    And I view details of <%=@users.first.email%>'s user group
    Then User group details should be:
      | Available Quota:     |
      | 5 GB(Assigned: 5 GB) |
    And I close the user group detail page
    And I close the user detail page
    And I view details of <%=@users[2].email%>'s user group
    Then User group details should be:
      | Available Quota:    |
      | 3 GB(Limited: 3 GB) |
    And I close the user group detail page
    And I close the user detail page
    And I search user by:
      | keywords                |
      | <%=@users.first.email%> |
    And I view user details by <%=@users.first.email%>
    And I update the user password to default password
    And I close the user detail page
    Then I use keyless activation to activate devices
      | machine_name | user_name               | machine_type |
      | Machine 1    | <%=@users.first.email%> | Desktop      |
    And I get the machine id for client 0 by license key <%=@clients.first.license_key%>
    And I upload data to device
      | machine_id                     | GB | user_name               |
      | <%=@clients.first.machine_id%> | 6  | <%=@users.first.email%> |
    Then tds return message should be:
    """
    Account or container quota has been exceeded
    """
    And I navigate to Search / List Users section from bus admin console page
    And I clear user search results
    Then User search results should be:
      | User                    | Name          | User Group  | Machines | Storage | Storage Used |
      | <%=@users.first.email%> | Jane Assigned | Assigned UG | 1        | Shared  | 4.7 GB       |
      | <%=@users[2].email%>    | Jane Limited  | Limited UG  | 0        | Shared  | None         |
      | <%=@users[1].email%>    | John Shared   | Shared UG   | 0        | Shared  | None         |
    And I view details of <%=@users[1].email%>'s user group
    Then User group details should be:
      | Available Quota: |
      | 15 GB(Shared)    |
    And I close the user group detail page
    And I close the user detail page
    And I view details of <%=@users.first.email%>'s user group
    Then User group details should be:
      | Available Quota:     |
      | 0 GB(Assigned: 5 GB) |
    And I close the user group detail page
    And I close the user detail page
    And I view details of <%=@users[2].email%>'s user group
    Then User group details should be:
      | Available Quota:    |
      | 3 GB(Limited: 3 GB) |
    And I close the user group detail page
    And I close the user detail page
    And I clear user search results
    And I search user by:
      | keywords             |
      | <%=@users[2].email%> |
    And I view user details by <%=@users[2].email%>
    And I update the user password to default password
    And I close the user detail page
    Then I use keyless activation to activate devices
      | machine_name | user_name            | machine_type |
      | Machine 2    | <%=@users[2].email%> | Desktop      |
    And I get the machine id for client 1 by license key <%=@clients[1].license_key%>
    And I upload data to device
      | machine_id                  | GB | user_name            |
      | <%=@clients[1].machine_id%> | 4  | <%=@users[2].email%> |
    Then tds return message should be:
    """
    Account or container quota has been exceeded
    """
    And I navigate to Search / List Users section from bus admin console page
    And I clear user search results
    Then User search results should be:
      | User                    | Name          | User Group  | Machines | Storage | Storage Used |
      | <%=@users.first.email%> | Jane Assigned | Assigned UG | 1        | Shared  | 4.7 GB       |
      | <%=@users[2].email%>    | Jane Limited  | Limited UG  | 1        | Shared  | 2.8 GB       |
      | <%=@users[1].email%>    | John Shared   | Shared UG   | 0        | Shared  | None         |
    And I view details of <%=@users[1].email%>'s user group
    Then User group details should be:
      | Available Quota: |
      | 12 GB(Shared)    |
    And I close the user group detail page
    And I close the user detail page
    And I view details of <%=@users.first.email%>'s user group
    Then User group details should be:
      | Available Quota:     |
      | 0 GB(Assigned: 5 GB) |
    And I close the user group detail page
    And I close the user detail page
    And I view details of <%=@users[2].email%>'s user group
    Then User group details should be:
      | Available Quota:    |
      | 0 GB(Limited: 3 GB) |
    And I close the user group detail page
    And I close the user detail page
    And I clear user search results
    And I search user by:
      | keywords             |
      | <%=@users[1].email%> |
    And I view user details by <%=@users[1].email%>
    And I update the user password to default password
    And I close the user detail page
    Then I use keyless activation to activate devices
      | machine_name | user_name            | machine_type |
      | Machine 3    | <%=@users[1].email%> | Server       |
    And I get the machine id for client 2 by license key <%=@clients[2].license_key%>
    And I upload data to device
      | machine_id                  | GB | user_name            |
      | <%=@clients[2].machine_id%> | 18 | <%=@users[1].email%> |
    Then tds returns successful upload
    And I navigate to Search / List Users section from bus admin console page
    And I clear user search results
    Then User search results should be:
      | User                    | Name          | User Group  | Machines | Storage | Storage Used |
      | <%=@users.first.email%> | Jane Assigned | Assigned UG | 1        | Shared  | 4.7 GB       |
      | <%=@users[2].email%>    | Jane Limited  | Limited UG  | 1        | Shared  | 2.8 GB       |
      | <%=@users[1].email%>    | John Shared   | Shared UG   | 1        | Shared  | 16.8 GB      |
    And I view details of <%=@users[1].email%>'s user group
    Then User group details should be:
      | Available Quota: |
      | -5 GB(Shared)    |
    And I close the user group detail page
    And I close the user detail page
    And I view details of <%=@users.first.email%>'s user group
    Then User group details should be:
      | Available Quota:     |
      | 0 GB(Assigned: 5 GB) |
    And I close the user group detail page
    And I close the user detail page
    And I view details of <%=@users[2].email%>'s user group
    Then User group details should be:
      | Available Quota:     |
      | -5 GB(Limited: 3 GB) |
    And I close the user group detail page
    And I close the user detail page
    And I navigate to Resource Summary section from bus admin console page
    Then Bundled storage summary should be:
      | Available | Used    |
      | 0         | 24.6 GB |
    When I stop masquerading
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used    | Available | Assigned | Used | Available | Assigned  |
      | 24.6 GB | 0         | 20 GB    | 3    | Unlimited | Unlimited |
    And the overdraft script should report:
    """
    Partner <%=@current_partner[:id]%> is using autogrow and is overdrafted on its Generic license by 5 GB
    """
    And I search and delete partner account by newly created partner company name
