Feature: Corporate Invoices

  As a Mozy Enterprise customer
  I want to construct my billing terms in a way that fits my needs and usage
  so that I can pay the way that makes sense to me (ex. bundles packages, minimums, per-user licensing, etc).

  Background:
    Given I log in bus admin console as administrator

  @TC.15679
  Scenario: Mozy-15679 Verify "Corporate Invoices" link in mozy admin console should be removed
    Then Corporate Invoices link should not exist in Internal Tools menu

  @TC.15686 @slow
  Scenario: Mozy-15686 Verify Aria sends email when create a new MozyPro partner
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 base plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I wait for 30 seconds
    When I log in zimbra as default account
    And I search email to match all keywords:
    | to                  | date    | subject                  |
    | New partner's email | Today   | MozyPro Account Created! |
    Then I should see 1 email(s) displayed in search results

  @TC.15687 @slow
  Scenario: Mozy-15687 Verify Aria sends invoice email when change subscription period of a MozyPro partner
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 base plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Billing Information view from bus admin console page
    And I change subscription up to MozyPro annual billing period
    Then Subscription changed message should be Your account has been changed to yearly billing.
    When I wait for 30 seconds
    And I log in zimbra as default account
    And I search email to match all keywords:
    | to            | date    | subject                  | content                       |
    | qa1@mozy.com  | Today   | MozyQA Account Statement | New partner's company address |
    Then I should see 2 email(s) displayed in search results

  @TC.17841 @slow
  Scenario: Mozy-15686 Verify Aria sends email when create a new MozyEnterprise partner
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I wait for 30 seconds
    And I log in zimbra as default account
    And I search email to match all keywords:
    | to                  | date    | subject                  |
    | New partner's email | Today   | MozyEnterprise Account Created! |
    Then I should see 1 email(s) displayed in search results

  @TC.17842 @slow
  Scenario: Mozy-17842 Verify Aria sends invoice email when change subscription period of a MozyEnterprise partner
    When I add a MozyEnterprise partner with 12 month(s) period, 1 user(s), no server plan, 0 server add-on, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I navigate to Billing Information view from bus admin console page
    And I change subscription up to MozyEnterprise biennial billing period
    Then Subscription changed message should be Your account has been changed to biennial billing.
    When I wait for 30 seconds
    And I log in zimbra as default account
    And I search email to match all keywords:
    | to            | date    | subject                  | content                       |
    | qa1@mozy.com  | Today   | MozyQA Account Statement | New partner's company address |
    Then I should see 2 email(s) displayed in search results