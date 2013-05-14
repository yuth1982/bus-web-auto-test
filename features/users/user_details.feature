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
      | Stash Container |                    |                      |                  |        |
      | Stash           | 0 / 40 GB          | Set                  | N/A              |        |


