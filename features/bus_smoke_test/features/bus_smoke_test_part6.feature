Feature: BUS smoke test
  pre-condition
  update environment:
  option 1: TEST_ENV = ENV['BUS_ENV'] || 'qa6' in test_sites/configs/configs_helper.rb
  option 2: export BUS_ENV=<environment>

  Background:
    Given I log in bus admin console as administrator

  #================== partner 'Internal Mozy - MozyPro France BUS Smoke Test Data Shuttle 2468-1359-07' related scenarios ===================
  @bus_emea @TC.125975 @qa
  Scenario: Test Case Mozy-125975: BUS EMEA -- Order Data Shuttle
    When I add a new MozyPro partner:
      | company name                                                            | period  | base plan | create under   | server plan | net terms | country | coupon                |
      | Internal Mozy - MozyPro France BUS Smoke Test Data Shuttle 2468-1359-07 | 12      | 50 GB     | MozyPro France | yes         | yes       | France  | <%=QA_ENV['coupon']%> |
    And New partner should be created
    And I change root role to Business Root
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type  | storage_limit | devices |
      | (default user group) | Desktop       | 10            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for Internal Mozy - MozyPro France BUS Smoke Test Data Shuttle 2468-1359-07
      | power adapter     | key from  | quota |
      | Data Shuttle EMEA | available | 10    |
    Then Data shuttle order should be created

  @bus_emea @TC.125976 @qa
  Scenario: Test Case Mozy-125976: BUS EMEA -- Update Data Shuttle - Precondition:@TC.125975
    When I search order in view data shuttle orders section by Internal Mozy - MozyPro France BUS Smoke Test Data Shuttle 2468-1359-07
    And I view data shuttle order details
    And I add drive to data shuttle order
    Then Add drive to data shuttle order message should include Successfully added drive to order

  @bus_emea @TC.125975 @std
  Scenario: Test Case Mozy-125975: BUS EMEA -- Order Data Shuttle
    When I order data shuttle for Internal Mozy - MozyPro France for EMEA Data Shuttle(Don't Edit)
      | power adapter     | key from  |
      | Data Shuttle EMEA | available |
    Then Data shuttle order should be created

  @bus_emea @TC.125976 @std
  Scenario: Test Case Mozy-125976: BUS EMEA -- Update Data Shuttle - Precondition:@TC.125975
    When I search order in view data shuttle orders section by Internal Mozy - MozyPro France for EMEA Data Shuttle(Don't Edit)
    And I view data shuttle order details
    And I add drive to data shuttle order
    Then Add drive to data shuttle order message should include Successfully added drive to order
    When I cancel the latest data shuttle order for Internal Mozy - MozyPro France for EMEA Data Shuttle(Don't Edit)
    Then The order should be Cancelled

  #=====================================
  @bus_emea @TC.125979
  Scenario: Test Case Mozy-125979: BUS EMEA -- Delete test partner and validate they are in Pending Delete state
    When I add a new MozyPro partner:
      | period  |  create under   | server plan | net terms | country | coupon                |
      | 12      |  MozyPro France | yes         | yes       | France  | <%=QA_ENV['coupon']%> |
    And New partner should be created
    And I delete partner and verify pending delete

  @bus_emea @TC.125980
  Scenario: Test Case Mozy-125980: BUS EMEA -- Create a new partner (With VAT Number)
    When I add a new MozyPro partner:
      | period | base plan | create under | server plan | net terms | country        | coupon                | vat number  |
      | 1      | 10 GB     | MozyPro UK   | yes         | yes       | United Kingdom | <%=QA_ENV['coupon']%> | GB117223643 |
    And New partner should be created
    Then I delete partner account

  #================== partner 'Rainbow MozyPro EMEA' related scenarios ===================
  @bus_us @TC.125974 @support @qa_std
  Scenario: Test Case Mozy-125974: BUS EMEA -- Check the support link
    When I act as partner by:
      | name                 |
      | Rainbow MozyPro EMEA |
    When I navigate to Contact section from bus admin console page
    And I click my support
    Then I login my support successfully

  #================== partner 'Internal Mozy - Reseller Ireland BUS Smoke Test 7531-8642-90' related scenarios ===================
  @bus_emea @TC.125966
  Scenario: Test Case Mozy-125966: BUS EMEA -- Activate partner in email
    When I add a new Reseller partner:
      | company name                                                 | period | base plan | create under    | server plan | net terms | country | coupon                |
      | Internal Mozy - Reseller Ireland BUS Smoke Test 7531-8642-90 | 12     | 10 GB     | MozyPro Ireland | yes         | yes       | Ireland | <%=QA_ENV['coupon']%> |
    And New partner should be created
    And the standard partner has activated the admin account
    And I go to account
    Then I login as mozypro admin successfully