Feature: Notify about and collect past-due balances

  As a Mozy sales or finance representative
  I want to provide ample notification when a customer is past-due
  so that customers have as much opportunity as possible to make their account current before Mozy disables and eventually removes their service.

  Background:
    Given I log in bus admin console as administrator

  @TC.16107
  Scenario: Mozy-16107 MozyPro account deleted in bus but history will remain in aria
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 base plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I delete the partner by the new partner company name
    And I log in aria admin console as aria admin
    And I search aria account by the new partner email
    Then Account status should be Cancelled

  @TC.16108 @slow
  Scenario: Mozy-16108 MozyPro account without server plan suspended in aria should be backup-suspended in bus
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 base plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I change account status to Suspended
    Then Status changed successful message should be Account status changed
    When I wait for 60 seconds
    And I log in bus admin console as the new partner account
    And I navigate to Change Payment Information view from bus admin console page
    Then Message displayed on change payment information view should match Your account is backup-suspended. You will not be able to access your account until your credit card is billed.

  @TC.17877 @slow
  Scenario: Mozy-17877 MozyPro account with server plan suspended in aria should be backup-suspended in bus
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 base plan, has server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I change account status to Suspended
    Then Status changed successful message should be Account status changed
    When I wait for 60 seconds
    And I log in bus admin console as the new partner account
    And I navigate to Change Payment Information view from bus admin console page
    Then Message displayed on change payment information view should match Your account is backup-suspended. You will not be able to access your account until your credit card is billed.

  @TC.16147 @slow
  Scenario: Mozy-16147 Verify aria sends email when change MozyPro account status to Active Dunning 1
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 base plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I change account status to Active Dunning 1
    Then Status changed successful message should be Account status changed
    When I wait for 30 seconds
    When I log in zimbra as default account
    And I search email to match all keywords:
    | from                    | date    | subject                                          | content                                      |
    | AccountManager@mozy.com | @today  | [Mozy] Your credit card payment was unsuccessful | Hi, @first_name AND (Visa) ************@XXXX |
    Then I should see 1 email(s) displayed in search results

  @TC.16148 @slow
  Scenario: Mozy-16148 Verify aria sends email when change MozyPro account status to Active Dunning 2
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 base plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I change account status to Active Dunning 2
    Then Status changed successful message should be Account status changed
    When I wait for 30 seconds
    When I log in zimbra as default account
    And I search email to match all keywords:
    | from                    | date    | subject               | content                                      |
    | AccountManager@mozy.com | @today  | [Mozy] SECOND NOTICE  | Hi, @first_name AND (Visa) ************@XXXX |
    Then I should see 1 email(s) displayed in search results

  @TC.16149 @slow
  Scenario: Mozy-16149 Verify aria sends email when change MozyPro account status to Active Dunning 3
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 base plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I change account status to Active Dunning 3
    Then Status changed successful message should be Account status changed
    When I wait for 30 seconds
    When I log in zimbra as default account
    And I search email to match all keywords:
    | from                    | date    | subject                                          | content         |
    | AccountManager@mozy.com | @today  | [Mozy] Your account will be suspended in 7 days  | Hi, @first_name |
    Then I should see 1 email(s) displayed in search results

  @TC.16243 @slow
  Scenario: Mozy-16243 Verify aria sends email when MozyPro account status sets to suspended
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 base plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I change account status to Suspended
    Then Status changed successful message should be Account status changed
    When I wait for 60 seconds
    And I log in zimbra as default account
    And I search email to match all keywords:
    | from        | date    | subject                                    | content           |
    | ar@mozy.com | @today  | There was a problem with your Mozy payment | Dear @first_name, |
    Then I should see 1 email(s) displayed in search results

  @TC.16114
  Scenario: Verify update credit card in bus and a charge will be attempted for the entire balance
    When I add a MozyPro partner with 1 month(s) period, 250 GB, $94.99 base plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I change collections account group to Fail Test CAG
    Then Change account group message should be Account group changes saved.
    When I log in bus admin console as the new partner account
    And I navigate to Billing Information view from bus admin console page
    And I change subscription up to MozyPro annual billing period
    Then Subscription changed message should be Your account has been changed to yearly billing.
    When I visit aria admin console page
    And I search aria account by the new partner email
    When I change collections account group to CyberSource Credit Card
    Then Change account group message should be Account group changes saved.
    #When I log in bus admin console as the new partner account
    #And I navigate to Change Payment Information view from bus admin console page
    #And I update partner credit card information with new test info
    #Then Message displayed on change payment information view should match Your billing information has been successfully updated.

  #@TC.16151
  #Scenario: Mozy-16151 Verify account reinstate from active dunning 1 state if charge goes through
   # When I add a MozyPro partner with 1 month(s) period, 250 GB, $94.99 base plan, no server plan, no coupon, credit card payment
   # Then Partner created successful message should be New partner created.
   # When I log in aria admin console as aria admin
   # And I search aria account by the new partner email
   # And I change collections account group to Fail Test CAG
   # Then Change account group message should be Account group changes saved.
   # When I log in bus admin console as the new partner account
   # And I navigate to Billing Information view from bus admin console page
   # And I change subscription up to MozyPro annual billing period
   # Then Subscription changed message should be Your account has been changed to yearly billing.
#    When I visit aria admin console page
#    And I search aria account by the new partner email
#    And I change account status to Active Dunning 1
#    Then Status changed successful message should be Account status changed
#    When I change collections account group to CyberSource Credit Card
#    Then Change account group message should be Account group changes saved.
#    When I log in bus admin console as the new partner account
#    And I navigate to Change Payment Information view from bus admin console page
#    And I update partner credit card information with new test info
#    Then Message displayed on change payment information view should match Your billing information has been successfully updated.
#    When I visit aria admin console page
#    And I search aria account by the new partner email
#    Then Account status should be Active
#
#  Scenario: Mozy-16152 Verify account reinstate from active dunning 1 state if charge goes through
#    When I add a MozyPro partner with 1 month(s) period, 250 GB, $94.99 base plan, no server plan, no coupon, credit card payment
#    Then Partner created successful message should be New partner created.
#    When I log in aria admin console as aria admin
#    And I search aria account by the new partner email
#    And I change collections account group to Fail Test CAG
#    Then Change account group message should be Account group changes saved.
#    When I log in bus admin console as the new partner account
#    And I navigate to Billing Information view from bus admin console page
#    And I change subscription up to MozyPro annual billing period
#    Then Subscription changed message should be Your account has been changed to yearly billing.
#    When I visit aria admin console page
#    And I search aria account by the new partner email
#    And I change account status to Active Dunning 1
#    And I change collections account group to CyberSource Credit Card
#    Then Change account group message should be Account group changes saved.
#    When I log in bus admin console as the new partner account
#    And I navigate to Change Payment Information view from bus admin console page
#    And I update partner credit card information with new test info
#    Then Message displayed on change payment information view should match Your billing information has been successfully updated.
#    When I visit aria admin console page
#    And I search aria account by the new partner email
#    Then Account status should be Active

