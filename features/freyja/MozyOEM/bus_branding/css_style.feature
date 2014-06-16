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
  Scenario: Successfully change header and footer color
   When I input content color hex for header and footer
   And I save changes
   Then I waited 1 minutes
   When I navigate to freyja oem login page
   And I login as a existing user
   Then freyja page is displayed

