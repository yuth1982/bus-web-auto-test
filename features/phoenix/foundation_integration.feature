Feature: Phoenix Integration of features for the foundation release

  As a business owner
  I want to create a partner through phoenix
  So that I can organize my business in a way that works for me

  Background:
    Given I am at dom selection point:

  #
  # Case for user list view updates - via partner created through phoenix
  #   This is also the banner case for integration of pooled storage with phoenix
  #   Redmine: 98385
  #
  @TC.21317
  Scenario: 21317 - Pooled Storage - Pro SMB - Phoenix Integration - User List View - removal of assigned/used quota
    When I add a phoenix Pro partner:
      | period | base plan | country       | server plan |
      | 1      | 100 GB    | United States | yes         |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And I view partner details by newly created partner company name
    And I enable stash for the partner with default stash storage
    And I act as newly created partner
    And I add new user(s):
      | name       | storage_type | storage_limit | devices | enable_stash |
      | TC.21012-1 | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    And I refresh Add New User section
    When I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.21012-2 | Desktop      |               | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | Name        | Stash    | Storage        |
      | TC.21012-1  | Enabled  | 10 GB(Limited) |
      | TC.21012-2  | Disabled | Shared         |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  #
  # Case for Quick Link section
  #   Section heading is only a title, as each link goes to different modules
  #   Case for bundled Pro through phoenix UI
  #   Redmine: 99171
  #
    @TC.21297
    Scenario: 21297 MozyPro - Phoenix UI - New Quick Link Section
      When I add a phoenix Pro partner:
        | period | base plan | country       | server plan |
        | 1      | 100 GB    | United States | yes         |
      And the partner is successfully added.
      And I log in bus admin console as administrator
      And I search partner by:
        | name          | filter |
        | @company_name | None   |
      And I view partner details by newly created partner company name
      And I act as newly created partner
      And new section & navigation items are present for MozyPro partner
      And I stop masquerading
      And I search and delete partner account by newly created partner company name

  #
  # Case for nav removal items
  #   Case for bundled Pro through phoenix UI
  #   Redmine: 99538
  #
    @TC.21177
    Scenario: 21177 MozyPro - Phoenix UI - Left nav link removal
      When I add a phoenix Pro partner:
        | period | base plan | country       | server plan |
        | 1      | 100 GB    | United States | yes         |
      And the partner is successfully added.
      And I log in bus admin console as administrator
      And I search partner by:
        | name          | filter |
        | @company_name | None   |
      And I view partner details by newly created partner company name
      And I act as newly created partner
      And navigation items should be removed
      And I stop masquerading
      And I search and delete partner account by newly created partner company name
