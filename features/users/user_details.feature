Feature: User Details

  @TC.19057
  Scenario: Mozy-19057:Access Partner as Partner Admin
    Given I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I act as newly created partner account
    When I add a new user to a MozyPro partner:
      | desired_user_storage | device_count | user type           |
      | 2                    | 1            | Desktop Backup Only |
    Then New user should be created
    When I search user by:
      | keywords    |
      | @user_name |
    Then User search results should be:
      | External ID | User        | Name       | Machines | Storage | Storage Used | Created  | Backed Up |
      |             | @user_email | @user_name | 0        | 2 GB    | none         | today    | never     |
    When I view user details by @user_email
    Then user details should be:
      | Name:               | Enable Stash:               |
      | First Last (change) | Yes (Send Invitation Email) |

  @TC.20986
  Scenario: 20986 "Last Update" shows the time for the 3 device whose last backup time is 5 days ago
    Given I log in bus admin console as administrator
    When I act as partner by:
      | email                |
      | last_update@auto.com |
    When I search user by:
      | keywords             |
      | last_update@test.com |
    Then User search results should be:
      | User                 | Name        | Machines |Stash    | Machines | Storage | Storage Used |
      | last_update@test.com | last_update | 0        | Enabled | 3        | Shared  | 60 GB        |
    When I view user details by last_update@test.com
    Then device table in user details should be:
      | Device          | Used/Available     | Device Storage Limit | Last Update      | Action |
      | machine1        | 0 / 40 GB          | Set                  | N/A              |        |
      | machine2        | 30 GB / 40 GB      | Set                  | 04/08/2013 03:51 |        |
      | machine3        | 30 GB / 40 GB      | Set                  | 03/01/2013 15:51 |        |
    And stash device table in user details should be:
      | Stash Container | Used/Available     | Device Storage Limit | Last Update      | Action |
      | Stash           | 0 / 40 GB          | Set                  | N/A              |        |

  @TC.20986__
  Scenario: 20986 (create machine dynamically) "Last Update" shows the time for the 3 device whose last backup time is 5 days ago
    Given I log in bus admin console as administrator
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 2     |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.20986.User | (default user group) | Desktop      |               | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | Machine1     | Desktop      | @partner_name |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 10 GB
    And I refresh User Details section
    Then device table in user details should be:
      | Device          | Storage Type |Used/Available     | Device Storage Limit | Last Update      | Action |
      | Machine1        | Desktop      |10 GB / 40 GB      | Set                  | < a minute ago   |        |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20986_
  Scenario: (Create machine for an existed partner)20986 "Last Update" shows the time for the 3 device whose last backup time is 5 days ago
    Given I log in bus admin console as administrator
    And I search partner by last_update@auto.com
    When I view partner details by Test Last Update
    And I get the partner_id
    And I act as partner by:
      | email                |
      | last_update@auto.com |
    And I search user by:
      | keywords             |
      | last_update@test.com |
    Then User search results should be:
      | User                 | Name        | Machines |Stash    | Machines | Storage | Storage Used |
      | last_update@test.com | last_update | 0        | Enabled | 3        | Shared  | 60 GB        |
    When I view user details by last_update@test.com
    And I update the user password to @user_password
    And I use keyless activation to activate devices
      | user_email           | machine_name | machine_type | partner_name     |
      | last_update@test.com | machine4     | Desktop      | Test Last Update1 |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 10 GB
    And I refresh User Details section
    Then device table in user details should be:
      | Device          | Used/Available     | Device Storage Limit | Last Update      | Action |
      | machine1        | 0 / 30 GB          | Set                  | N/A              |        |
      | machine2        | 30 GB / 30 GB      | Set                  | 04/08/2013 03:51 |        |
      | machine3        | 30 GB / 30 GB      | Set                  | 03/01/2013 15:51 |        |
      | machine4        | 10 GB / 30 GB      | Set                  | < a minute ago   |        |
    And stash device table in user details should be:
      | Stash Container | Used/Available     | Device Storage Limit | Last Update      | Action |
      | Stash           | 0 / 30 GB          | Set                  | N/A              |        |
    When I delete device by name: machine4
    Then device table in user details should be:
      | Device          | Used/Available     | Device Storage Limit | Last Update      | Action |
      | machine1        | 0 / 40 GB          | Set                  | N/A              |        |
      | machine2        | 30 GB / 40 GB      | Set                  | 04/08/2013 03:51 |        |
      | machine3        | 30 GB / 40 GB      | Set                  | 03/01/2013 15:51 |        |
    And stash device table in user details should be:
      | Stash Container | Used/Available     | Device Storage Limit | Last Update      | Action |
      | Stash           | 0 / 40 GB          | Set                  | N/A              |        |
    And I close user details section
    When I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.20986.User | (default user group) | Desktop      |               | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name     |
      | @user_email | Machine1     | Desktop      | Test Last Update |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 10 GB
    And I refresh User Details section
    Then device table in user details should be:
      | Device    | Used/Available     | Device Storage Limit | Last Update      | Action |
      | Machine1  | 10 GB / 30 GB      | Set                  | < a minute ago   |        |
    Then I delete device by name: Machine1

  @TC.21020
  Scenario: 21020 [Itemized]List all the active devices including stash
    Given I log in bus admin console as administrator
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name             |
      | 12     | 8     | 100 GB      | yes       | [Itemized] User Detail   |
    Then New partner should be created
    And I enable stash for the partner with 5 GB stash storage
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.21020.User | (default user group) | Desktop      |               | 4       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I add stash for the user with:
      | stash quota | send email |
      | default     | no         |
    And I update the user password to default password
    And I add 3 machines for the user and update its used quota
      | user_email  | machine_name | machine_type | partner_name  | used_quota |
      | @user_email | Machine1     | Desktop      | @partner_name | 10 GB      |
      | @user_email | Machine2     | Desktop      | @partner_name | 20 GB      |
      | @user_email | Machine3     | Desktop      | @partner_name | 30 GB      |
    And I refresh User Details section
    Then device table in user details should be:
      | Device          | Storage Type |Used/Available     | Device Storage Limit | Last Update      | Action |
      | Machine1        | Desktop      |10 GB / 140 GB     | Set                  | < a minute ago   |        |
      | Machine2        | Desktop      |20 GB / 140 GB     | Set                  | < a minute ago   |        |
      | Machine3        | Desktop      |30 GB / 140 GB     | Set                  | < a minute ago   |        |
    Then stash device table in user details should be:
      | Stash Container | Used/Available     | Device Storage Limit | Last Update      | Action |
      | Stash           | 0 / 140 GB         | Set                  | N/A              |        |

  @TC.21096
  Scenario: 21096 [Itemized]Edit the number of Desktop Device
    Given I log in bus admin console as administrator
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name             |
      | 12     | 8     | 100 GB      | yes       | [Itemized]Edit Device    |
    Then New partner should be created
    And I enable stash for the partner with 10 GB stash storage
    When I get the partner_id
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices | enable_stash |
      | Test | Shared               | 5               | Shared              | 10             | yes          |
    And I add new user(s):
      | name          | user_group | storage_type | storage_limit | devices | enable_stash |
      | TC.21096.User | Test       | Desktop      | 50            | 3       | yes          |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I add 2 machines for the user and update its used quota
      | user_email  | machine_name | machine_type | partner_name  | used_quota |
      | @user_email | Machine1     | Desktop      | @partner_name | 0 GB       |
      | @user_email | Machine2     | Desktop      | @partner_name | 0 GB       |
    And I refresh User Details section
    When I set device quota field to 4 and cancel
    Then users' device status should be:
      | Used | Available | storage_type |
      |  2   | 1         | Desktop      |
    When I edit user device quota to 4
    Then users' device status should be:
      | Used | Available | storage_type |
      | 2    | 2         | Desktop      |
    When I view the user's product keys
    Then Number of Desktop activated keys should be 2
    And Number of Desktop unactivated keys should be 2
    When I edit user device quota to 2
    When I view the user's product keys
    Then Number of Desktop activated keys should be 2
    And Number of Desktop unactivated keys should be 0

  @TC.21097
  Scenario: 21097 [Itemized]Error shows when I add more Server devices than available in UG
    Given I log in bus admin console as administrator
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name             |
      | 12     | 8     | 100 GB      | yes       | [Itemized]No More Device |
    Then New partner should be created
    And I enable stash for the partner with 10 GB stash storage
    When I get the partner_id
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices | enable_stash |
      | Test | Shared               | 5               | Shared              | 10             | yes          |
    And I add new user(s):
      | name  | user_group | storage_type | storage_limit | devices | enable_stash |
      | User1 | Test       | Server       | 50            | 3       | no           |
    Then 1 new user should be created
    And I add new user(s):
      | name  | user_group | storage_type | storage_limit | devices | enable_stash |
      | User2 | Test       | Server       | 50            | 5       | no           |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    When I edit user device quota to 8
    Then No more device error show