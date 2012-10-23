# Public: Create a new partner
#
# User available column names:
# | user group | server licenses | server quota | desktop licenses | desktop quota |
#
When /^I add a new user:$/ do |user_table|
  @bus_site.admin_console_page.navigate_to_link(CONFIGS['bus']['menu']['add_new_user'])

  unless @user_group.nil?
    user_table.map_column!('user group') do |value|
      value.gsub(/@the_new_group/,@user_group.name)
    end
  end

  @user = Bus::DataObj::User.new
  attributes = user_table.hashes.first
  @user.name = attributes["name"] unless attributes["name"].nil?
  @user.user_group = attributes["user group"] unless attributes["user group"].nil?
  @user.server_licenses = attributes["server licenses"] || 0
  @user.server_quota = attributes["server quota"] || 0
  @user.desktop_licenses = attributes["desktop licenses"] || 0
  @user.desktop_quota = attributes["desktop quota"] || 0
  @bus_site.admin_console_page.add_new_user_section.add_new_user(@user)
end

Then /^New user should be created$/ do
  @bus_site.admin_console_page.add_new_user_section.messages.should == "Created new user #{@user.email}"
end

Then /^New user created message should be (.+)$/ do |message|
  @bus_site.admin_console_page.add_new_user_section.messages.should == message
end