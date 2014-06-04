Feature: Product download

  Background:
    Given I have login freyja as ent user

  @freyja  @ent  @ent_product_download
Scenario: MozyEnterprise user view product download through Freyja
  When I select options menu
  And I select Product Downloads
  And I click View website
  When I select options menu
  And I logout
