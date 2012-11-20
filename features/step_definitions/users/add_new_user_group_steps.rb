
# Public: Create a new user group
#
# User Group available column names:
# | name | billing code | server quota | desktop quota | stash quota |
#
When /^I add a new user group:$/ do |user_table|
  @bus_site.admin_console_page.navigate_to_link(CONFIGS['bus']['menu']['add_new_user_group'])
  @user_group = Bus::DataObj::UserGroup.new
  attributes = user_table.hashes.first
  @user_group.name = attributes['name']
  @user_group.billing_code = attributes['billing code']
  @user_group.server_quota = attributes['server quota']
  @user_group.desktop_quota = attributes['desktop quota']
  @user_group.stash_quota = attributes['stash quota']
  @bus_site.admin_console_page.add_new_user_group_section.add_new_user_group(@user_group)
end

Then /^New user group should be created$/ do
  @bus_site.admin_console_page.add_new_user_group_section.messages.should == "Created new user group #{@user_group.name}"
end

Then /^I can see help icon for default stash storage$/ do
  @bus_site.admin_console_page.add_new_user_group_section.help_icon_visible?.should be_true
end

Then /^Defaut stash storage help message should be (.+)$/ do |messages|
  @bus_site.admin_console_page.add_new_user_group_section.help_icon_messages.should == messages
end

Then /^I should not see (.+) text on add new user group section$/ do |text|
  @bus_site.admin_console_page.add_new_user_group_section.has_save_changes_btn?
  @bus_site.admin_console_page.add_new_user_group_section.has_no_content?(text).should be_true
end