#| server licences | server quota GB | desktop licences | desktop quota GB |
#| 10              | 50              | 5                | 25               |
When /^I transfer resources from (.+) to (.+) with:$/ do |source, target, resources_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['transfer_resources'])
  attributes = resources_table.hashes.first
  @source_group = source
  @target_group = target
  @server_licenses = attributes["server licenses"] || 0
  @server_quota = attributes["server quota GB"] || 0
  @desktop_licenses = attributes["desktop licenses"] || 0
  @desktop_quota = attributes["desktop quota GB"] || 0
  @bus_site.admin_console_page.transfer_resources_section.transfer_resources(@source_group,@target_group,@server_licenses, @server_quota, @desktop_licenses, @desktop_quota)
end

Then /^Resources should be transferred$/ do
  @bus_site.admin_console_page.transfer_resources_section.messages.should == "Resources transferred from the #{@source_group} user group to the #{@target_group} user group."
end
