# Public: Create a new partner
#
# User available column names:
# | user group |
#
When /^I add (\d+) new user:$/ do |num_users, user_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['add_new_user'])
  cells = user_table.hashes.first
  @new_user = Bus::DataObj::User.new
  # Use page default value if you don't specific a column
  @new_user.user_group = cells['user group']
  @new_user.name = cells['name'] unless cells['name'].nil?
  @new_user.email = cells['email'] unless cells['email'].nil?
  @new_user.storage_type = cells['storage type']
  @new_user.storage_max = cells['storage max']
  @new_user.devices = cells['devices']
  @new_user.enable_stash = cells['enable stash']
  @new_user.send_email = cells['send email']
  @bus_site.admin_console_page.add_new_user_section.add_new_users(@new_user, num_users)
end

Then /^(\d+) new user should be created$/ do |num|
  @bus_site.admin_console_page.add_new_user_section.success_messages.should == "Successfully created #{num} user(s)"
end

Then /^New user created message should be (.+)$/ do |message|
  @bus_site.admin_console_page.add_new_user_section.sucess_messages.gsub("\n"," ").should == message
end

When /^I refresh Add New User section$/ do
  @bus_site.admin_console_page.add_new_user_section.refresh_bus_section
end

Then /^I should not see stash options$/ do
  @bus_site.admin_console_page.add_new_user_section.has_save_changes_btn?
  @bus_site.admin_console_page.add_new_user_section.has_no_content?('Enable Stash:').should be_true
  @bus_site.admin_console_page.add_new_user_section.has_no_content?('Send Stash Invite:').should be_true
  @bus_site.admin_console_page.add_new_user_section.has_no_content?('Desired Storage for Stash:').should be_true
end

Then /^I should see stash options$/ do
  @bus_site.admin_console_page.add_new_user_section.has_save_changes_btn?
  @bus_site.admin_console_page.add_new_user_section.has_content?('Enable Stash:').should be_true
  @bus_site.admin_console_page.add_new_user_section.has_content?('Send Stash Invite:').should be_true
  @bus_site.admin_console_page.add_new_user_section.has_content?('Desired Storage for Stash:').should be_true
end

Then /^desktop and server devices should not be displayed in Add New User module$/ do
  @bus_site.admin_console_page.add_new_user_section.has_desktop_device_lbl?.should be_false
  @bus_site.admin_console_page.add_new_user_section.has_server_device_lbl?.should be_false
  @bus_site.admin_console_page.add_new_user_section.has_content?('Desktop Devices').should be_false
  @bus_site.admin_console_page.add_new_user_section.has_content?('Server Devices').should be_false
end

Then /^desktop and server devices should be displayed in Add New User module$/ do
  @bus_site.admin_console_page.add_new_user_section.has_desktop_device_lbl?.should be_true
  @bus_site.admin_console_page.add_new_user_section.has_server_device_lbl?.should be_true
  @bus_site.admin_console_page.add_new_user_section.has_content?('Desktop Devices').should be_true
  @bus_site.admin_console_page.add_new_user_section.has_content?('Server Devices').should be_true
end

When /^I note the desktop and server amounts in Add New User module for user group (.+)$/ do |user_group|
  @bus_site.admin_console_page.add_new_user_section.select_user_group(user_group)
  @bus_site.admin_console_page.add_new_user_section.wait_until_bus_section_load
   if @user_group.nil?
     @user_group = Bus::DataObj::UserGroup.new
     @user_group.name = user_group
     @user_group.desktop_device = @bus_site.admin_console_page.add_new_user_section.desktop_device.to_i
     @user_group.server_device = @bus_site.admin_console_page.add_new_user_section.server_device.to_i
   else
     # "Available:" device and storage calculations happen after frame load
     @user_group.desktop_device.should == @bus_site.admin_console_page.add_new_user_section.desktop_device.to_i 
     @user_group.server_device.should == @bus_site.admin_console_page.add_new_user_section.server_device.to_i 
   end
end

Then /^the user groups should not be visible in the Add New User module$/ do
  @bus_site.admin_console_page.add_new_user_section.user_group_search_select_visible?.should be_false
  @bus_site.admin_console_page.add_new_user_section.has_add_group_link?.should be_false
  @bus_site.admin_console_page.add_new_user_section.has_content?('Choose a Group:').should be_false
end

When /^I choose (.+) from Choose a Group$/ do |user_group|
  @bus_site.admin_console_page.add_new_user_section.select_user_group(user_group)
end

Then /^the Buy More link should be visible$/ do
  @bus_site.admin_console_page.add_new_user_section.has_buy_more_link?.should be_true
end

Then /^the Buy More link should open the Change Plan module$/ do
  @bus_site.admin_console_page.add_new_user_section.click_buy_more_link
  @bus_site.admin_console_page.change_plan_section.section_visible?
end

Then /^the Add More link should be visible$/ do
  @bus_site.admin_console_page.add_new_user_section.has_add_more_link?.should be_true
end

Then /^the Add More link should open the Manage Resources module$/ do
  @bus_site.admin_console_page.add_new_user_section.click_add_more_link
  @bus_site.admin_console_page.manage_resources_section.section_visible?
end

Then /^the Add More link should open the Change Plan module$/ do
  @bus_site.admin_console_page.add_new_user_section.click_add_more_link
  @bus_site.admin_console_page.change_plan_section.section_visible?
end