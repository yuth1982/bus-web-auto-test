# Public: Create a new partner
#
# User available column names:
# | user group | server licenses | server quota | desktop licenses | desktop quota |
#
When /^I add a new user to a (MozyPro||Reseller||MozyEnterprise||Itemized) partner:$/ do |type, user_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['add_new_user'])

  @user = Bus::DataObj::User.new
  attributes = user_table.hashes.first
  @user.user_group = attributes["user group"] unless attributes["user group"].nil?
  @user.name = attributes["name"] unless attributes["name"].nil?
  @user.email = attributes["email"] unless attributes["email"].nil?
  @user.user_type = attributes["user type"] unless attributes["user type"].nil?
  @user.server_licenses = attributes["server licenses"] unless attributes["server licenses"].nil?
  @user.server_quota = attributes["server quota"] unless attributes["server quota"].nil?
  @user.desktop_licenses = attributes["desktop licenses"] unless attributes["desktop licenses"].nil?
  @user.desktop_quota = attributes["desktop quota"] unless attributes["desktop quota"].nil?
  @user.desired_user_storage = attributes["desired_user_storage"] unless attributes["desired_user_storage"].nil?
  @user.device_count = attributes["device_count"] unless attributes["device_count"].nil?
  @user.enable_stash = (attributes["enable stash"] || "no").eql?("yes")
  @user.stash_quota = attributes["stash quota"] unless attributes["stash quota"].nil?
  @user.send_stash_invite = (attributes["send stash invite"] || "no").eql?("yes")

  case type
    when "Itemized"
      @bus_site.admin_console_page.add_new_user_section.add_new_user_to_itemized_partner(@user)
    when "MozyPro", "Reseller"
      @bus_site.admin_console_page.add_new_user_section.add_new_user_to_partner(@user)
    when "MozyEnterprise"
      @bus_site.admin_console_page.add_new_user_section.add_new_user_to_enterprise_partner(@user)
  end


end

Then /^New user should be created$/ do
  @bus_site.admin_console_page.add_new_user_section.success_messages.should == "Successfully created 1 user(s)"
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
  @bus_site.admin_console_page.add_new_user_section.has_user_group_search_select?.should be_false
end

When /^I choose (.+) from Choose a Group$/ do |user_group|
  @bus_site.admin_console_page.add_new_user_section.select_user_group(user_group)
end