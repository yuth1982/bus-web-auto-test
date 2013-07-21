Feature: Change subscription period

  As a Mozy Administrator
  I want to change my subscription period longer
  so that I can save money on my Mozy subscription and be billed less frequently.

  Background:
    Given I log in bus admin console as administrator

  @TC.15231 @bus @change_period
  Scenario: 15231 MozyPro US - Change Period from Monthly to Yearly - CC
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to annual billing period!
    Then Subscription changed message should be Your account has been changed to yearly billing.
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then Partner internal billing should be:
      | Account Type:   | Credit Card   | Current Period: | Yearly              |
      | Unpaid Balance: | $0.00         | Collect On:     | N/A                 |
      | Renewal Date:   | after 1 year  | Renewal Period: | Use Current Period  |
    And I delete partner account

  @TC.15232 @bus @change_period
  Scenario: 15232 MozyPro FR - Change Period from Yearly to Biennially - CC
    When I add a new MozyPro partner:
      | period | base plan | create under   | country |
      | 12     | 50 GB     | MozyPro France | France  |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to biennial billing period!
    Then Subscription changed message should be Your account has been changed to biennial billing.
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then Partner internal billing should be:
      | Account Type:   | Credit Card   | Current Period: | Biennial            |
      | Unpaid Balance: | €0.00         | Collect On:     | N/A                 |
      | Renewal Date:   | after 2 years | Renewal Period: | Use Current Period  |
    And I delete partner account

  @TC.15233 @bus @change_period
  Scenario: 15233 MozyPro DE - Change Period from Monthly to Biennially - CC
    When I add a new MozyPro partner:
      | period | base plan | create under    | country |
      | 12     | 50 GB     | MozyPro Germany | Germany |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to biennial billing period!
    Then Subscription changed message should be Your account has been changed to biennial billing.
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then Partner internal billing should be:
      | Account Type:   | Credit Card   | Current Period: | Biennial            |
      | Unpaid Balance: | €0.00         | Collect On:     | N/A                 |
      | Renewal Date:   | after 2 years | Renewal Period: | Use Current Period  |
    And I delete partner account

  @TC.15234 @bus @change_period
  Scenario: 15234 MozyPro IE - Change Period from Biennially to Yearly - Net Terms
    When I add a new MozyPro partner:
      | period | base plan | create under    | country | net terms |
      | 24     | 50 GB     | MozyPro Ireland | Ireland | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to annual billing period!
    Then Subscription changed message should be Your account will be switched to yearly billing schedule at your next renewal.
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then Partner internal billing should be:
      | Account Type:   | Net Terms 30  | Current Period: | Biennial  |
      | Unpaid Balance: | €413.02       | Collect On:     | N/A       |
      | Renewal Date:   | after 2 years | Renewal Period: | Yearly    |
    And I delete partner account

  @TC.15235 @bus @change_period
  Scenario: 15235 MozyPro UK - Change Period from Yearly to Monthly - Net Terms
    When I add a new MozyPro partner:
      | period | base plan | create under | country        | net terms |
      | 12     | 50 GB     | MozyPro UK   | United Kingdom | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to monthly billing period!
    Then Subscription changed message should be Your account will be switched to monthly billing schedule at your next renewal.
    When I stop masquerading
    And I view partner details by newly created partner company name
      Then Partner internal billing should be:
        | Account Type:   | Net Terms 30  | Current Period: | Yearly   |
        | Unpaid Balance: | £189.28       | Collect On:     | N/A      |
        | Renewal Date:   | after 1 year  | Renewal Period: | Monthly  |
    And I delete partner account

  @TC.15236 @bus @change_period
  Scenario: 15236 MozyPro US - Change Period from Biennially to Monthly - Net Terms
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 24     | 50 GB     | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to monthly billing period!
    Then Subscription changed message should be Your account will be switched to monthly billing schedule at your next renewal.
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then Partner internal billing should be:
      | Account Type:   | Net Terms 30  | Current Period: | Biennial    |
      | Unpaid Balance: | $419.79       | Collect On:     | N/A         |
      | Renewal Date:   | after 2 years | Renewal Period: | Monthly     |
    And I delete partner account

  @TC.15238 @bus @change_period
  Scenario: 15238 MozyEnterprise - Change Period from Yearly to Biennially - CC
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to biennial billing period!
    Then Subscription changed message should be Your account has been changed to biennial billing.
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then Partner internal billing should be:
      | Account Type:   | Credit Card   | Current Period: | Biennial            |
      | Unpaid Balance: | $0.00         | Collect On:     | N/A                 |
      | Renewal Date:   | after 2 years | Renewal Period: | Use Current Period  |
    And I delete partner account

  @TC.15239 @bus @change_period
  Scenario: 15239 MozyEnterprise - Change Period from Biennially to 3 Years - CC
    When I add a new MozyEnterprise partner:
      | period | users |
      | 24     | 10    |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to 3-year billing period!
    Then Subscription changed message should be Your account has been changed to 3-year billing.
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then Partner internal billing should be:
      | Account Type:   | Credit Card   | Current Period: | 3-year              |
      | Unpaid Balance: | $0.00         | Collect On:     | N/A                 |
      | Renewal Date:   | after 3 years | Renewal Period: | Use Current Period  |
    And I delete partner account

  @TC.15240 @bus @change_period
  Scenario: 15240 MozyEnterprise - Change Period from Yearly to 3 Years - CC
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to 3-year billing period!
    Then Subscription changed message should be Your account has been changed to 3-year billing.
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then Partner internal billing should be:
      | Account Type:   | Credit Card   | Current Period: | 3-year              |
      | Unpaid Balance: | $0.00         | Collect On:     | N/A                 |
      | Renewal Date:   | after 3 years | Renewal Period: | Use Current Period  |
    And I delete partner account

  @TC.15241 @bus @change_period
  Scenario: 15241 MozyEnterprise - Change Period from Biennially to Yearly - Net Terms
    When I add a new MozyEnterprise partner:
      | period | users | net terms |
      | 24     | 10    | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to annual billing period!
    Then Subscription changed message should be Your account will be switched to yearly billing schedule at your next renewal.
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then Partner internal billing should be:
      | Account Type:   | Net Terms 30  | Current Period: | Biennial  |
      | Unpaid Balance: | $1,810.00     | Collect On:     | N/A       |
      | Renewal Date:   | after 2 years | Renewal Period: | Yearly    |
    And I delete partner account

  @TC.15243 @bus @change_period
  Scenario: 15243 MozyEnterprise - Change Period from 3 Years to Biennially - Net Terms
    When I add a new MozyEnterprise partner:
      | period | users | net terms |
      | 36     | 10    | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to biennial billing period!
    Then Subscription changed message should be Your account will be switched to biennial billing schedule at your next renewal.
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then Partner internal billing should be:
      | Account Type:   | Net Terms 30  | Current Period: | 3-year      |
      | Unpaid Balance: | $2,590.00     | Collect On:     | N/A         |
      | Renewal Date:   | after 3 years | Renewal Period: | Biennially  |
    And I delete partner account

  @TC.15244 @bus @change_period
  Scenario: 15244 MozyEnterprise - Change Period from 3 Years to Yearly - Net Terms
    When I add a new MozyEnterprise partner:
      | period | users | net terms |
      | 36     | 10    | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to annual billing period!
    Then Subscription changed message should be Your account will be switched to yearly billing schedule at your next renewal.
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then Partner internal billing should be:
      | Account Type:   | Net Terms 30  | Current Period: | 3-year    |
      | Unpaid Balance: | $2,590.00     | Collect On:     | N/A       |
      | Renewal Date:   | after 3 year  | Renewal Period: | Yearly    |
    And I delete partner account

  @TC.15245 @bus @change_period
  Scenario: 15245 Reseller US - Change Period from Monthly to Yearly - CC
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 100            |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to annual billing period!
    Then Subscription changed message should be Your account has been changed to yearly billing.
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then Partner internal billing should be:
      | Account Type:   | Credit Card   | Current Period: | Yearly              |
      | Unpaid Balance: | $0.00         | Collect On:     | N/A                 |
      | Renewal Date:   | after 1 year  | Renewal Period: | Use Current Period  |
    And I delete partner account

  @TC.15246 @bus @change_period
  Scenario: 15246 Reseller US - Change Period from Yearly to Monthly - Net Terms
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 12     | Gold          | 100            | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to monthly billing period!
    Then Subscription changed message should be Your account will be switched to monthly billing schedule at your next renewal.
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then Partner internal billing should be:
      | Account Type:   | Net Terms 30  | Current Period: | Yearly   |
      | Unpaid Balance: | $385.00       | Collect On:     | N/A      |
      | Renewal Date:   | after 1 year  | Renewal Period: | Monthly  |
    And I delete partner account

  @TC.15383 @bus @change_period
  Scenario: 15383 Verify Reseller confirmation message when change period to yearly
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 100            |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to annual billing period
    Then Change subscription confirmation message should be:
      """
      Are you sure that you want to change your subscription period from monthly to yearly billing?
      If you choose to continue, your account will be credited for the remainder of your monthly Subscription, then charged for a new yearly subscription beginning today. By choosing yearly billing, you will receive 1 free month(s) of Mozy service.
      Any resources you scheduled for return in your next subscription have been deducted from the new subscription total.
      """
    And Change subscription price table should be:
      | Description                                   | Amount   |
      | Credit for remainder of monthly subscription  | $42.00   |
      | Charge for new yearly subscription            | $462.00  |
      | Total amount to be charged                    | $420.00  |
    When I continue to change account subscription
    Then Subscription changed message should be Your account has been changed to yearly billing.
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.15384 @bus @change_period
  Scenario: 15384 Verify MozyPro confirmation message when change period to biennially
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to biennial billing period
    Then Change subscription confirmation message should be:
      """
      Are you sure that you want to change your subscription period from monthly to biennial billing?
      If you choose to continue, your account will be credited for the remainder of your monthly Subscription, then charged for a new biennial subscription beginning today. By choosing biennial billing, you will receive 3 free month(s) of Mozy service.
      Any resources you scheduled for return in your next subscription have been deducted from the new subscription total.
      """
    And Change subscription price table should be:
      | Description                                   | Amount   |
      | Credit for remainder of monthly subscription  | $19.99   |
      | Charge for new biennial subscription          | $419.79  |
      | Total amount to be charged                    | $399.80  |
    When I continue to change account subscription
    Then Subscription changed message should be Your account has been changed to biennial billing.
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.15385 @bus @change_period
  Scenario: 15385 Verify MozyEnterprise confirmation message when change period to 3 years
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to 3-year billing period
    Then Change subscription confirmation message should be:
      """
      Are you sure that you want to change your subscription period from yearly to 3-year billing?
      If you choose to continue, your account will be credited for the remainder of your yearly Subscription, then charged for a new 3-year subscription beginning today. By choosing 3-year billing, you will receive 0 free month(s) of Mozy service.
      Any resources you scheduled for return in your next subscription have been deducted from the new subscription total.
      """
    And Change subscription price table should be:
      | Description                                   | Amount   |
      | Credit for remainder of yearly subscription   | $95.00   |
      | Charge for new 3-year subscription            | $259.00  |
      | Total amount to be charged                    | $164.00  |
    When I continue to change account subscription
    Then Subscription changed message should be Your account has been changed to 3-year billing.
    When I stop masquerading
    And I search and delete partner account by newly created partner company name




