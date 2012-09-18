Feature: Corporate Invoices

  As a Mozy Enterprise customer
  I want to construct my billing terms in a way that fits my needs and usage
  so that I can pay the way that makes sense to me (ex. bundles packages, minimums, per-user licensing, etc).

  Background:
    Given I log in bus admin console as administrator

  @TC.15686 @slow @javascript
  Scenario: 15686 Verify Aria sends email when create a new MozyPro partner
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I should see 1 email(s) when I search keywords:
    | to     | date    | subject                  |
    | @email | @today  | MozyPro Account Created! |
    And I should see 1 email(s) when I search keywords:
    | from        | to     | date    | subject                  |
    | ar@mozy.com | @email | @today  | MozyQA Account Statement |

  @TC.15687 @slow @javascript
  Scenario: 15687 Verify Aria sends invoice email when change subscription period of a MozyPro partner
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription up to annual billing period
    Then Subscription changed message should be Your account has been changed to yearly billing.
    And I should see 2 email(s) when I search keywords:
    | to            | date    | subject                  | content  |
    | qa1@mozy.com  | @today  | MozyQA Account Statement | @address |

  @TC.17841 @slow @javascript
  Scenario: 15686 Verify Aria sends email when create a new MozyEnterprise partner
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    And I should see 1 email(s) when I search keywords:
      | to     | date    | subject                         |
      | @email | @today  | MozyEnterprise Account Created! |
    And I should see 1 email(s) when I search keywords:
      | from        | to     | date    | subject                  |
      | ar@mozy.com | @email | @today  | MozyQA Account Statement |

  @TC.17842 @slow @javascript
  Scenario: 17842 Verify Aria sends invoice email when change subscription period of a MozyEnterprise partner
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription up to biennial billing period
    Then Subscription changed message should be Your account has been changed to biennial billing.
    And I should see 2 email(s) when I search keywords:
      | to            | date    | subject                  | content  |
      | qa1@mozy.com  | @today  | MozyQA Account Statement | @address |