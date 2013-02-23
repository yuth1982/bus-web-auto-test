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

When /^go to transfer resources and change the number of devices:$/ do |resource_table|
  attributes = resource_table.hashes.first
  source = attributes["source_group"] || "(default user group)"
  target = attributes["target_group"] || "(default user group)"
  server_device = attributes["server_device"] || 0
  desktop_device = attributes["desktop_device"] || 0  
  
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['transfer_resources'])
  @bus_site.admin_console_page.transfer_resources_section.transfer_resources(source, target, server_device, 0, desktop_device, 0)
  
  @bus_site.admin_console_page.transfer_resources_section.messages.should == "Resources transferred from the #{source} user group to the #{target} user group."
  
  #Update resources of user_group instance (user centric) 
  unless @user_group.nil?
    if @user_group.name == target 
      @user_group.desktop_device += server_device.to_i
      @user_group.server_device += desktop_device.to_i
    end
  end
end