When /^I restore all files from the details panel$/ do
  @freyja_site.restores_page.click_restore_all_files_btn
end

And /^I go through restore wizard$/ do |restore_table|
  attributes = restore_table.hashes.first

  @restore = Freyja::DataObj::Restore.new

  @restore.restore_name = attributes["restore name"] unless attributes["restore name"].nil?
  @restore.restore_type = attributes["restore type"] unless attributes["restore type"].nil?

  @freyja_site.restores_page.create_restore_all_files(@restore)
end

Then /^the restore is (.+)/ do |restore_status|
  id = RestoreHelper.get_restore_id_by_restore_name(@restore.restore_name)
  status = @freyja_site.restores_page.get_restore_status(id)
  status.should == restore_status
end
