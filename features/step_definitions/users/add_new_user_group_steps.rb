# Public: Create a new partner
#
# User Group available column names:
# | name | billing code | default server quota | default desktop quota |
#
When /^I add a new user group:$/ do |user_table|
  @bus_site.admin_console_page.click_link(Bus::MENU[:add_new_user_group])
  @user_group = Bus::DataObj::UserGroup.new
  attributes = user_table.hashes.first
  @user_group.name = attributes["name"] unless attributes["name"].nil?
  @user_group.billing_code = attributes["billing code"] || ""
  @user_group.default_server_quota = attributes["default server quota"] || 2
  @user_group.default_desktop_quota = attributes["default desktop quota"] || 2
  @bus_site.admin_console_page.add_new_user_group_section.add_new_user_group(@user_group)
end

Then /^New user group should be created$/ do
  @bus_site.admin_console_page.add_new_user_group_section.messages.should == "Created new user group #{@user_group.name}"
end

