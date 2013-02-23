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
    Then user search results should be:
      | External ID | User        | Name       | Machines | Storage | Storage Used | Created  | Backed Up |
      |             | @user_email | @user_name | 0        | 2 GB    | none         | today    | never     |    
    When I view user details by @user_email
    Then user details should be:
      | Name:               | Enable Stash:               |
      | First Last (change) | Yes (Send Invitation Email) |

