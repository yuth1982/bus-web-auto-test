Feature: Notify about and collect past-due balances

  As a Mozy sales or finance representative
  I want to provide ample notification when a customer is past-due
  so that customers have as much opportunity as possible to make their account current before Mozy disables and eventually removes their service.

  Background:
    Given I log in bus admin console as administrator

  @TC.16107 @firefox @bus @2.0 @notify_about_and_collect_past-due_balances
  Scenario: 16107 MozyPro account deleted in bus but history will remain in aria
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I delete partner account
    And I log in aria admin console as administrator
    Then newly created partner admin email account status should be CANCELLED

  @TC.16108 @slow @firefox @bus @2.0 @notify_about_and_collect_past-due_balances
  Scenario: 16108 MozyPro account without server plan suspended in aria should be backup-suspended in bus
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner admin email account status to Suspended
    Then Account status should be changed
    When I wait for 60 seconds
    And I log in bus admin console as administrator
    And I act as partner by:
      | email        |
      | @admin_email |
    And I navigate to Change Payment Information section from bus admin console page
    Then Change payment information message should be Your account is backup-suspended. You will not be able to access your account until your credit card is billed.

  @TC.17877 @slow @firefox @bus @2.0 @notify_about_and_collect_past-due_balances
  Scenario: 17877 MozyPro account with server plan suspended in aria should be backup-suspended in bus
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 1      | 50 GB     | yes         |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner admin email account status to Suspended
    Then Account status should be changed
    When I wait for 60 seconds
    And I log in bus admin console as administrator
    And I act as partner by:
      | email        |
      | @admin_email |
    And I navigate to Change Payment Information section from bus admin console page
    Then Change payment information message should be Your account is backup-suspended. You will not be able to access your account until your credit card is billed.

  @TC.16147 @bus @2.0 @notify_about_and_collect_past-due_balances @credit_card_customers
  Scenario: 16147 Verify aria sends email when change MozyEnterprise account status to Active Dunning 1
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner admin email account status to Active Dunning 1
    Then Account status should be changed
    When I search emails by keywords:
      | from                    | subject                               | date  | content                             |
      | AccountManager@mozy.com | [Mozy] Mozy invoice, due upon receipt | today |<%=@partner.credit_card.first_name%> |
    Then I should see 1 email(s)

  @TC.16148 @slow @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @credit_card_customers
  Scenario: 16148 Verify aria sends email when change Reseller account status to Active Dunning 2
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 100            |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner admin email account status to Active Dunning 2
    Then Account status should be changed
    When I search emails by keywords:
      | from                    | subject                                  | date  | content                             |
      | AccountManager@mozy.com | [Mozy] Mozy subscription invoice overdue | today |<%=@partner.credit_card.first_name%> |
    Then I should see 1 email(s)

  @TC.16149 @slow @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @credit_card_customers
  Scenario: 16149 Verify aria sends email when change MozyPro account status to Active Dunning 3
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner admin email account status to Active Dunning 3
    Then Account status should be changed
    When I search emails by keywords:
      | from                    | date  | content                              |
      | AccountManager@mozy.com | today | <%=@partner.credit_card.first_name%> |
    Then I should see 1 email(s)

  @TC.16243 @slow @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @credit_card_customers
  Scenario: 16243 Verify aria sends email when MozyPro account status sets to suspended
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner admin email account status to Suspended
    Then Account status should be changed
    When I search emails by keywords:
      | from        | subject                   | date  | content                             |
      | ar@mozy.com | Account Suspension Notice | today |<%=@partner.credit_card.first_name%> |
    Then I should see 1 email(s)

  @TC.16165 @slow @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @net_terms_customers
  Scenario: 16165 Verify aria sends email when change MozyPro account status to Active Dunning 1 net terms
    When I add a new MozyPro partner:
    | period | base plan | net terms |
    | 1      | 50 GB     | yes       |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner admin email account status to Active Dunning 1
    Then Account status should be changed
    When I search emails by keywords:
      | from                    | subject                               | date  | content                             |
      | AccountManager@mozy.com | [Mozy] Mozy invoice, due upon receipt | today | <%=@partner.admin_info.first_name%> |
    Then I should see 1 email(s)

  @TC.16166 @slow @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @net_terms_customers
  Scenario: 16166 Verify aria sends email when change MozyEnterprise account status to Active Dunning 2 net terms
    When I add a new MozyEnterprise partner:
      | period | users     | net terms |
      | 12     | 1        | yes       |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner admin email account status to Active Dunning 2
    Then Account status should be changed
    When I search emails by keywords:
      | from                    | subject                                  | date  | content                             |
      | AccountManager@mozy.com | [Mozy] Mozy subscription invoice overdue | today | <%=@partner.admin_info.first_name%> |
    Then I should see 1 email(s)

  # need update subject information
  @TC.16244 @slow @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @net_terms_customers
  Scenario: 16244 Verify aria sends email when change Reseller account status to Active Dunning 3 net terms
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 1      | Silver        | 100            | yes       |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner admin email account status to Active Dunning 3
    Then Account status should be changed
    When I search emails by keywords:
      | from                    | date  | content                             |
      | AccountManager@mozy.com | today | <%=@partner.admin_info.first_name%> |
    Then I should see 1 email(s)

  @TC.17978 @slow @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @net_terms_customers
  Scenario: 17978 Verify aria sends email when MozyPro account status sets to suspended net terms
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 50 GB     | yes       |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner admin email account status to Suspended
    Then Account status should be changed
    When I search emails by keywords:
      | from        | subject                   | date  | content                              |
      | ar@mozy.com | Account Suspension Notice | today | <%=@partner.admin_info.full_name%> |
    Then I should see 1 email(s)

  #@TC.16114 @bus @2.0 @notify_about_and_collect_past-due_balances @credit_card_customers
  #Scenario: Verify update credit card in bus and a charge will be attempted for the entire balance
#    When I add a new MozyPro partner:
#    | period | base plan     |
#    | 1      | 50 GB, $19.99 |
#    Then New partner should be created
#    When I log in aria admin console as administrator
#    And I change the new partner account CAG to Fail Test CAG
#    Then CAG message should be Account group changes saved.
#    When I act as newly created partner account
#    And I change account subscription up to MozyPro annual billing period
#    Then Subscription changed message should be Your account has been changed to yearly billing.
#    When I visit aria admin console page
#    When I change the new partner account CAG to CyberSource Credit Card
#    Then CAG message should be Account group changes saved.
    #When I act as newly created partner account
    #And I navigate to Change Payment Information section from bus admin console page
    #And I update partner credit card information with new test info
    #Then Message displayed on change payment information view should match Your billing information has been successfully updated.

  @TC.16151 @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @credit_card_customers
  Scenario: 16151 Verify account reinstate from active dunning 1 state if charge goes through
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner admin email account CAG to Fail Test CAG
    Then Collections account groups should be changed
    When I log in bus admin console as administrator
    And I act as partner by:
      | email        |
      | @admin_email |
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then the MozyPro account plan should be changed
    When I log in aria admin console as administrator
    And I change newly created partner admin email account status to Active Dunning 1
    Then Account status should be changed
    And I change newly created partner admin email account CAG to CyberSource Credit Card
    Then Collections account groups should be changed
    When I log in bus admin console as administrator
    And I act as partner by:
      | email        |
      | @admin_email |
    And I navigate to Change Payment Information section from bus admin console page
    And I update credit card information to:
      | cc name       | cc number        | expire month | expire year | cvv |
      | new card name | 4111111111111111 | 12           | 18          | 123 |
    And I save payment information changes
    Then Payment information should be updated
    When I log in aria admin console as administrator
    Then newly created partner admin email account status should be ACTIVE

  @TC.16152 @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @credit_card_customers
  Scenario: 16152 Verify account reinstate from active dunning 2 state if charge goes through
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner admin email account CAG to Fail Test CAG
    Then Collections account groups should be changed
    When I log in bus admin console as administrator
    And I act as partner by:
      | email        |
      | @admin_email |
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then the MozyPro account plan should be changed
    When I log in aria admin console as administrator
    And I change newly created partner admin email account status to Active Dunning 2
    Then Account status should be changed
    And I change newly created partner admin email account CAG to CyberSource Credit Card
    Then Collections account groups should be changed
    When I log in bus admin console as administrator
    And I act as partner by:
      | email        |
      | @admin_email |
    And I navigate to Change Payment Information section from bus admin console page
    And I update credit card information to:
      | cc name       | cc number        | expire month | expire year | cvv |
      | new card name | 4111111111111111 | 12           | 18          | 123 |
    And I save payment information changes
    Then Payment information should be updated
    When I log in aria admin console as administrator
    Then newly created partner admin email account status should be ACTIVE

  @TC.16153 @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @credit_card_customers
  Scenario: 16153 Verify account reinstate from active dunning 3 state if charge goes through
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner admin email account CAG to Fail Test CAG
    Then Collections account groups should be changed
    When I log in bus admin console as administrator
    And I act as partner by:
      | email        |
      | @admin_email |
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then the MozyPro account plan should be changed
    When I log in aria admin console as administrator
    And I change newly created partner admin email account status to Active Dunning 3
    Then Account status should be changed
    And I change newly created partner admin email account CAG to CyberSource Credit Card
    Then Collections account groups should be changed
    When I log in bus admin console as administrator
    And I act as partner by:
      | email        |
      | @admin_email |
    And I navigate to Change Payment Information section from bus admin console page
    And I update credit card information to:
      | cc name       | cc number        | expire month | expire year | cvv |
      | new card name | 4111111111111111 | 12           | 18          | 123 |
    And I save payment information changes
    Then Payment information should be updated
    When I log in aria admin console as administrator
    Then newly created partner admin email account status should be ACTIVE