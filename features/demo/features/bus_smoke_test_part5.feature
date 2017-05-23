Feature: BUS smoke test 5
  pre-condition
  update environment:
  option 1: TEST_ENV = ENV['BUS_ENV'] || 'qa6' in test_sites/configs/configs_helper.rb
  option 2: export BUS_ENV=<environment>

  Background:
    Given I log in bus admin console as administrator

  #================== partner 'Internal Mozy - Reseller Ireland BUS Smoke Test 7531-8642-90' related scenarios ===================
  @bus_emea @TC.125966 @ROR_smoke
  Scenario: Test Case Mozy-125966: BUS EMEA -- Activate partner in email
    When I add a new Reseller partner:
      | company name                                                 | period | base plan | create under    | server plan | net terms | country | coupon                |
      | Internal Mozy - Reseller Ireland BUS Smoke Test 7531-8642-90 | 12     | 10 GB     | MozyPro Ireland | yes         | yes       | Ireland | <%=QA_ENV['coupon']%> |
    And New partner should be created
    And the partner has activated the admin account with default password
    And I go to account
    Then I login as mozypro admin successfully
