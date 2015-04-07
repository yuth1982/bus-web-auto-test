Feature: BUS Regression Test

  Background:
    Given I log in bus admin console as administrator

  @TC.2188 @bus @others
  Scenario: 2188 XXS issues and input validation
    When I search partner by <script>alert('foo')</script>
    Then I will see alert('foo') in the search partner input box