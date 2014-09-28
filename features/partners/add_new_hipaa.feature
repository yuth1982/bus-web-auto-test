Feature: Add a new partner

  As a Mozy Administrator
  I want to create HIPAA compliance partners
  So that I can organize my business in a way that works for me

  Background:
    Given I log in bus admin console as administrator

  @TC.120069 @bus  @need_test_account
  Scenario: 120069 HIPAA for MozyPro US partner and sub-partners
   When I add a new MozyPro partner:
    | period | base plan | security | net terms |
    | 12     | 50 GB     |  HIPAA   |    yes    |
   Then Sub-total before taxes or discounts should be $219.89
   And Order summary table should be:
    | Description       | Quantity | Price Each | Total Price |
    | 50 GB             | 1        | $219.89    | $219.89     |
    | Pre-tax Subtotal  |          |            | $219.89     |
    | Total Charges     |          |            | $219.89     |
   And New partner should be created
   And Partner general information should be:
    | Security: | Status:         | Root Admin:          | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: |
    | HIPAA     | Active (change) | @root_admin (act as) | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         |
   And I change root role to Leong Test Role
   And I act as newly created partner
   When I navigate to Add New Role section from bus admin console page
   And I add a new role:
    | Name    | Type          |
    | newrole | Partner admin |
   When I navigate to Add New Pro Plan section from bus admin console page
   Then I add a new pro plan for Mozypro partner:
    | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
    | newplan | business     | newrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | test     | false            | 1                          | 1                     |
   And I add a new sub partner:
    | Company Name |
    | TC.120069    |
   And New partner should be created
   And SubPartner general information should be:
    | Security: |
    | HIPAA     |
   And I delete subpartner account
   And I stop masquerading
   And I search and delete partner account by newly created partner company name

  @TC.120077 @bus
  Scenario: 120077 HIPAA for Mozy Reseller US partner and sub-partners
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms | security |
      | 12     |  Silver       | 100            |    yes    |   HIPAA  |
    Then Sub-total before taxes or discounts should be $462.00
    And Order summary table should be:
      | Description           | Quantity | Price Each | Total Price |
      | GB - Silver Reseller  | 100      | $4.62      | $462.00     |
      | Pre-tax Subtotal      |          |            | $462.00     |
      | Total Charges         |          |            | $462.00     |
    And New partner should be created
    And Partner general information should be:
      | Security: | Status:         | Root Admin:          | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: |
      | HIPAA     | Active (change) | @root_admin (act as) | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         |
    And I act as newly created partner
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | newrole | Partner admin |
    When I navigate to Add New Pro Plan section from bus admin console page
    Then I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | test     | false            | 1                          | 1                     |
    And I add a new sub partner:
      | Company Name |
      | TC.120077    |
    And New partner should be created
    And SubPartner general information should be:
      | Security: |
      | HIPAA     |
    And I delete subpartner account
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

    @TC.120079 @bus
    Scenario: 120079 HIPAA for Mozy Enterprize and sub-partners
      When I add a new MozyEnterprise partner:
        | period | users  | net terms | security |
        | 12     | 200    |    yes    |  HIPAA   |
      Then Sub-total before taxes or discounts should be $19,000.00
      And Order summary table should be:
        | Description           | Quantity | Price Each | Total Price |
        | MozyEnterprise User   | 200      | $95.00     | $19,000.00  |
        | Pre-tax Subtotal      |          |            | $19,000.00  |
        | Total Charges         |          |            | $19,000.00  |
      And New partner should be created
      And Partner general information should be:
        | Security: | Status:         | Root Admin:          | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: |
        | HIPAA     | Active (change) | @root_admin (act as) | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         |
      And I act as newly created partner
      When I navigate to Add New Role section from bus admin console page
      And I add a new role:
        | Name    | Type          |
        | newrole | Partner admin |
      When I navigate to Add New Pro Plan section from bus admin console page
      Then I add a new pro plan for MozyEnterprise partner:
        | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
        | newplan | business     | newrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | test     | false            | 1                          | 1                     |
      And I add a new sub partner:
        | Company Name |
        | TC.120077    |
      And New partner should be created
      And SubPartner general information should be:
        | Security: |
        | HIPAA     |
      And I delete subpartner account
      And I stop masquerading
      And I search and delete partner account by newly created partner company name

  @TC.120080 @bus
  Scenario: 120080 HIPAA for Mozy OEM and sub-partners
    When I add a new OEM partner:
      | company_name  | security |
      | TC.120080.OEM | HIPAA    |
    And New partner should be created
    And SubPartner general information should be:
      | Security: | Status:         | Subdomain:              |
      | HIPAA     | Active (change) | (learn more and set up) |
    And I act as newly created partner
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | newrole | Partner admin |
    And I add a new sub partner:
      | Company Name |
      | TC.120080    |
    And New partner should be created
    And SubPartner general information should be:
      | Security: |
      | HIPAA     |
    And I delete subpartner account
    And I stop masquerading from subpartner
    Then I search and delete partner account by TC.120080.OEM

  @TC.120167 @bus
  Scenario: 120167 Error will occur if no 'Security' option is selected during partner creation
    When I add a new MozyPro partner:
      | period | security |
      | 12     |          |
    Then Add New Partner error message should be:
    """
    Security field cannot be blank
    """
    Then I add a new OEM partner:
      | company_name  | security |
      | TC.120167.OEM |          |
    Then Add New Partner error message should be:
    """
    Security field cannot be blank
    """
