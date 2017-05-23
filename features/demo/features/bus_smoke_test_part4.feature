Feature: BUS smoke test 4
  pre-condition
  update environment:
  option 1: TEST_ENV = ENV['BUS_ENV'] || 'qa6' in test_sites/configs/configs_helper.rb
  option 2: export BUS_ENV=<environment>

  Background:
    Given I log in bus admin console as administrator

  #=====================================
  @bus_emea @TC.125963
  Scenario: Test Case Mozy-125963: BUS EMEA -- Log into BUS
    Given I log in bus admin console as administrator
