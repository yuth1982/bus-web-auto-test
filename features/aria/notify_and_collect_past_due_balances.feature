Feature: Notify about and collect past-due balances

  As a Mozy sales or finance representative
  I want to provide ample notification when a customer is past-due
  so that customers have as much opportunity as possible to make their account current before Mozy disables and eventually removes their service.

  Background:
    Given I log in bus admin console as administrator

  @TC.16107 @firefox
  Scenario: 16107 MozyPro account deleted in bus but history will remain in aria
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I search and delete newly created partner company name account
    And I log in aria admin console as administrator
    Then newly created partner admin email account status should be CANCELLED

  @TC.16108 @slow @firefox
  Scenario: 16108 MozyPro account without server plan suspended in aria should be backup-suspended in bus
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner company name account status to Suspended
    Then Account status should be changed
    When I wait for 60 seconds
    And I log in bus admin console as administrator
    And I act as the partner by newly created partner admin email on admin details panel
    And I navigate to Change Payment Information section from bus admin console page
    Then Change payment information message should be Your account is backup-suspended. You will not be able to access your account until your credit card is billed.

  @TC.17877 @slow @firefox
  Scenario: 17877 MozyPro account with server plan suspended in aria should be backup-suspended in bus
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner company name account status to Suspended
    Then Account status should be changed
    When I wait for 60 seconds
    And I log in bus admin console as administrator
    And I act as the partner by the new partner email on admin details panel
    And I navigate to Change Payment Information section from bus admin console page
    Then Change payment information message should be Your account is backup-suspended. You will not be able to access your account until your credit card is billed.

  @TC.16147 @slow @firefox
  Scenario: 16147 Verify aria sends email when change MozyEnterprise account status to Active Dunning 1
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner company name account status to Active Dunning 1
    Then Account status should be changed
    Then I should see 1 email(s) when I search keywords:
      | from                    | date    | subject                                          | content                  |
      | AccountManager@mozy.com | @today  | [Mozy] Your credit card payment was unsuccessful | (Visa) ************@XXXX |

  @TC.16148 @slow @firefox
  Scenario: 16148 Verify aria sends email when change Reseller account status to Active Dunning 2
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 100            |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner company name account status to Active Dunning 2
    Then Account status should be changed
    And I should see 1 email(s) when I search keywords:
      | from                    | date    | subject               | content                  |
      | AccountManager@mozy.com | @today  | [Mozy] SECOND NOTICE  | (Visa) ************@XXXX |

  @TC.16149 @slow @firefox
  Scenario: 16149 Verify aria sends email when change MozyPro account status to Active Dunning 3
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner company name account status to Active Dunning 3
    Then Account status should be changed
    And I should see 1 email(s) when I search keywords:
      | from                    | date    | subject                                          | content         |
      | AccountManager@mozy.com | @today  | [Mozy] Your account will be suspended in 7 days  | Hi, @first_name |

  @TC.16243 @slow @firefox
  Scenario: 16243 Verify aria sends email when MozyPro account status sets to suspended
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner company name account status to Suspended
    Then Account status should be changed
    And I should see 1 email(s) when I search keywords:
      | from        | date    | subject                                    | content           |
      | ar@mozy.com | @today  | There was a problem with your Mozy payment | Dear @first_name, |

  @TC.16165 @slow @firefox
  Scenario: 16165 Verify aria sends email when change MozyPro account status to Active Dunning 1 net terms
    When I add a new MozyPro partner:
    | period | base plan | net terms |
    | 1      | 50 GB     | yes       |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner company name account status to Active Dunning 1
    Then Account status should be changed
    And I should see 1 email(s) when I search keywords:
      | from                    | date    | subject                                | content               |
      | AccountManager@mozy.com | @today  | [Mozy] Mozy invoice, due upon receipt  | Hi, @admin_first_name |

  @TC.16166 @slow @firefox
  Scenario: 16166 Verify aria sends email when change MozyEnterprise account status to Active Dunning 2 net terms
    When I add a new MozyEnterprise partner:
      | period | users     | net terms |
      | 12     | 1        | yes       |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner company name account status to Active Dunning 2
    Then Account status should be changed
    And I should see 1 email(s) when I search keywords:
      | from                    | date    | subject                                  | content               |
      | AccountManager@mozy.com | @today  | [Mozy] Mozy subscription invoice overdue | Hi, @admin_first_name |

  # need update subject information
  @TC.16244 @slow @firefox
  Scenario: 16244 Verify aria sends email when change Reseller account status to Active Dunning 3 net terms
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 1      | Silver        | 100            | yes       |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner company name account status to Active Dunning 3
    Then Account status should be changed
    And I should see 1 email(s) when I search keywords:
      | from                    | date    | subject                                                       | content               |
      | AccountManager@mozy.com | @today  | [Mozy] Your account is suspended all users unable to back up  | Hi, @admin_first_name |

  @TC.17978 @slow @firefox
  Scenario: 17978 Verify aria sends email when MozyPro account status sets to suspended net terms
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 50 GB     | yes       |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner company name account status to Suspended
    Then Account status should be changed
    And I should see 1 email(s) when I search keywords:
      | from        | date    | subject                    | content                |
      | ar@mozy.com | @today  | Account Suspension Notice  | Dear @admin_first_name |


  #@TC.16114
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

  @TC.16151 @firefox
  Scenario: 16151 Verify account reinstate from active dunning 1 state if charge goes through
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner company name account CAG to Fail Test CAG
    Then Collections account groups should be changed
    When I log in bus admin console as administrator
    And I act as the partner by newly created partner admin email on admin details panel
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then Account plan should be changed
    When I log in aria admin console as administrator
    And I change newly created partner company name account status to Active Dunning 1
    Then Account status should be changed
    And I change newly created partner company name account CAG to CyberSource Credit Card
    Then Collections account groups should be changed
    When I log in bus admin console as administrator
    And I act as the partner by newly created partner admin email on admin details panel
    And I update newly created partner company name account credit card information
    Then Credit card information should be updated
    When I log in aria admin console as administrator
    Then newly created partner company name account status should be ACTIVE

  @TC.16152 @firefox
  Scenario: 16152 Verify account reinstate from active dunning 2 state if charge goes through
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner company name account CAG to Fail Test CAG
    Then Collections account groups should be changed
    When I log in bus admin console as administrator
    And I act as the partner by newly created partner admin email on admin details panel
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then Account plan should be changed
    When I log in aria admin console as administrator
    And I change newly created partner company name account status to Active Dunning 2
    Then Account status should be changed
    And I change newly created partner company name account CAG to CyberSource Credit Card
    Then Collections account groups should be changed
    When I log in bus admin console as administrator
    And I act as the partner by newly created partner admin email on admin details panel
    And I update newly created partner company name account credit card information
    Then Credit card information should be updated
    When I log in aria admin console as administrator
    Then newly created partner company name account status should be ACTIVE

  @TC.16153 @firefox
  Scenario: 16153 Verify account reinstate from active dunning 3 state if charge goes through
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I log in aria admin console as administrator
    And I change newly created partner company name account CAG to Fail Test CAG
    Then Collections account groups should be changed
    When I log in bus admin console as administrator
    And I act as the partner by newly created partner admin email on admin details panel
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then Account plan should be changed
    When I log in aria admin console as administrator
    And I change newly created partner company name account status to Active Dunning 3
    Then Account status should be changed
    And I change newly created partner company name account CAG to CyberSource Credit Card
    Then Collections account groups should be changed
    When I log in bus admin console as administrator
    And I act as the partner by the new partner email on admin details panel
    And I update newly created partner company name account credit card information
    Then Credit card information should be updated
    When I log in aria admin console as administrator
    Then newly created partner company name account status should be ACTIVE


