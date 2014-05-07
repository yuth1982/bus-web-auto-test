When /^I restore all files from the details panel$/ do
  @freyja_site.restores_page.click_restore_all_files_btn
end

And /^I go through restore all files restore wizard$/ do |restore_table|
  attributes = restore_table.hashes.first

  @restore = Freyja::DataObj::Restore.new

  @restore.restore_name = attributes["restore name"] unless attributes["restore name"].nil?
  @restore.restore_type = attributes["restore type"] unless attributes["restore type"].nil?

  @freyja_site.restores_page.create_restore_all_files(@restore)
end

And /^I go through Large Download Options restore wizard$/ do |restore_table|
  attributes = restore_table.hashes.first

  @restore = Freyja::DataObj::Restore.new

  @restore.restore_name = attributes["restore name"] unless attributes["restore name"].nil?
  @restore.restore_type = attributes["restore type"] unless attributes["restore type"].nil?

  @freyja_site.restores_page.create_large_download_options_restore(@restore)
end

Then /^the restore is (.+)/ do |restore_status|
  id = RestoreHelper.get_restore_id_by_restore_name(@restore.restore_name)
  status = @freyja_site.restores_page.get_restore_status(id)
  status.should == restore_status
end

And /^I download from the backup details pane$/ do
  @freyja_site.restores_page.click_backup_download_btn
  sleep 10
end

Then /^instant download is (.+)/ do  |instant_download_status|
  status = @freyja_site.restores_page.get_instant_download_restore_status
  status.should == instant_download_status
end
