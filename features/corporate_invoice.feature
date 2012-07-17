Feature: Corporate Invoices

  As a Mozy Enterprise customer
  I want to construct my billing terms in a way that fits my needs and usage
  so that I can pay the way that makes sense to me (ex. bundles packages, minimums, per-user licensing, etc).

  Background:
    Given I log in bus admin console as administrator

  @TC.15686
  Scenario: Mozy-15686 Verify Aria sends email when create a new MozyPro partner
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I wait for 30 seconds
    When I log in zimbra as default account
    And I search email to match all keywords:
    | to                  | date    | subject                  |
    | New partner's email | Today   | MozyPro Account Created! |
    Then I should see 1 email(s) displayed in search results

  @TC.15687
  Scenario: Mozy-15687 Verify Aria sends invoice email when change subscription period of a MozyPro partner
    When I add a MozyPro partner with 1 month(s) period, 50 GB, $19.99 plan, no server plan, no coupon, credit card payment
    Then Partner created successful message should be New partner created.
    When I log in bus admin console as the new partner account
    And I change subscription up to MozyPro annual billing period
    Then Subscription changed message should be Your account has been changed to yearly billing.
    When I wait for 30 seconds
    When I log in zimbra as default account
    And I search email to match all keywords:
    | to            | date    | subject                  | content                       |
    | qa1@mozy.com  | Today   | MozyQA Account Statement | New partner's company address |
    Then I should see 2 email(s) displayed in search results