Feature:
  As a Mozy Administrator
  I want to configure whether or not I want to receive account statements by email
  so that I'm not bothered by extra email

  Background:
    Given I log in bus admin console as administrator

  @TC.15229
  Scenario: 15229 Verify Receive Mozy Account Statements set to Yes for new partner in Bus
    When I add a new MozyPro partner:
    | period | base plan     |
    | 1      | 50 GB, $19.99 |
    Then New partner should created
    When I log in bus admin console as the new partner account
    And I navigate to Account Details section from bus admin console page
    Then Account details table should be:
    | description                       | value             |
    | Name:                             | @name (change)    |
    | Username/Email:                   | @email (change)   |
    | Password:                         | (hidden) (change) |
    | Receive Mozy Pro Newsletter?      | No (change)       |
    | Receive Mozy Email Notifications? | No (change)       |
    | Receive Mozy Account Statements?  | Yes (change)      |

  @TC.15230
  Scenario: 15230 Alter notification method between HTML email and Printable no email in Aria
    When I add a new MozyPro partner:
    | period | base plan     |
    | 1      | 50 GB, $19.99 |
    Then New partner should created
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I navigate to notification method view
    And I set notification method to Printable (no Email)
    Then Notification message should be Change Saved! This account is currently notified via method "Printable (no Email)".
    When I set notification method to HTML Email
    Then Notification message should be Change Saved! This account is currently notified via method "HTML Email".

  @TC.15448
  Scenario: 15448 Verify notification methods have HTML email and Printable no email
    When I add a new MozyPro partner:
    | period | base plan     |
    | 1      | 50 GB, $19.99 |
    Then New partner should created
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I navigate to notification method view
    Then Notification methods should be:
    | Methods              |
    | HTML Email           |
    | Printable (no Email) |

  @TC.15495
  Scenario: 15495 Verify aria notification method when set Receive Mozy Account Statements to No
    When I add a new MozyPro partner:
    | period | base plan     |
    | 1      | 50 GB, $19.99 |
    Then New partner should created
    When I log in bus admin console as the new partner account
    And I navigate to Account Details section from bus admin console page
    And I set Receive Mozy Account Statements option to No
    Then I should see setting saved message is Successfully saved Account Statement preference.
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I navigate to notification method view
    Then Notification message should be This account is currently notified via method "Printable (no Email)".

  @TC.15718
  Scenario: 15718 Verify notification method set to HTML Email for new Monthly MozyPro partner
    When I add a new MozyPro partner:
    | period | base plan     |
    | 1      | 50 GB, $19.99 |
    Then New partner should created
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I navigate to notification method view
    Then Notification message should be This account is currently notified via method "HTML Email".

  @TC.17590
  Scenario: 17590 Verify notification method set to HTML Email for new Monthly MozyEnterprise partner
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 1     |
    Then New partner should created
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I navigate to notification method view
    Then Notification message should be This account is currently notified via method "HTML Email".

  @TC.17591
  Scenario: 17591 Verify notification method set to HTML Email for new Monthly Reseller partner
    When I add a new Reseller partner:
    | period | reseller type | reseller quota |
    | 1      | Silver        | 100            |
    Then New partner should created
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I navigate to notification method view
    Then Notification message should be This account is currently notified via method "HTML Email".





