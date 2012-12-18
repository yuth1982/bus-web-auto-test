# Public: Create a new partner
#
# User available column names:
# | user group | server licenses | server quota | desktop licenses | desktop quota |
#
When /^I add a new user:$/ do |user_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['add_new_user'])

  @user = Bus::DataObj::User.new
  attributes = user_table.hashes.first
  @user.user_group = attributes["user group"]
  @user.name = attributes["name"] unless attributes["name"].nil?
  @user.email = attributes["email"] unless attributes["email"].nil?
  @user.server_licenses = attributes["server licenses"]
  @user.server_quota = attributes["server quota"]
  @user.desktop_licenses = attributes["desktop licenses"]
  @user.desktop_quota = attributes["desktop quota"]
  @user.enable_stash = (attributes["enable stash"] || "no").eql?("yes")
  @user.stash_quota = attributes["stash quota"]
  @user.send_stash_invite = (attributes["send stash invite"] || "no").eql?("yes")
  @bus_site.admin_console_page.add_new_user_section.add_new_user(@user)
end

Then /^New user should be created$/ do
  @bus_site.admin_console_page.add_new_user_section.messages.should == "Created new user #{@user.email}"
end

Then /^New user created message should be (.+)$/ do |message|
  @bus_site.admin_console_page.add_new_user_section.messages.gsub("\n"," ").should == message
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