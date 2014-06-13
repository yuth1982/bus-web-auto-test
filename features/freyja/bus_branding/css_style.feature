Feature: BUS branding - css style

  As an Mozy administrator
  I want to change web css style
  So that oem users can have branded freyja page

  Background:
    Given I log in bus admin console as administrator
    When I act as partner by:
      | name                |
      | QA13 White label |
    And I navigate to Web Access Site Branding section from bus admin console page

  @TC @freyja @oem_css
  Scenario: Successfully verify 'Test Connection' button should work with valid organization name
   When I input content color hex for header and footer
   And I save changes
   When I navigate to freyja ent login page
   And I login as a existing user
   Then I should view content color changed after waiting 2 minutes
