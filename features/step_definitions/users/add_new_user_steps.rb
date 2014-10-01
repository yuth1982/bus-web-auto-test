# If you are create one user: You can specify user name and email
# If you are create more than on users: User names and emails are random
#
# available columns:
# name, email, user_group, storage_type, storage_max, devices, enable_stash, send_email
When /^I add new user\(s\):$/ do |user_table|
  user_table.hashes.each do |hash|
    hash['email'] = @existing_user_email if hash['email'] == '@existing_user_email'
    hash['email'] = @existing_admin_email if hash['email'] == '@existing_admin_email'
  end

  add_users(user_table.hashes)
end

# If you are create one user: You can specify user name and email
# If you are create more than on users: User names and emails are random
#
# available columns:
# name, email, user_group, storage_type, storage_max, devices, enable_stash, send_email
When /^I add new itemized user\(s\):$/ do |itemized_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['add_new_user'])
  @new_users =[]
  itemized_table.hashes.each do |hash|
    user = Bus::DataObj::ItemizedUser.new
    hash_to_object(hash, user)
    @new_users << user
  end
  @bus_site.admin_console_page.add_new_itemized_user_section.add_new_itemized_users(@new_users)
end

Then /^(\d+) new user should be created$/ do |num|
  add_users_success_message(num)
end

Then /^new itemized user should be created$/ do
  @bus_site.admin_console_page.add_new_itemized_user_section.new_user_creation_success(@new_users)
end

Then /^Add new user error message should be:$/ do |messages|
  @bus_site.admin_console_page.add_new_user_section.wait_until_bus_section_load
  @bus_site.admin_console_page.add_new_user_section.error_messages.should == messages.to_s
end

Then /^User group storage details table should be:$/ do |ug_table|
  @bus_site.admin_console_page.add_new_user_section.wait_until_bus_section_load
  @bus_site.admin_console_page.add_new_user_section.ug_resource_details_table_rows.should == ug_table.raw
end

When /^I refresh Add New User section$/ do
  @bus_site.admin_console_page.add_new_user_section.refresh_bus_section
end

Then /^I should not see stash options$/ do
  @bus_site.admin_console_page.add_new_user_section.has_stash_option?.should be_false
end

Then /^I should see stash options$/ do
  @bus_site.admin_console_page.add_new_user_section.has_stash_option?.should be_true
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
     @user_group = Bus::DataObj::ItemizedUserGroup.new
     @user_group.name = user_group
     @user_group.desktop_devices = @bus_site.admin_console_page.add_new_user_section.desktop_device.to_i
     @user_group.server_devices = @bus_site.admin_console_page.add_new_user_section.server_device.to_i
   else
     # "Available:" device and storage calculations happen after frame load
     @user_group.desktop_devices.should == @bus_site.admin_console_page.add_new_user_section.desktop_device.to_i
     @user_group.server_devices.should == @bus_site.admin_console_page.add_new_user_section.server_device.to_i
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
  @bus_site.admin_console_page.change_plan_section.wait_until_bus_section_load
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

When /^I view latest created user details$/ do
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_users'])
  @bus_site.admin_console_page.search_list_users_section.view_user_details((@new_users.last.email).slice(0,27))
end

And /^I add a new user and activate a machine for him$/ do |table|
#  step %{And I add new user(s):}, table(%{
#    | name          | user_group           | storage_type | storage_limit | devices |
#    | TC.16266.User | (default user group) | Desktop      | 50            | 3       |
#  })
  header = table.headers[0..-2].join('|')
  row = table.rows.first[0..-2].join('|')
  step %{I add new user\(s\):}, table(%{
    |#{header}|
    |#{row}|
  })
  step %{1 new user should be created}
  step %{I search user by:}, table(%{
    | keywords   |
    | @user_name |
  })
  step %{I view user details by newly created user email}
  step %{I update the user password to default password}
  machine_type = table.hashes.first['storage_type']
  machine_name = table.hashes.first['machine_name']
  step %{I use keyless activation to activate devices}, table(%{
    | user_email  | machine_name    | machine_type    | partner_name  |
    | @user_email | #{machine_name} | #{machine_type} | @partner_name |
  })
  step %{I close the user detail page}
end

And /^I add some new users and activate one machine for each$/ do |table|
  header = table.headers.join('|')
  table.rows.each do |row|
    step %{I add a new user and activate a machine for him}, table(%{
      |#{header}|
      |#{row.join('|')}|
    })
  end
end
