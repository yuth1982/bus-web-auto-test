Feature: Notify about and collect past-due balances

  As a Mozy sales or finance representative
  I want to provide ample notification when a customer is past-due
  so that customers have as much opportunity as possible to make their account current before Mozy disables and eventually removes their service.

  Background:
    Given I log in bus admin console as administrator

  @create_partner_email
  Scenario: Verify aria sends email when create a new MozyPro partner
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created
    When I log in zimbra as default account
    And I search email to match all keywords:
    | to                  | date    | subject                  |
    | New partner's email | Today   | MozyPro Account Created! |
    Then I should see 1 email(s) displayed in search results

  @change-1
  Scenario: Verify aria sends email when change subscription peiod
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created
    When I log in bus admin console as the new partner account
    And I change subscription up to MozyPro annual billing period
    Then Subscription changed message should be Your account has been changed to yearly billing.
    When I log in zimbra as default account
    And I search email to match all keywords:
    | to            | date    | subject                  | content                       |
    | qa1@mozy.com  | Today   | MozyQA Account Statement | New partner's company address |
    Then I should see 2 email(s) displayed in search results

  @TC.16147
  Scenario: Mozy-16147 Verify aria sends email when change MozyPro account status to Active Dunning 1
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I change account status to Active Dunning 1
    Then Status changed successful message should be Account status changed
    When I log in zimbra as default account
    And I search email to match all keywords:
    | from                    | date    | subject                                          | content                                    |
    | AccountManager@mozy.com | Today   | [Mozy] Your credit card payment was unsuccessful | Hi, First_Name AND (Visa) ************XXXX |
    Then I should see 1 email(s) displayed in search results

  @TC.16148
  Scenario: Mozy-16148 Verify aria sends email when change MozyPro account status to Active Dunning 2
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I change account status to Active Dunning 2
    Then Status changed successful message should be Account status changed
    When I log in zimbra as default account
    And I search email to match all keywords:
    | from                    | date    | subject               | content                                    |
    | AccountManager@mozy.com | Today   | [Mozy] SECOND NOTICE  | Hi, First_Name AND (Visa) ************XXXX |
    Then I should see 1 email(s) displayed in search results

  @TC.16149
  Scenario: Mozy-16149 Verify aria sends email when change MozyPro account status to Active Dunning 3
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I change account status to Active Dunning 3
    Then Status changed successful message should be Account status changed
    When I log in zimbra as default account
    And I search email to match all keywords:
    | from                    | date    | subject                                          | content        |
    | AccountManager@mozy.com | Today   | [Mozy] Your account will be suspended in 7 days  | Hi, First_Name |
    Then I should see 1 email(s) displayed in search results

  @TC.16243
  Scenario: Mozy-16243 Verify aria sends email when change MozyPro account status to suspended
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I change account status to Suspended
    Then Status changed successful message should be Account status changed
    When I log in zimbra as default account
    And I search email to match all keywords:
    | from        | date    | subject                                    | content          |
    | ar@mozy.com | Today   | There was a problem with your Mozy payment | Dear First_Name, |
    Then I should see 1 email(s) displayed in search results

  @TC.16108
  Scenario: MozyPro account suspended in aria should be backup-suspended in bus
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created
    When I log in aria admin console as aria admin
    And I search aria account by the new partner email
    And I change account status to Suspended
    Then Status changed successful message should be Account status changed
    When I wait for 10 seconds
    And I log in bus admin console as the new partner account
    Then Message displayed on change payment information view should be Your account is backup-suspended. You will not be able to access your account until your credit card is billed.
