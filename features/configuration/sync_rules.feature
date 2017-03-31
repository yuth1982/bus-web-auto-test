Feature: sync rules

  Background:
    Given I log in bus admin console as administrator

  @TC.131019 @bus @admin @ldap_sequence @regression @qa12
  Scenario: 131019 Newly synced user in no oem partner should receive welcome email
    Given I delete a user tc131019.user1 in the AD
    Given I delete a user tc131019.user2 in the AD
    # step1 - add two users in AD server
    When I add a user to the AD
      | user name      |
      | tc131019.user1 |
    And I add a user to the AD
      | user name      |
      | tc131019.user2 |
    # step2 - create a MozyEnterprise partner
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 24     | 18    | 500 GB      | FedID role |
    Then New partner should be created
    # step3 - partner setting
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I view the newly created partner admin details
    Then I active admin in admin details default password
    And I log out bus admin console
    # step4 - relog in as new user
    When I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    # step5 - Authentication Ploicy/Connection Settings
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  | Bind Username | Bind Password  |
      | @server_host | @protocol |          | @port | @base_dn | @bind_user    | @bind_password |
    And I check enable sso for admins to log in with their network credentials
    # step6 - Sync Rules setting
    And I click Sync Rules tab
    And I uncheck enable synchronization safeguards in Sync Rules tab
    And I add 2 new provision rules:
      | rule                                   | group                |
      | cn=tc131019.user1                      | (default user group) |
      | mail=@AD_User_Emails["tc131019.user2"] | (default user group) |
    And I check Send Welcome email to new users checkbox
    And I save the changes with password default password
    Then Authentication Policy has been updated successfully
    #click Sync Rule tab again.
    And I click Sync Rules tab
    And I click the sync now button
    And I wait for 60 seconds
    Then I monitor the sync result and restart bds-boot service if sync failed
    # step 7 - check the users are provisioned successfully
    #And I wait for 90 seconds
    And I search emails by keywords:
      | to                                | subject                               |
      | @AD_User_Emails["tc131019.user1"] | New Account Created on MozyEnterprise |
    Then I should see 1 email(s)
    And I search emails by keywords:
      | to                                | subject                               |
      | @AD_User_Emails["tc131019.user2"] | New Account Created on MozyEnterprise |
    Then I should see 1 email(s)
    And I delete a user tc131019.user1 in the AD
    And I delete a user tc131019.user2 in the AD
