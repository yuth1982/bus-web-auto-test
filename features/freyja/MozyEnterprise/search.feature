Feature: Search

  Background:
    Given I have login freyja as ent user

  @freyja @freyja_smoke  @ent @ent_search  @ent_search_files
Scenario: MozyEnterprise user search files through Freyja
  When I select the Synced tab
  When I enter search file keyword in search box
  And I click search
  Then search results is displayed
  When I select the Devices tab
  When I enter search file keyword in search box
  And I click search
  Then search results is displayed
  When I select options menu
  And I logout

@freyja @freyja_smoke  @ent @ent_search  @ent_search_folders
  Scenario: MozyEnterprise user search folders through Freyja
    When I select the Synced tab
    When I enter search folder keyword in search box
    And I click search
    Then search results is displayed
    When I select the Devices tab
    When I enter search folder keyword in search box
    And I click search
    Then search results is displayed
    When I select options menu
    And I logout

