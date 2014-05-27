And /^I click restore all files in the detail panel$/ do
  @restore = Freyja::DataObj::Restore.new
  section_id = "//*[@id='backup_tab']//a[@title='Restore All Files...']"
  @freyja_site.detail_panel_page.open_restore_all_files_wizard(section_id)
end

And /^I fill out the restore all files wizard$/ do |restore_table|
  attributes = restore_table.hashes.first
  @restore.restore_name = attributes["restore_name"] + "#{Time.now.strftime("%Y%m%d-%H%M%S")}" unless attributes["restore_name"].nil?
  @restore.restore_type = attributes["restore_type"] unless attributes["restore_type"].nil?

  @freyja_site.detail_panel_page.restore_all_files_section.restore_all_files(@restore)

end