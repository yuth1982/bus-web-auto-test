Feature: View Event History

  Background:
    Given I have login freyja as ent user

  @freyja @smoke  @ent  @ent_event_history
Scenario: MozyEnterprise user view event history through Freyja
  When I select options menu
  And I select event history
  And I choose the latest event
  Then detail panel slide in
  And I choose the latest event
  When I select options menu
  And I logout
