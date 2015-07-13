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
    Then I search and delete partner account if it exists by Internal Mozy - Reseller BUS Smoke Test 3849-7653-73

  @cleanup
  Scenario: Delete all the created partners
    Then I search and delete partner account if it exists by Internal Mozy - OEM BUS Smoke Test 4863-2704-60

  @cleanup
  Scenario: Delete all the created partners
    Then I search and delete partner account if it exists by Internal Mozy - subpartner1 8376-3615-73

  @cleanup
  Scenario: Delete all the created partners
    Then I search and delete partner account if it exists by Internal Mozy - subpartner2 4974-9147-43

  @cleanup
  Scenario: Delete all the created partners
    Then I search and delete partner account if it exists by Internal Mozy - MozyPro BUS Smoke Storage Test 1543-8769-22

  @cleanup
  Scenario: Delete all the created partners
    Then I search and delete partner account if it exists by Internal Mozy - MozyEnterprise BUS Smoke Test Report 5062-7291-02

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - MozyPro BUS Smoke Test Credit Card 0709-1754-57

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - MozyPro BUS Smoke Test Credit Card 0709-1802-56

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - MozyPro BUS Smoke Test Data Shuttle 6201-2851-04

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - MozyPro BUS Smoke Test 5958-2015-10

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - Reseller BUS Smoke Test 5959-3026-41

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - MozyEnterprise BUS Smoke Test 1704-3692-83

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - Fortress BUS Smoke Test 2940-4826-39

  @cleanup
  Scenario: Delete all the created partners
    Then I search and delete partner account if it exists by Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27

  @cleanup
  Scenario: Delete all the created partners
    Then I search and delete partner account if it exists by Internal Mozy - MozyPro France BUS Smoke Test Report 4170-3928-56

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - Reseller Ireland BUS Smoke Test 7531-8642-90

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - MozyPro France BUS Smoke Test Data Shuttle 2468-1359-07

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - MozyPro BUS Smoke Test 5979-5120-35

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - MozyPro BUS Smoke Test 5980-4326-85
