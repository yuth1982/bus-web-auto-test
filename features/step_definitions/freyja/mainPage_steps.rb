
When /^I select the (Devices|Synced) tab$/ do |device_choice|
  @user.deviceTab = device_choice
  @freyja_site.main_page.chooseDevice(@user)

end

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

And /^I choose the uploaded file$/ do
  uploaded_file_path = QA_ENV['local_file_upload']
  uploaded_file_name = uploaded_file_path.split('/')[-1]
  @freyja_site.main_page.select_uploaded_file(@user.sync_machineID, uploaded_file_name)
end

And /^I choose one file with versions$/ do
  case @user.deviceTab
    when 'Synced'
      @freyja_site.main_page.Drillin_sync_file(@user.sync_machineID, @user.sync_file_versions)
    when 'Devices'
      #@freyja_site.main_page.Drillin_backup_file_versions(@user.backup_machineID, @user.backup_file)
  end
end

