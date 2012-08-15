Feature: Corporate Invoices

  As a Mozy Enterprise customer
  I want to construct my billing terms in a way that fits my needs and usage
  so that I can pay the way that makes sense to me (ex. bundles packages, minimums, per-user licensing, etc).

  Background:
    Given I log in bus admin console as administrator

  @TC.15686 @slow
  Scenario: 15686 Verify Aria sends email when create a new MozyPro partner
    When I add a new MozyPro partner:
    | period | base plan     |
    | 1      | 50 GB, $19.99 |
    Then New partner should be created
    When I wait for 30 seconds
    When I log in zimbra as default zimbra account
    And I search email to match all keywords:
    | to     | date    | subject                  |
    | @email | @today  | MozyPro Account Created! |
    Then I should see 1 email(s) displayed in search results
    When I search email to match all keywords:
    | from        | to     | date    | subject                  |
    | ar@mozy.com | @email | @today  | MozyQA Account Statement |
    Then I should see 1 email(s) displayed in search results


  @TC.15687 @slow
  Scenario: 15687 Verify Aria sends invoice email when change subscription period of a MozyPro partner
    When I add a new MozyPro partner:
    | period | base plan     |
    | 1      | 50 GB, $19.99 |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription up to MozyPro annual billing period
    Then Subscription changed message should be Your account has been changed to yearly billing.
    When I wait for 30 seconds
    And I log in zimbra as default zimbra account
    And I search email to match all keywords:
    | to            | date    | subject                  | content  |
    | qa1@mozy.com  | @today  | MozyQA Account Statement | @address |
    Then I should see 2 email(s) displayed in search results

  @TC.17841 @slow
  Scenario: 15686 Verify Aria sends email when create a new MozyEnterprise partner
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 1     |
    Then New partner should be created
    When I wait for 30 seconds
    And I log in zimbra as default zimbra account
    And I search email to match all keywords:
    | to     | date    | subject                         |
    | @email | @today  | MozyEnterprise Account Created! |
    Then I should see 1 email(s) displayed in search results
    When I search email to match all keywords:
    | from        | to     | date    | subject                  |
    | ar@mozy.com | @email | @today  | MozyQA Account Statement |
    Then I should see 1 email(s) displayed in search results

  @TC.17842 @slow
  Scenario: 17842 Verify Aria sends invoice email when change subscription period of a MozyEnterprise partner
    When I add a new MozyEnterprise partner:
    | period | users |
    | 12     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription up to MozyEnterprise biennial billing period
    Then Subscription changed message should be Your account has been changed to biennial billing.
    When I wait for 30 seconds
    And I log in zimbra as default zimbra account
    And I search email to match all keywords:
    | to            | date    | subject                  | content  |
    | qa1@mozy.com  | @today  | MozyQA Account Statement | @address |
    Then I should see 2 email(s) displayed in search results