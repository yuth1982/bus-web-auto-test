Feature: view edit machine details


  Background:
    Given I log in bus admin console as administrator


  ###############################################################################

  # view backup restores history
  # using fixed data, company Dont Edit_backup_restore_history  ID: 3431834
  ###############################################################################

  @TC.122155 @bus @machines_sync @tasks_p2
  Scenario: 122155:View Backup History
    When I navigate to bus admin console login page
    And I log in bus admin console with user name mozybus+backupsrestores@gmail.com and password default password
    When I search machine by:
      | machine_name   |
      | CNENCHENC33L1C |
    And I view machine details for mozybus+backup+restore@emc.com
    And Backups table will display as:
      | Start Time     | Type                | Duration | Result            | Files | Size | Files Encoded | Size Encoded | Files Transferred | Size Transferred |
      | 10/08/15 17:53 | Local Manual Backup | 00:00:08 | LocalBackupError0 | 1 	| 284  | 0            | 0             |	0                 | 0                |
      | 10/08/15 17:52 | Manual Backup       | 00:01:37 | Success 	        | 1 	| 284  | 1 	          | 288 bytes     |	1                 |	288 bytes        |
      | 10/08/15 17:52 | Manual Backup       | 00:00:14 | CancelError0 	    | 0 	| 0    | 0            | 0             |	0                 | 0                |
      | 08/04/15 11:29 | Local Manual Backup | 00:00:06 | LocalBackupError0 | 41    | 6904 | 0            | 0             |	0                 | 0                |
      | 08/04/15 11:28 | Manual Backup       | 00:01:19 | Success 	        | 41    | 6904 | 1 	          | 24 bytes      |	1 	              | 24 bytes         |
      | 08/04/15 11:27 | Local Manual Backup | 00:00:10 | LocalBackupError0 | 41    | 6901 | 0            | 0             |	0                 | 0                |
      | 08/04/15 11:26 | Manual Backup       | 00:01:40 | Success 	        | 41    | 6901 | 1            |	16 bytes      |	1                 |	16 bytes         |
      | 08/03/15 18:40 | Local Manual Backup | 00:00:12 | LocalBackupError0 | 40    | 6887 | 0            | 0             |	0                 | 0                |
      | 08/03/15 18:38 | Manual Backup       | 00:01:59 | Success 	        | 40    | 6887 | 40 	      | 6.9 KB        |	40                |	6.9 KB           |

  @TC.122156 @bus @machines_sync @tasks_p2
  Scenario: 122156:View Restore History
    When I navigate to bus admin console login page
    And I log in bus admin console with user name mozybus+backupsrestores@gmail.com and password default password
    When I search machine by:
      | machine_name   |
      | CNENCHENC33L1C |
    And I view machine details for mozybus+backup+restore@emc.com
    And Restores table will display as:
      | ID    | Date/Time Requested | Date/Time Finished | Files Retrieved | Size  | Status / Downloads                       |
      | 21284 |	08/11/15 05:05 	    | 08/10/15 15:07     | 41 / 41 	       | 1 DVD | Retrieved files; preparing to burn DVDs. |
      | 20707 |	08/07/15 00:52 	    | 08/06/15 10:54 	 | 41 / 41         | 1 DVD | Retrieved files; preparing to burn DVDs. |





  ###############################################################################

  # view edit details

  ###############################################################################

  @TC.21056 @bus @machines_sync @tasks_p2
  Scenario: 21056 Verify retention period for MozyPro direct Germany
    When I add a new MozyPro partner:
      | period | base plan | country  | create under     | net terms |
      | 12     | 8 TB      | Germany  | MozyPro Germany  | yes       |
    Then New partner should be created
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | name          | storage_type | storage_limit | devices |
      | TC.21056.User | Desktop      | 50            | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine1_21056 | <%=@new_users.first.email%> | Desktop      |
    When I got client config for the user machine:
      | user_name                   | machine                   | platform | arch | codename | version |
      | <%=@new_users.first.email%> | <%=@client.machine_hash%> | windows  | x86  | mozypro  | 0.0.0.2 |
    Then retention period should be 60 days
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21057 @bus @machines_sync @tasks_p2
  Scenario: 21057 Verify retention period for MozyHome Germany
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 12     | 125 GB    | Germany | Deutschland     | 4188181111111112 |
    Then the user is successfully added.
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    When I view Sync details
    And I get machine details info
    When I got client config for the user machine:
      | user_name           | machine                     | platform | arch | codename | version |
      | <%=@mh_user_email%> | <%=@machine_info['Hash:']%> | windows  | x86  | mozy     | 0.0.0.2 |
    Then retention period should be 30 days
    And I delete user

  @TC.21058 @bus @machines_sync @tasks_p2
  Scenario: 21058 Verify retention period for MozyPro Germany reseller
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | create under     | net terms |
      | 12     | Silver        | 100            | MozyPro Germany  | yes       |
    Then New partner should be created
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.21058.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.21058.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine1_21058 | <%=@new_users.first.email%> | Desktop      |
    When I got client config for the user machine:
      | user_name                   | machine                   | platform | arch | codename | version |
      | <%=@new_users.first.email%> | <%=@client.machine_hash%> | windows  | x86  | mozypro  | 0.0.0.2 |
    Then retention period should be 90 days
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21059 @bus @machines_sync @tasks_p2
  Scenario: 21059 Verify retention period for MozyEnterprise UK
    When I add a new MozyEnterprise partner:
      | period | users | server plan | country        | net terms |
      | 12     | 10    | 250 GB      | United Kingdom | yes       |
    Then New partner should be created
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.21059.User | (default user group) | Server       | 50            | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine1_21059 | <%=@new_users.first.email%> | Server       |
    When I got client config for the user machine:
      | user_name                   | machine                   | platform | arch   | codename       | version |
      | <%=@new_users.first.email%> | <%=@client.machine_hash%> | linux    | deb-32 | MozyEnterprise | 0.0.0.2 |
    Then retention period should be 90 days
    When I stop masquerading
    And I search and delete partner account by newly created partner company name


  ###############################################################################

  # Machines: Device Storage Limit

  ###############################################################################

  @TC.22475 @bus @machines_sync @tasks_p2
  Scenario: 22475 Backup a desktop for DPS customers
    When I navigate to Add New Partner section from bus admin console page
    And I select company type as MozyEnterprise DPS
    Then storage based plan shows while user based plan and server add-on not show
    When I add a new MozyEnterprise DPS partner:
      | period | base plan | country       | address           | city      | state abbrev | zip   | phone          | sales channel |
      | 12     | 100       | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 | Velocity      |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 100 TB    | 100 TB   | 0    | Unlimited | Unlimited |
    When I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.22475.User | (default user group) | Desktop      | 1024          | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And user resources details rows should be:
      | Storage                 | Devices                            |
      | 0 Used / 1 TB Available | Desktop: 0 Used / 2 Available Edit |
    And I update the user password to default password
    And I use keyless activation to activate devices
      | machine_name   | machine_type |
      | Machine1_22475 | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 1  |
    And I refresh User Details section
    Then device table in user details should be:
      | Device         | Used/Available | Device Storage Limit | Last Update | Action |
      | Machine1_22475 | 1 GB / 1023 GB | Set                  | N/A         |        |
    When I set machine max for Machine1_22475
    And I input the machine max value for Machine1_22475 to 1025 GB
    And The range of machine max for Machine1_22475 by tooltips should be:
      | Min | Max  |
      | 0   | 1024 |
    And I save machine max for Machine1_22475
    Then set max message should be:
      """
      Machine Storage limit cannot be set to 1025 GB, out of resources.
      """
    When I set machine max for Machine1_22475
    And I input the machine max value for Machine1_22475 to -1 GB
    And I save machine max for Machine1_22475
    Then set max alert should be:
      """
      Please enter a positive integer
      """
    And I cancel machine max for Machine1_22475
    And I stop masquerading
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 1 GB | 100 TB    | 100 TB   | 1    | Unlimited | Unlimited |
    When I act as newly created partner account
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view machine Machine1_22475 details from user details section
    When I delete device by name: Machine1_22475
    Then the popup message when delete device is Do you want to delete Machine1_22475?
    When I refresh User Details section
    Then Device Machine1_22475 should not show
    And I stop masquerading
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 100 TB    | 100 TB   | 0    | Unlimited | Unlimited |
    And I delete partner account

  @TC.22476 @bus @machines_sync @tasks_p2
  Scenario: 22476 Backup a server for DPS customers
    When I add a new MozyEnterprise DPS partner:
      | period | base plan | country       | sales channel |
      | 12     | 100       | United States | Velocity      |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 100 TB    | 100 TB   | 0    | Unlimited | Unlimited |
    When I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.22476.User | (default user group) | Server       | 1024          | 2       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And user resources details rows should be:
      | Storage                 | Devices                           |
      | 0 Used / 1 TB Available | Server: 0 Used / 2 Available Edit |
    And I update the user password to default password
    And I use keyless activation to activate devices
      | machine_name   | machine_type |
      | Machine1_22476 | Server       |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 1  |
    And I refresh User Details section
    Then device table in user details should be:
      | Device         | Used/Available | Device Storage Limit | Last Update | Action |
      | Machine1_22476 | 1 GB / 1023 GB | Set                  | N/A         |        |
    When I set machine max for Machine1_22476
    And I input the machine max value for Machine1_22476 to 1025 GB
    And The range of machine max for Machine1_22476 by tooltips should be:
      | Min | Max  |
      | 0   | 1024 |
    And I save machine max for Machine1_22476
    Then set max message should be:
      """
      Machine Storage limit cannot be set to 1025 GB, out of resources.
      """
    When I set machine max for Machine1_22476
    And I input the machine max value for Machine1_22476 to -1 GB
    And I save machine max for Machine1_22476
    Then set max alert should be:
      """
      Please enter a positive integer
      """
    And I cancel machine max for Machine1_22476
    And I stop masquerading
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 1 GB | 100 TB    | 100 TB   | 1    | Unlimited | Unlimited |
    When I act as newly created partner account
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view machine Machine1_22476 details from user details section
    When I delete device by name: Machine1_22476
    Then the popup message when delete device is Do you want to delete Machine1_22476?
    When I refresh User Details section
    Then Device Machine1_22476 should not show
    And I stop masquerading
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 100 TB    | 100 TB   | 0    | Unlimited | Unlimited |
    And I delete partner account

  @TC.119220 @bus @machines_sync @tasks_p2
  Scenario: 119220:Back up desktop server stash with storage more than device storage limit for DPS customer
    When I add a new MozyEnterprise DPS partner:
      | period | base plan | sales channel |
      | 12     | 1         | Velocity      |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 1 TB      | 1 TB     | 0    | Unlimited | Unlimited |
    When I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.119220.User1 | (default user group) | Desktop      | 1             | 2       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And user resources details rows should be:
      | Storage                 | Devices                            |
      | 0 Used / 1 GB Available | Desktop: 0 Used / 2 Available Edit |
    And I update the user password to default password
    And I use keyless activation to activate devices
      | machine_name    | machine_type |
      | Machine1_119220 | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 2  |
    Then tds return message should be:
      """
      Account or container quota has been exceeded
      """
    And I refresh User Details section
    Then device table in user details should be:
      | Device          | Used/Available | Device Storage Limit | Last Update | Action |
      | Machine1_119220 | 0 / 1 GB       | Set                  | N/A         |        |
    When I set machine max for Machine1_119220
    And I input the machine max value for Machine1_119220 to 2 GB
    And The range of machine max for Machine1_119220 by tooltips should be:
      | Min | Max |
      | 0   | 1   |
    And I save machine max for Machine1_119220
    Then set max message should be:
      """
      Machine Storage limit cannot be set to 2 GB, out of resources.
      """
    When I set machine max for Machine1_119220
    And I input the machine max value for Machine1_119220 to -1 GB
    And I save machine max for Machine1_119220
    Then set max alert should be:
      """
      Please enter a positive integer
      """
    And I cancel machine max for Machine1_119220
    And stash device table in user details should be:
      | Sync Container | Used/Available | Device Storage Limit | Last Update      | Action |
      | Sync           | 0 / 1 GB       | Set                  | N/A              |        |
    When I view Sync details
    And I get machine details info
    When I upload data to device by batch
      | machine_id                | GB |
      | <%=@machine_info['ID:']%> | 2  |
    Then tds return message should be:
      """
      Account or container quota has been exceeded
      """
    When I set machine max for Sync
    And I input the machine max value for Sync to 2 GB
    And The range of machine max for Sync by tooltips should be:
      | Min | Max |
      | 0   | 1   |
    And I save machine max for Sync
    Then set max message should be:
      """
      The Sync Storage limit cannot be more than what is available for this user.
      """
    When I set machine max for Sync
    And I input the machine max value for Sync to -1 GB
    And I save machine max for Sync
    Then set max alert should be:
      """
      Please enter a positive integer
      """
    And I cancel machine max for Sync
    And I close User Details section
    And I add new user(s):
      | name            | user_group           | storage_type | storage_limit | devices |
      | TC.119220.User2 | (default user group) | Server       | 1             | 2       |
    Then 1 new user should be created
    And I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And user resources details rows should be:
      | Storage                 | Devices                           |
      | 0 Used / 1 GB Available | Server: 0 Used / 2 Available Edit |
    And I update the user password to default password
    And I use keyless activation to activate devices
      | machine_name    | machine_type |
      | Machine2_119220 | Server       |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 2  |
    Then tds return message should be:
      """
      Account or container quota has been exceeded
      """
    And I refresh User Details section
    Then device table in user details should be:
      | Device          | Used/Available | Device Storage Limit | Last Update | Action |
      | Machine2_119220 | 0 / 1 GB       | Set                  | N/A         |        |
    When I set machine max for Machine2_119220
    And I input the machine max value for Machine2_119220 to 2 GB
    And The range of machine max for Machine2_119220 by tooltips should be:
      | Min | Max |
      | 0   | 1   |
    And I save machine max for Machine2_119220
    Then set max message should be:
      """
      Machine Storage limit cannot be set to 2 GB, out of resources.
      """
    When I set machine max for Machine2_119220
    And I input the machine max value for Machine2_119220 to -1 GB
    And I save machine max for Machine2_119220
    Then set max alert should be:
      """
      Please enter a positive integer
      """
    And I cancel machine max for Machine2_119220
    And I stop masquerading
    Then I search and delete partner account by newly created partner company name

#  @TC.122433 @bus @machines_sync @tasks_p2
#  Scenario: 122433:Linux machines displayed correctly in the machine list view
#    When I add a new MozyEnterprise partner:
#      | period | users | server plan |
#      | 12     | 10    | 250 GB      |
#    Then New partner should be created
#    And I view the newly created partner admin details
#    Then I active admin in admin details default password
#    When I act as newly created partner account
#    And I add new user(s):
#      | name           | user_group           | storage_type | storage_limit | devices |
#      | TC.122433.User | (default user group) | Server       | 50            | 3       |
#    Then 1 new user should be created
#    When I navigate to Search / List Users section from bus admin console page
#    And I view user details by newly created user email
#    And I update the user password to default password
#    And I use keyless activation to activate devices
#      | user_email  | machine_name  | machine_type |
#      | @user_email | auto_generate | Server       |
#    And I upload data to device by batch
#      | machine_id              | GB |
#      | <%=@client.machine_id%> | 1  |
#    And I log out bus admin console
#    And I navigate to bus admin console login page
#    And I log in bus admin console with user name @partner.admin_info.email and password default password
#    Then I login as mozypro admin successfully
#    And I navigate to Search / List Machines section from bus admin console page
#    Then Machine search results should be:
#      | Machine                    | User                        | User Group           | Data Center                | Storage Used |
#      | <%=@client.machine_alias%> | <%=@new_users.first.email%> | (default user group) | <%=QA_ENV['data_center']%> | 1 GB         |
#    And I view machine details for @client.machine_alias
#    Then machine details should be:
#      | Owner:      | Space Used: | Last Update: | Encryption: | Client Version: | Product Key:                 | Data Center:               |
#      | @user_email | 1 GB        | N/A          | Not Set     | unknown         | @client.license_key (Server) | <%=QA_ENV['data_center']%> |
#    And Backups section without backup history will show Backup history unavailable.
#    And Restores section without finished restores will show This machine does not have any finished restores.
#    When I log out bus admin console
#    And I navigate to bus admin console login page
#    And I log in bus admin console as administrator
#    When I search machine by:
#      | machine_name               |
#      | <%=@client.machine_alias%> |
#    Then Machine search results should be:
#      | Machine                    | User                        | User Group           | Data Center                | Storage Used |
#      | <%=@client.machine_alias%> | <%=@new_users.first.email%> | (default user group) | <%=QA_ENV['data_center']%> | 1 GB         |
#    And I view machine details for @client.machine_alias
#    Then machine details should be:
#      | ID:                     | External ID: | MTM/SN: | Retry PEW:  | Status:             | Suspended:              | Owner:      | Space Used: | Last Update: | Encryption: | Client Version: | Product Key:                 | Hash:                     | Data Center:               |
#      | <%=@client.machine_id%> | (change)     | (edit)  | No (toggle) | No expiration (add) | Not Suspended (suspend) | @user_email | 1 GB        | N/A          | Not Set     | unknown         | @client.license_key (Server) | <%=@client.machine_hash%> | <%=QA_ENV['data_center']%> |
#    And Backups table will display with text No results found.
#    And Restores section without finished restores will show This machine does not have any finished restores.
#    And I search and delete partner account by newly created partner company name

