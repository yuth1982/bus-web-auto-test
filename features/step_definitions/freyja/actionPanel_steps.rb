
And /^I click download now$/ do
  @restore = Freyja::DataObj::Restore.new
  @restore.restore_type = 'instant'
  @freyja_site.action_panel_page.click_download_now
end

And /^I click Large Download Options restore wizard$/ do
  @restore = Freyja::DataObj::Restore.new
  section_id = "//*[@title='Large Download Options...']"
  @freyja_site.action_panel_page.open_restore_wizard(section_id)
end

And /^I fill out the restore wizard$/ do |restore_table|
  attributes = restore_table.hashes.first
  @restore.restore_name = attributes["restore_name"] + "#{Time.now.strftime("%Y%m%d-%H%M%S")}" unless attributes["restore_name"].nil?
  @restore.restore_type = attributes["restore_type"] unless attributes["restore_type"].nil?

  @freyja_site.action_panel_page.large_download_options_section.large_download_options_restore(@restore)

end

And /^I click Upload Files$/ do
  @freyja_site.action_panel_page.click_upload_file_from_Actions_panel
end

And /^I upload one file$/ do
  @freyja_site.action_panel_page.upload_iframe.attach_one_file
  @freyja_site.action_panel_page.click_upload_files_in_Upload_panel
end

Then /^one file is uploaded successfully$/ do
  uploaded_file_path = QA_ENV['local_file_upload']
  uploaded_file_name = uploaded_file_path.split('/')[-1]
  @freyja_site.action_panel_page.check_one_file_uploaded(@user.sync_machineID, uploaded_file_name)
end

And /^I click Delete and confirm$/ do
  @freyja_site.action_panel_page.delete_one_file
end

Then /^file is Deleted$/ do
  uploaded_file_path = QA_ENV['local_file_upload']
  uploaded_file_name = uploaded_file_path.split('/')[-1]
  @freyja_site.action_panel_page.check_file_deleted?(@user.sync_machineID, uploaded_file_name).should be_false
end

And /^I click Show Versions$/ do
  @freyja_site.action_panel_page.click_show_versions
end

Then /^file versions are displayed$/ do
  @freyja_site.action_panel_page.check_file_versions
end