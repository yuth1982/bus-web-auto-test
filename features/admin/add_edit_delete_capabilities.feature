Feature: add edit delete capabilities

  Background:
    Given I log in bus admin console as administrator

  ###############################################################################

  # Partner Capabilities

  ################################################################################




  ###############################################################################

  # View External IDs Capability

  ################################################################################

  @TC.1174 @bus @admin @tasks_p2
  Scenario: 1174 Do a search for External IDs in the partner search field
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 10 GB     | yes       |
    And New partner should be created
    And I add a new partner external id
    When I search partner by newly created partner external id
    Then Partner search results should be:
      | External ID  | Partner       | Created | Type    | Root Admin   | Users | Keys      |
      | @external_id | @company_name | today   | MozyPro | @admin_email | 0     | Unlimited |
    And I search and delete partner account by newly created partner company name

# Dont support admin external ID search, will remove it
#  @TC.1175 @bus @admin @tasks_p2
#  Scenario: 1175 Do a search for External IDs in the admin search field
#    And I navigate to Add New Admin section from bus admin console page
#    And I add a new admin:
#      | Roles |
#      | Sales |
#    Then Add New Admin success message should be displayed
#    And I view admin details by:
#      | email             |
#      | <%=@admin.email%> |
#    And I add admin external id
#    And I search admin by:
#      | keywords               |
#      | <%=@admin_external_id%> |
#    Then Admin information in List Admins section should be correct
#      | Name             | Email             | Role  |
#      | <%=@admin.name%> | <%=@admin.email%> | Sales |
#    And I delete admin by:
#      | email             |
#      | <%=@admin.email%> |

  @TC.1177 @bus @admin @tasks_p2
  Scenario: 1177 Do a search for External IDs in the user search field
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 10 GB     | yes       |
    And New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name    | storage_type | devices |
      | TC.1177 | Desktop      | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I add user external id
    When I search user by:
      | keywords               |
      | <%=@user_external_id%> |
    Then User search results should be:
      | External ID            | User        | Name       | Sync     | Machines | Storage | Storage Used | Created  | Backed Up |
      | <%=@user_external_id%> | @user_email | @user_name | Disabled | 0        | Shared  | None         | today    | never     |
    And I stop masquerading
    When I search user by:
      | keywords               |
      | <%=@user_external_id%> |
    Then User search results should be:
      | External ID            | User        | Name       | Partner                         | User Group           | Machines | Storage | Storage Used | Created  | Backed Up |
      | <%=@user_external_id%> | @user_email | @user_name | <%=@partner.company_info.name%> | (default user group) | 0        | Shared  | None         | today    | never     |
    And I search and delete partner account by newly created partner company name

  @TC.1178 @bus @admin @tasks_p2
  Scenario: 1178 Do a search for External IDs in the machine search field
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 10 GB     | yes       |
    And New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name    | storage_type | devices | enable_stash |
      | TC.1178 | Desktop      | 1       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view Sync details
    And I add machine external id
    And I search machine by:
      | keywords                  |
      | <%=@machine_external_id%> |
    Then Machine search results should be:
      | External ID               | Machine | User                        | User Group           | Data Center                | Storage Used |
      | <%=@machine_external_id%> | Sync    | <%=@new_users.first.email%> | (default user group) | <%=QA_ENV['data_center']%> | 0            |
    And I stop masquerading
    And I search machine by:
      | keywords                  |
      | <%=@machine_external_id%> |
    Then Machine search results should be:
      | External ID               | Machine | User                        | User Group           | Data Center                | Storage Used |
      | <%=@machine_external_id%> | Sync    | <%=@new_users.first.email%> | (default user group) | <%=QA_ENV['data_center']%> | 0            |
    And I search and delete partner account by newly created partner company name

  @TC.630 @bus @admin @tasks_p2
  Scenario: 630:Search on purchase info + External ID
    When I add a new MozyPro partner:
      | period | base plan | cc number        | expire month | expire year | cvv |
      | 1      | 10 GB     | 4018121111111122 | 12           | 18          | 123 |
    And New partner should be created
    And I add a new partner external id
    When I navigate to Search / List Partners section from bus admin console page
    When I full search partner by @new_p_external_id;last four digits
    Then Partner search results should be:
      | External ID  | Partner       | Type    |
      | @external_id | @company_name | MozyPro |
    When I full search partner by @new_p_external_id;last four digits;zip code
    Then Partner search results should be:
      | External ID  | Partner       | Type    |
      | @external_id | @company_name | MozyPro |
    And I search and delete partner account by newly created partner company name