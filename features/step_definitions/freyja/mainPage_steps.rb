
# select (Devices|Synced) tab
When /^I select the (Devices|Synced) tab$/ do |device_choice|
  @user.deviceTab = device_choice
  @freyja_site.main_page.chooseDevice(@user.deviceTab)

end

# choose one file in Sync or Backup devices
And /^I choose one file$/ do
  case @user.deviceTab
    when 'Synced'
      @freyja_site.main_page.Drillin_sync_file(@user.sync_machineID, @user.sync_file)
    when 'Devices'
      @freyja_site.main_page.Drillin_win_backup_file(@user.backup_machineID, @user.backup_file)
  end
end

And /^I open Actions panel$/ do
  @freyja_site.main_page.open_actions_panel
end

When /^I select options menu$/ do
  @freyja_site.main_page.select_options_panel
end

# choose one folder in Sync or Backup devices
And /^I choose one folder$/ do
  case @user.deviceTab
    when 'Synced'
      @freyja_site.main_page.Drillin_sync_folder(@user.sync_machineID, @user.sync_folder)
    when 'Devices'
      @freyja_site.main_page.Drillin_win_backup_folder(@user.backup_machineID, @user.backup_folder)
  end
end

And /^I choose one device$/ do
  @freyja_site.main_page.choose_one_backup_device(@user.backup_machineID)
end

# choose one file to upload
And /^I choose the uploaded file$/ do
  uploaded_file_path = QA_ENV['local_file_upload']
  uploaded_file_name = uploaded_file_path.split('/')[-1]
  @freyja_site.main_page.Drillin_sync_file(@user.sync_machineID, uploaded_file_name)
end

# choose one file with versions
And /^I choose one file with versions$/ do
  case @user.deviceTab
    when 'Synced'
      @freyja_site.main_page.Drillin_sync_file(@user.sync_machineID, @user.sync_file_versions)
    when 'Devices'
      @freyja_site.main_page.Drillin_win_backup_file(@user.backup_machineID, @user.backup_file_versions)
  end
end

# choose one file's latest version
When /^I select the latest version$/ do
  @freyja_site.main_page.select_latest_version
end

# choose one deleted file
And /^I choose one deleted file$/ do
  case @user.deviceTab
    when 'Synced'
      uploaded_file_path = QA_ENV['local_file_upload']
      uploaded_file_name = uploaded_file_path.split('/')[-1]
      @freyja_site.main_page.select_uploaded_file(@user.sync_machineID, uploaded_file_name)
  end

end

# verify deleted file isn't shown
Then /^deleted files isn't shown$/ do
  case @user.deviceTab
    when 'Synced'
      uploaded_file_path = QA_ENV['local_file_upload']
      uploaded_file_name = uploaded_file_path.split('/')[-1]
      @freyja_site.main_page.check_file_exist(@user.sync_machineID, uploaded_file_name).should be_false
  end
end

# enter one Backup device
And /^I select the device$/ do
  @freyja_site.main_page.select_backup_device(@user.backup_machineID)
end


Then /^I should view content color changed after waiting (.+) minutes$/ do |wait_time|
  @freyja_site.login_page(@user).login_verify.should be_true
end

