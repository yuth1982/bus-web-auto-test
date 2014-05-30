Feature: Change Preference Settings

  Background:
    Given I have login freyja as home user

  @freyja  @home  @home_preference
Scenario: Mozyhome user change preference settings through Freyja
  When I select options menu
  And I select Preferences
  And I choose Devices radio
  And I choose Yes for restore queue
  And I click save Preferences button
  Then page preference should be Devices start and enable restore queue
  When I select options menu
  And I select Preferences
  And I choose Synced radio
  And I choose No for restore queue
  And I click save Preferences button
  And I re-login
  Then page preference should be Synced start and disable restore queue
  When I select options menu
  And I logout