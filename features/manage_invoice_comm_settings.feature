Feature:
  As a Mozy Administrator
  I want to configure whether or not I want to receive account statements by email
  so that I'm not bothered by extra email

  Background:
    Given I log in bus admin console as administrator

  @TC.15228
  Scenario: Mozy-15228 Verify UI of invoice settings in BUS
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 base plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Account Details view from bus admin console page
    Then Invoice setting details should be Receive Mozy Pro Newsletter?,Receive Mozy Email Notifications?,Receive Mozy Account Statements?

  @TC.15229
  Scenario: Mozy-15229 Verify Receive Mozy Account Statements set to Yes for new partner in Bus
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 base plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Account Details view from bus admin console page
    Then I should see Receive Mozy Pro Newsletter option is set to No
    And I should see Receive Mozy Email Notifications option is set to No
    And I should see Receive Mozy Account Statements option is set to Yes

  @TC.15230
  Scenario: Mozy-15230 Alter notification method between HTML email and Printable no email in Aria
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 base plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I navigate to notification method view
    And I set notification method to Printable (no Email)
    Then Notification message should be Change Saved! This account is currently notified via method "Printable (no Email)".
    When I set notification method to HTML Email
    Then Notification message should be Change Saved! This account is currently notified via method "HTML Email".

  @TC.15448
  Scenario: Mozy-15448 Verify notification methods have HTML email and Printable no email
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 base plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I navigate to notification method view
    Then Notification methods should be HTML Email,Printable (no Email)

  @TC.15495
  Scenario: Mozy-15495 Verify aria notification method when set Receive Mozy Account Statements to No
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 base plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Account Details view from bus admin console page
    And I set Receive Mozy Account Statements option to No
    Then I should see setting saved message is Successfully saved Account Statement preference.
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I navigate to notification method view
    Then Notification message should be This account is currently notified via method "Printable (no Email)".

  @TC.15718
  Scenario: Mozy-15718 Verify notification method set to HTML Email for new Monthly MozyPro partner
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 base plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I navigate to notification method view
    Then Notification message should be This account is currently notified via method "HTML Email".

  @TC.17590
  Scenario: Mozy-17590 Verify notification method set to HTML Email for new Monthly MozyEnterprise partner
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I navigate to notification method view
    Then Notification message should be This account is currently notified via method "HTML Email".

  @TC.17591
  Scenario: Mozy-17591 Verify notification method set to HTML Email for new Monthly Reseller partner
    When I add a Reseller partner with 1 month(s) period, Silver Reseller, 100 GB base plan, no server plan, 0 add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I navigate to notification method view
    Then Notification message should be This account is currently notified via method "HTML Email".







