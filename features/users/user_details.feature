Feature: User Details

  @TC.19640
  Scenario: Mozy-19640:Access Partner as Partner Admin
    Given I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I act as newly created partner account
    When I add a new user to MozyPro partner:
      | desired_user_storage | device_count |
      | 10                   | 1            |
    Then New user should be created
    When I search user by:
      | keywords    |
      | @root_admin |
    Then User search results should be:
      | User                 | Name         | Machines | Storage | Storage Used | Created  | Backed Up |
      | backup19057@test.com | backup19057  | 0 	   | 2 GB    |	none 	    | 01/03/13 | never     |
    When I view user details by username
    Then User details should be:
      | Name:               | Enable Stash:               |
      | First Last (change) | Yes (Send Invitation Email) |

