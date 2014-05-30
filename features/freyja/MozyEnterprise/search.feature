Feature: Search

  Background:
    Given I have login freyja as ent user

  @freyja  @ent @ent_search  @ent_search_files
Scenario: MozyEnterprise user search files through Freyja
  When I enter search file keyword in search box
  And I click search
  Then search results is displayed