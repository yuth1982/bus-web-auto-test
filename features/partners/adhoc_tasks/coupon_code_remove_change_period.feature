Feature: Requirement #143134 Aria coupon code remove: change period and change plan

  account with coupon not in exception list, change period, delete coupon.
  other account, change period, not delete coupon.
  new plan: 250&500*1&2&4 yearly and biennially base and server plan, reseller monthly*yearly exclude monthly server plan.
  coupon exception list: Nonprofit10, 100pctOffInternalTestCustomer, 30pctultdpro.

  Background:
    Given I log in bus admin console as administrator

  @TC.143134_1102 @bus @change_period @mozypro
  Scenario: MozyPro USD 250 gb monthly to 250 gb yearly
    When I add a new MozyPro partner:
      | company name                                           | period | base plan |  country      | coupon                         |
      | DONOT EDIT MozyPro USD 250 gb monthly to 250 gb yearly | 1      | 250 GB    | United States | <%=QA_ENV['10percentcoupon']%> |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['10percentcoupon']%>
    When I act as newly created partner account
    And I go to change billing period section
    Then change billing period table should be:
      | Monthly Cost  | $94.99 *    | You are currently using this plan.                   |
      | Annual Cost   | $729.89 *   | Switch to annual billing (includes 1 free month!)    |
      | Biennial Cost | $1,399.79 * | Switch to biennial billing (includes 5 free months!) |
    And I change account subscription to annual billing period
    Then Change subscription confirmation message should be:
      """
      Are you sure that you want to change your subscription period from monthly to yearly billing?
      If you choose to continue, your account will be credited for the remainder of your monthly Subscription, then charged for a new yearly subscription beginning today. By choosing yearly billing, you will receive 1 free month(s) of Mozy service.
      Any resources you scheduled for return in your next subscription have been deducted from the new subscription total.
      """
    And Change subscription price table should be:
      | Description                                   | Amount  |
      | Credit for remainder of monthly subscription  | $85.49  |
      | Charge for new yearly subscription            | $729.89 |
      | Total amount to be charged                    | $644.40 |
    When I continue to change account subscription
    Then Subscription changed message should be Your account has been changed to yearly billing.
    And API* Aria account coupon code info should be nil
    And change billing period table should be:
      | Monthly Cost  | $94.99 *    | Switch to monthly billing                            |
      | Annual Cost   | $729.89 *   | You are currently using this plan.                   |
      | Biennial Cost | $1,399.79 * | Switch to biennial billing (includes 5 free months!) |
    And Next renewal info table should be:
      | Period          | Date         | Amount                               | Payment Type                  |
      | Yearly (change) | after 1 year | $729.89 (Without taxes or discounts) | Visa ending in @XXXX (change) |
    When I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | $644.40 | $644.40    | $0.00       |
      | today | $85.49  | $85.49     | $0.00       |
