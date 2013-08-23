Feature: CMS Content Verification

  As a Mozy employee, I want to verify certain CMS content items

  Background:
  # Prod-188 : verification of DL content links on pro/home CMS pages

  @TC.188
  Scenario: Verification of download link items in CMS content download section
    When I am at dom selection point:
    And I verify download page contents
