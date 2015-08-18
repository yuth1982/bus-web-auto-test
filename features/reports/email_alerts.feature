Feature: Email Alerts
  pre-condition
  update environment:
  MAILBOX = ENV['BUS_MAILBOX'] || ''

  Background:
    Given I log in bus admin console as administrator

  @TC.1980 @bus @email_alerts
  Scenario: 1980:Create New Daily Alert
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 12     |  Silver       | 100            | yes       |
    Then New partner should be created
    Then I act as newly created partner account
    Then I navigate to Email Alerts section from bus admin console page
    Then I add a new email alert:
      | subject line       | frequency | report modules                             | recipients                         |
      | email_alerts_test  | daily     | Backup summary;Users without recent backups| <%=@partner.admin_info.full_name%> |
    Then email alerts section message should be New alert created
    Then I view email alert details by email_alerts_test
    And The email alert details should be:
      | subject line       | frequency | report modules                               | recipients                         |
      | email_alerts_test  | daily     | Backup summary;Users without recent backups  | <%=@partner.admin_info.full_name%> |
    Then I Send Now the email alert
    Then I wait for 5 seconds
    And I search emails by keywords:
      | to               | content           |
      | @new_admin_email | email_alerts_test |
    Then I should see 1 email(s)
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.1983 @bus @email_alerts
  Scenario: 1983:Modify Existing Email Alert
    When I add a new MozyPro partner:
      | period | base plan | coupon              | country       |
      | 1      | 10 GB     | 10PERCENTOFFOUTLINE | United States |
    Then New partner should be created
    Then I change root role to FedID role
    Then I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    Then I add a new admin:
      | Name        | Roles      | User Group           |
      | alert_admin | FedID role | (default user group) |
    Then I navigate to Email Alerts section from bus admin console page
    Then I add a new email alert:
      | subject line       | frequency | report modules                              | recipients                         |
      | email_alerts_test  | daily     | Backup summary;Users without recent backups | <%=@partner.admin_info.full_name%> |
    Then email alerts section message should be New alert created
    Then I view email alert details by email_alerts_test
    Then I modify email alert to:
      | subject line        | frequency | report modules                                  | scope                |recipients |
      | email_alerts_modify | weekly    | Users/Machines nearing max;Storage pool summary | (default user group) |alert_admin |
    Then I view email alert details by email_alerts_modify
    And The email alert details should be:
      | subject line         | frequency | report modules                                  | recipients  |
      | email_alerts_modify  | weekly    | Users/Machines nearing max;Storage pool summary | alert_admin |
    Then I Send Now the email alert
    And I search emails by keywords:
      | to                | content             |
      | <%=@admin.email%> | email_alerts_modify |
    Then I should see 1 email(s)
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name
