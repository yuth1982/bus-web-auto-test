# Public: Create a new partner
#
# MozyPro available column names:
# | # licenses | quota | # server licenses | server quota | # desktop licenses | desktop quota |
#
When /^I add a new user:$/ do |user_table|
  @bus_site.admin_console_page.click_link(Bus::MENU[:add_new_user])
  @user = Bus::DataObj::User.new
  attributes = user_table.hashes.first
  @user.num_server_licenses = attributes["# server licenses"] || 0
  @user.server_quota = attributes["server quota"] || 0
  @user.num_desktop_licenses = attributes["# desktop licenses"] || 0
  @user.desktop_quota = attributes["desktop quota"] || 0
  @bus_site.admin_console_page.add_new_user_section.add_new_user(@user)
end

Then /^New user should be created$/ do
  @bus_site.admin_console_page.add_new_user_section.messages.should == "Created new user #{@user.email}"
end

Then /^New user created message should be (.+)$/ do |message|
  @bus_site.admin_console_page.add_new_user_section.messages.should == message
end