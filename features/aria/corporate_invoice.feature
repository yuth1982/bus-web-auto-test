Feature: Corporate Invoices

  As a Mozy Enterprise customer
  I want to construct my billing terms in a way that fits my needs and usage
  so that I can pay the way that makes sense to me (ex. bundles packages, minimums, per-user licensing, etc).

  Background:
    Given I log in bus admin console as administrator

  @TC.15686 @bus @2.0 @corporate_invoices @email @regression
  Scenario: 15686 Verify Aria sends email when create a new MozyPro partner
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I search emails by keywords:
      | to               | subject                  |
      | @new_admin_email | MozyPro Account Created! |
    Then I should see 1 email(s)
    When I search emails by keywords:
      | from        | subject                    | content          |
      | ar@mozy.com | Mozy Inc Account Statement | @company_address |
    Then I should see 1 email(s)

  @TC.15687 @bus @2.0 @corporate_invoices @email @regression
  Scenario: 15687 Verify Aria sends invoice email when change subscription period of a MozyPro partner
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to annual billing period!
    Then Subscription changed message should be Your account has been changed to yearly billing.
    #QA12's billing email will delay many minutes
    And I wait for 1200 seconds
    When I search emails by keywords:
      | from        | subject                    | content          |
      | ar@mozy.com | Mozy Inc Account Statement | @company_address |
    Then I should see 2 email(s)

  @TC.17841 @bus @2.0 @corporate_invoices @email @regression
  Scenario: 17841 Verify Aria sends email when create a new MozyEnterprise partner
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I search emails by keywords:
      | to               | subject                         |
      | @new_admin_email | MozyEnterprise Account Created! |
    Then I should see 1 email(s)
    When I search emails by keywords:
      | from        | subject                    | content          |
      | ar@mozy.com | Mozy Inc Account Statement | @company_address |
    Then I should see 1 email(s)

  @TC.17842 @slow @javascript @bus @2.0 @corporate_invoices @email @regression
  Scenario: 17842 Verify Aria sends invoice email when change subscription period of a MozyEnterprise partner
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to biennial billing period!
    Then Subscription changed message should be Your account has been changed to biennial billing.
    #QA12's billing email will delay many minutes
    And I wait for 1200 seconds
    When I search emails by keywords:
      | from        | subject                    | content          |
      | ar@mozy.com | Mozy Inc Account Statement | @company_address |
    Then I should see 2 email(s)
