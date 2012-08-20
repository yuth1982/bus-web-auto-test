When /^I assign MozyPro allocated quota to (\d+) GB$/ do |new_quota|
  step "I navigate to Manage Resources section from bus admin console page"
  @bus_admin_console_page.manage_resources_section.assign_mozypro_storage(new_quota)
end

Then /^MozyPro resource quota should be changed$/ do
  @bus_admin_console_page.manage_resources_section.messages.should == "Quota changed."
end


# total storage, unallocated storage, enable server
#
#
Then /^MozyPro resource general information should be:$/ do |info_table|

  attributes = info_table.hashes.first
  total = attributes["total storage"] || ""
  unallocated = attributes["unallocated storage"] || ""
  enable_server = attributes["enable server"] || ""

  @bus_admin_console_page.manage_resources_section.mozypro_total_storage.should == total unless total.empty?
  @bus_admin_console_page.manage_resources_section.mozypro_unallocated_storage.should == unallocated unless unallocated.empty?
  @bus_admin_console_page.manage_resources_section.mozypro_enable_server.should == add_on unless enable_server.empty?

end