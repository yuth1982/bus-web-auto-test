Feature: BUS smoke test
  pre-condition
  update environment:
  option 1: TEST_ENV = ENV['BUS_ENV'] || 'qa6' in test_sites/configs/configs_helper.rb
  option 2: export BUS_ENV=<environment>

  Background:
    Given I log in bus admin console as administrator

  @cleanup
  Scenario: Delete all the created partners
    Then I search and delete partner account if it exists by Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - MozyPro BUS Smoke Test Data Shuttle 6201-2851-04

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - MozyEnterprise BUS Smoke Test 1704-3692-83

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - MozyPro France BUS Smoke Test Report 4170-3928-56

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - MozyPro France BUS Smoke Test Data Shuttle 2468-1359-07

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - MozyEnterprise BUS Smoke Test Report 5062-7291-02

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - Reseller Ireland BUS Smoke Test 7531-8642-90
