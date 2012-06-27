Feature:
  As a Mozy Administrator
  I want to configure whether or not I want to receive account statements by email
  so that I'm not bothered by extra email

  @15448
  Scenario: BILL.11000 List HTML email and Printable (no email) notification methods in Aria
    Given I log in aria admin console as aria admin
    When I search aria account by qa1+Isaac+Paucek@mozy.com
    And I navigate to notification method view
    Then Notification methods should be HTML Email,Printable (no Email)

  @BILL.11000
  Scenario: BILL.11001 Alter notification method between HTML email and Printable (no email) in Aria
    Given I log in bus admin console as administrator
    And I have a new business partner with yearly subscription
    And I add the new partner
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email *
    And I navigate to notification method view *
    And I set notification method to Printable (no Email)
    Then Notification message should be Change Saved! This account is currently notified via method "Printable (no Email)".
    When I set notification method to HTML Email
    Then Notification message should be Change Saved! This account is currently notified via method "HTML Email".

  @BILL.11500
  Scenario: Verify UI of invoice setting in BUS
    Given I log in bus admin console as administrator
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 plan, no server plan
    Then Partner creation successful message should be New partner created
    When I masquerade as the new partner
    And I navigate to account details view
    Then I should see Receive Mozy Pro Newsletter? invoice setting
    And I should see Receive Mozy Email Notifications? invoice setting
    And I should see Receive Mozy Account Statements? invoice setting

  @BILL.11501
  Scenario: Verify aria notification method when set 'Receive Mozy Account Statements' to No
    Given I log in bus admin console as administrator
    And I have a new business partner with yearly subscription
    And I add the new partner
    When I masquerade as the new partner
    And I navigate to account details view
    And I set Receive Mozy Account Statements option to No
    Then I should see setting saved message is Successfully saved Account Statement preference.
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email *
    And I navigate to notification method view *
    Then Notification message should be This account is currently notified via method "Printable (no Email)".

  @BILL.11503-1
  Scenario: Verify 'Receive Mozy Account Statements' set to Yes for new partner in Bus
    Given I log in bus admin console as administrator
    And I have a new business partner with yearly subscription
    And I add the new partner
    When I masquerade as the new partner
    And I navigate to account details view
    Then I should see Receive Mozy Pro Newsletter option is set to No
    And I should see Receive Mozy Email Notifications option is set to No
    And I should see Receive Mozy Account Statements option is set to Yes

  @BILL.11503-2
  Scenario: Verify notification method set to "HTML Email" for new partner in Aria
    Given I log in bus admin console as administrator
    And I have a new business partner with yearly subscription
    And I add the new partner
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email *
    And I navigate to notification method view *
    Then Notification message should be This account is currently notified via method "HTML Email".






