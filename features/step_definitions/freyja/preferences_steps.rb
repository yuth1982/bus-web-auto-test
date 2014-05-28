And /^I choose (Devices|Synced) radio$/ do |device_choice|
  @user.device_Radio_preference = device_choice
  @freyja_site.preference_page.chooseRadio(@user.device_Radio_preference)
end

And /^I choose (Yes|No) for restore queue$/ do |rq_choice|
  @user.restore_queue = rq_choice
  @freyja_site.preference_page.choose_RQ(@user.restore_queue)
end

And /^I click save Preferences button$/ do
  @freyja_site.preference_page.click_save_preference
end

Then /^page preference should be (Devices|Synced) start and (enable|disable) restore queue$/ do |device_choice, rq_choice|
  @freyja_site.preference_page.get_start_device.should == device_choice
  @freyja_site.main_page.chooseDevice("Devices")
  #@freyja_site.main_page.Drillin_win_backup_folder(@user.backup_machineID, @user.backup_folder)
  #@freyja_site.main_page.open_actions_panel
  #@freyja_site.preference_page.get_rq_status.should == rq_choice
end