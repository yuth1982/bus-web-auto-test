
When /^I assign a key in user group (.+) with email (.+)$/ do |user_group, email|
  @test_email = email
  @bus_site.admin_console_page.navigate_to_link(Bus::MENU[:assign_keys])
  @bus_site.admin_console_page.manage_resources_section.select_group(user_group)
  @bus_site.admin_console_page.manage_resources_section.assign_key(@test_email)
end

When /^Key should be assigned$/ do
  @bus_site.admin_console_page.manage_resources_section.messages.should == "1 key has been assigned and emailed."
end

When /^I assign MozyPro allocated quota to (\d+) GB$/ do |new_quota|
  @bus_site.admin_console_page.click_link(Bus::MENU[:manage_resources])
  @bus_site.admin_console_page.manage_resources_section.assign_mozypro_storage(new_quota)
end

Then /^MozyPro resource quota should be changed$/ do
  @bus_site.admin_console_page.manage_resources_section.messages.should == "Quota changed."
end

# total storage, unallocated storage, enable server
#
#
Then /^MozyPro resource general information should be:$/ do |info_table|

  attributes = info_table.hashes.first
  total = attributes["total storage"] || ""
  unallocated = attributes["unallocated storage"] || ""
  enable_server = attributes["enable server"] || ""

  @bus_site.admin_console_page.manage_resources_section.mozypro_total_storage.should == total unless total.empty?
  @bus_site.admin_console_page.manage_resources_section.mozypro_unallocated_storage.should == unallocated unless unallocated.empty?
  @bus_site.admin_console_page.manage_resources_section.mozypro_enable_server.should == add_on unless enable_server.empty?

end