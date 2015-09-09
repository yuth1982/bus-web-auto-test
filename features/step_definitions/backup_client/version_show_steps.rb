And /^I click (General|Brandings) tab of version details$/ do |tab_name|
  @bus_site.admin_console_page.version_show_section.select_tab(tab_name)
end

Then /^the version general info should be:$/ do |version_details|
  actual = @bus_site.admin_console_page.version_show_section.version_general_info_hash
  expected = version_details.hashes.first
  expected.keys.each{ |key| actual[key].should == expected[key] }
end

And /^I upload file (.+) for the windows version$/ do |file|
  @bus_site.admin_console_page.version_show_section.upload_db3(file)
end

Then /^I can find the version branding info:$/ do |table|
  actual = @bus_site.admin_console_page.version_show_section.version_branding_table_text
  expected = table.raw
  expected.each{ |key| (actual.include?(key)).should be_true}
end

And /^I upload executable (.+) for partner (.+)$/ do |exec, partner|
  @bus_site.admin_console_page.version_show_section.replace_executable(partner, exec)
end

And /^I save changes for the version$/ do
  @bus_site.admin_console_page.version_show_section.save_changes
end

Then /^the download link for partner (.+) should be generated$/ do |partner|
  @bus_site.admin_console_page.version_show_section.download_link_present?(partner).should  be_true
end

And /^I change version status to (enabled|disabled|limited)$/ do |status|
  @bus_site.admin_console_page.version_show_section.change_status(status)
end

Then /^version info should be changed successfully$/ do
  @bus_site.admin_console_page.version_show_section.version_saved_success_message.should == "Changes saved successfully"
end

When /^I close version details section$/ do
  @bus_site.admin_console_page.version_show_section.close_bus_section
end

When /^I refresh version details section$/ do
  @bus_site.admin_console_page.version_show_section.refresh_bus_section
end